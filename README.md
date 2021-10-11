# My First Project

Get started with Julia without any previous experience.

Read the docs [here](docs/src/index.md)

We focus on manipulating tabular data that includes dates.



## Start a project for learning and experimentation

In Julia, a project is a package, which can be thought of as a library of functions.
Some packages are built in, such as the _Dates_ package that provides functions such as computing the number of days between 2 dates.
The set of built-in packages is called the _standard library_, or [stdlib](https://docs.julialang.org/en/v1/stdlib/Dates/) for short.

There are thousands of packages available outside the standard library, created by users around the world.
You can search these via Google or [JuliaHub](https://juliahub.com/lp/).

To start your own project, first create a folder where you'll keep your code. For example, `C:\\Users\username\code`.
Open the Julia REPL (the command line interface...Read-Evaluate-Print-Loop) and enter the following:

```julia
cd("C:\\Users\\username\\code")  # Navigate to where you keep your code
using Pkg                        # Make Julia’s package management functions available
Pkg.generate(“MyTestPackage”)    # Generate a new package
```

In your file explorer, look at the files now present at `C:\\Users\username\code\MyTestPackage`.
You will see some newly created files with the following structure, which is the minimum requirement for Julia a package:

```bash
Project.toml
src\MyTestPackage.jl
```

Open the `Project.toml` in any editor and note that this file contains information about the package.
You needn't edit this file - more  information will be automatically added as you develop the package.
Close `Project.toml`.

Open `src\MyTestPackage.jl`. It contains a module called `MyTestPackage`, which contains a simple print statement.
A _module_ contains some combination of functions and more modules.
It's Julia's way of constructing and organising libraries of functions.
Julia _packages_ are modules that can be used by writing `using modulename`.

Replace the contents of `src\MyTestPackage.jl` with the following code.
Note that `src\MyFirstProject` contains the same code for reference.

```julia
module MyTestPackage

export nextday  # Make nextday available outside this package

using Dates     # Import the Dates package

"Returns: The date following the input date"
function nextday(dt::Date)
    dt + Day(1)
end

end
```

Our package now contains a function `nextday` which takes a `Date` as input and returns the date 1 day after the input date.
Note that it uses the `Dates` package from the standard library (`using Dates`) and makes the `nextday` function available for use by other code (`export nextday`).

Now let's use the package. In Julia type the following:


```julia
cd("MyTestPackage")  # Navigate to the package

#=
  Search for information about the nextday function.
  None is found because Julia can't see the function.
=#
?nextday

# Make the nextday function available
using Pkg
Pkg.activate(".")
using MyTestPackage
```

Note the warning. It arises because the package code contains `using Dates`, but the `Dates` package hasn't yet been made available to our package.
To do this we have to add `Dates` to our package's list of dependencies by typing `Pkg.add("Dates")`.

The first time you do this will take a minute or 2 because Julia fetches the list of packages that are publicly available
(known as the `General` package registry). Adding further packages won't take so long.

Note that `Project.toml` now lists `Dates` as a dependency of our package.
You can see this at the REPL by typing `Pkg.status()`.

Also note the newly created `MyTestPackage\Manifest.toml` file, which is automatically generated and updated, you needn’t ever edit this file.
It lists the dependencies, and dependencies of dependencies. That is, it lists every package needed to use `MyTestPackage`.
It also lists the version numbers of each dependency.
This is helpful when copying an existing package to a new directory or a new machine – just
type `Pkg.instantiate()` and Julia will use `Manifest.toml` to fetch all dependencies with the correct versions.

Now we can use the package. Try this:

```julia
using MyTestPackage  # Make the nextday function available
?nextday             # The docstring is displayed (which we wrote above the function defintion).
?today               # No help available because the function isn't yet available to our REPL
using Dates          # Make date-related functions available, including today().
?today               # Now the REPL can see the today function

# Use the functions
nextday(today())
nextday(Date(2021, 3, 15))
nextday(Date("2021-03-15"))
```

## Scripts

Once the REPL is closed the code above is lost.
A good way to save it for reuse is to store it in a file.
Since this file only uses functions from our package and doesn't define functions,
we store it separately from our library of functions (our package).
We store it as a script in the `scripts` directory - see `my_first_scripts.jl`, which includes instructions for running the script.

## Further learning

1. To get a flavour of the syntax, spend 10 minutes [here](https://learnxinyminutes.com/docs/julia/).
   This intro is for version 1.0.0. Although released in 2018, it is still valid code.
   More features have been added since, but the core features are here.

2. Get started with data manipulation by trying some of the exercises from the [DataFrames.jl](https://dataframes.juliadata.org/stable/) documentation.
