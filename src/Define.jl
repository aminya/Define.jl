module Define

using Tokenize

include("utilities.jl")

export @cdef
include("Cdef.jl")

end
