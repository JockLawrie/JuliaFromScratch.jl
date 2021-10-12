# Create a project

## What is a project?

In Julia, a __project__ is a set of files that contain some combination of functions, scripts, tests and documentation. A project needn't have all of these things. Julia expects that the files exist on the file system in the following directories:

- The `src` directory contains functions.
- The `scripts` directory contains scripts (ok this isn't standard but is reasonable practice).
- The `test` directory contains tests that check whether code is behaving as required.
- The `docs` directory contains project documentation.

## What is a package?

A __package__ is a type of project that provides reusable functionality for other projects. Loosely speaking, a package can be thought of as a library of functions.

Some packages are built in, such as the _Dates_ package that provides functions such as computing the number of days between 2 dates.
The set of built-in packages is called the _standard library_, or [stdlib](https://docs.julialang.org/en/v1/stdlib/Dates/) for short.

There are thousands of packages available outside the standard library, created by users around the world.
You can search these via Google or [JuliaHub](https://juliahub.com/ui/Home).

## Start a new project

To start your own project, first create a folder where you'll keep your code. For example, `C:\\Users\username\code`.
Open the Julia REPL (the command line interface...Read-Evaluate-Print-Loop) and enter the following:

```julia
cd("C:\\Users\\username\\code")  # Navigate to where you keep your code
using Pkg                        # Make Julia’s package management functions available
Pkg.generate("MyFirstProject")   # Generate a new package
```

In your file explorer, look at the files now present at `C:\\Users\username\code\MyFirstProject`.
You will see some newly created files with the following structure, which is the minimum requirement for a Julia project:

```bash
Project.toml
src\MyFirstProject.jl
```

Open the `Project.toml` in any editor and note that this file contains information about the project. You needn't edit this file - more  information will be automatically added as you develop the project. Close `Project.toml`.
