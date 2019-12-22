using Define
using Documenter

makedocs(;
    modules=[Define],
    authors="Amin Yahyaabadi",
    repo="https://github.com/aminya/Define.jl/blob/{commit}{path}#L{line}",
    sitename="Define.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://aminya.github.io/Define.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/aminya/Define.jl",
)
