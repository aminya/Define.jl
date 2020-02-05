macro cdef(str)
    _cdef(__module__, str)
end

function _cdef(str)
    :($(cdef_parse(str)))
end

function cdef_parse(str)
    tokens = collect(tokenize(str))

    # ## initialized
    # iInit = findfirst(t -> t.exactkind==Token.EQ, tokens) # checking if it is initialized
    # isInit = !isnothing(iInit)
    # if isInit
    #     evalExpr = Meta.parse(t[iInit+1:end])
    # end

    arrSize = Int64[]

    ## going through var definition tokens
    tokenNum = length(tokens)
    i=1
    while i<=tokenNum
        t = tokens[i]
        if t.kind == Tokens.WHITESPACE
            i=i+1
            continue
        # elseif i == iInit # initalization
        #     break # parssed separately
        elseif t.kind == Tokens.IDENTIFIER # Type or variable name
            if tisa(t, DataType, true)
                elType = Meta.parse(t)
            else # variable name
                var =  Meta.parse(t)
            end
        elseif t.kind == Tokens.LSQUARE # array size
            push!(arrSize, Meta.parse(tokens[i+1]))
            # assumed that syntax is correct
            i = i+3
        elseif t.exactkind==Token.EQ
            evalExpr = Meta.parse(tokens[iInit+1:end])
            break
        end
        i=i+1
    end
    return elType, var, arrSize, evalExpr
end
