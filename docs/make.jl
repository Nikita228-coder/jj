using Pervii
using Documenter

DocMeta.setdocmeta!(Pervii, :DocTestSetup, :(using Pervii); recursive=true)

makedocs(;
    modules=[Pervii],
    authors="Nikita",
    repo="https://github.com/NikitaKutelev/Pervii.jl/blob/{commit}{path}#{line}",
    sitename="Pervii.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://NikitaKutelev.github.io/Pervii.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/NikitaKutelev/Pervii.jl",
)
