# From the project directory: julia --color=yes docs/make.jl false
const GitHubPages = ARGS[1] == "true"  # true if the docs are to be deployed to GitHub Pages
using Pkg
Pkg.activate("./docs")  # pwd() is still the project directory
using Documenter
push!(LOAD_PATH,"src")
using MyFirstProject

# Set to true for GitHub pages, false for local development.
fmt = Documenter.HTML(prettyurls = GitHubPages)

# Sidebar
pages = Any[
    "Getting started"  => "index.md",
    "Create a project" => "projects.md",
    "Write a script"   => "writing_scripts.md",
    "Write some functions" => "writing_functions.md",
    "Test your code"   => "testing.md",
    "Further learning" => "further_learning.md"
]

makedocs(sitename="MyFirstProject.jl", pages=pages, format=fmt)

GitHubPages && deploydocs(repo = "github.com/JockLawrie/MyFirstProject.jl.git", devbranch = "main")