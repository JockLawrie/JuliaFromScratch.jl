# From the docs directory: julia --color=yes make.jl
using Pkg
Pkg.activate(".")
using Documenter

push!(LOAD_PATH,"../src/")
using MyFirstProject

# Set to true for GitHub pages
fmt = Documenter.HTML(prettyurls = false)

# sidebar
pages = Any[
    "Getting started"  => "index.md",
    "Create a project" => "projects.md",
    "Write a script"   => "writing_scripts.md",
    "Write a function" => "writing_functions.md",
    "Test your code"   => "testing.md",
    "Further learning" => "further_learning.md"
]

makedocs(sitename="MyFirstProject.jl", pages=pages, format=fmt)