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


