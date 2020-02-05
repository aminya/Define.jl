Meta.parse(t::T) where {T <: Union{Token, Array{Token}}} = Meta.parse(untokenize(t))
