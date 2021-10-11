using Pkg
Pkg.activate(".")
using Documenter

push!(LOAD_PATH,"../src/")
using MyFirstProject

fmt = Documenter.HTML(prettyurls = false)  # Set to true for GitHub pages

pages = Any[
    "Getting started" => "index.md",
    "Projects => projects.md"]

makedocs(sitename="MyFirstProject.jl", pages=pages, format=fmt)