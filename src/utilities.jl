Meta.parse(t::T) where {T <: Union{Token, Array{Token}}} = Meta.parse(untokenize(t))

"""
    UndefToken

An abstract type that shows if the an evaluated `Token` is defined.
"""
abstract type UndefToken end
