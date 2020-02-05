Meta.parse(t::T) where {T <: Union{Token, Array{Token}}} = Meta.parse(untokenize(t))

"""
    UndefToken

An abstract type that shows if the an evaluated `Token` is defined.
"""
abstract type UndefToken end

"""
    tisdefined(t)
    tisdefined(modul, t)

Check if a `Token` that represent a `Symbol` is defined. Throws error if the `Token` is representing an `Expr`.

# Examples
```julia
julia> t = collect(tokenize("Int64"))

julia> tisdefined(t)
true
```
"""
function tisdefined(modul, t::T) where {T <: Union{Token, Array{Token}}}
    pt = Meta.parse(t)
    return isdefined(modul,pt)
end

tisdefined(t::T) where {T <: Union{Token, Array{Token}}} = tisdefined(@__MODULE__, t)

tisdefined(modul, t::T) where {T <: Union{Symbol, Expr}} = isdefined(modul, t)
tisdefined(t::T) where {T <: Union{Symbol, Expr}} = isdefined(@__MODULE__, t)


"""
    tevalfast(t::T)
    tevalfast(t::T, check_isdefined::Bool=false)
    tevalfast(modul = @__MODULE__, t::T, check_isdefined::Bool=false)

Parses and evaluates a `Token` that represents a `Symbol` or `Expr` in Julia. For `Symbol` It dispatches on the fast method based on the parsed Token.

If you set `check_isdefined` to `true`, and `t` is not defined in the scope it returns `UndefToken` instead of throwing an error.

# Examples
```julia
julia> t = collect(tokenize("Int64"))

julia> tevalfast(t)
Int64
```
"""
function tevalfast(modul::Module, t::T, check_isdefined::Bool = false) where {T <: Union{Token, Array{Token}}}
    pt = Meta.parse(t)
    if check_isdefined && !(tisdefined(modul,pt))
        return UndefToken
    end
    return evalfast(modul,pt)
end

tevalfast(t::T, check_isdefined::Bool = false) where {T <: Union{Token, Array{Token}}} = tevalfast(@__MODULE__, t, check_isdefined)
