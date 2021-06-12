# Julia From Scratch

This project is aimed at getting a team started with Julia without any previous experience.

1. Install Julia. You can install without admin rights.
   Download the Windows 64-bit installer from [here](https://julialang.org/downloads/).
   When installing, check the box for adding Julia to the PATH variable. This means you can type `julia` into PowerShell and it will start.
   That is, you needn't hunt for the Julia executable on your machine.

2. To get a flavour of the syntax, spend 10 minutes [here](https://learnxinyminutes.com/docs/julia/). This intro is for version 1.0.0. Although released in 2018, it is still valid code. More features have been added since, but the core features are here.

3. Start a project for learning and experimentation.
   In Julia, a project is a package (also known as a _module_), which can be thought of as a library of functions.
   Some packages are built in, such as the _Dates_ package that provides functions such as computing the number of days between 2 dates.
   The set of built-in packages is called the _standard library_, or [stdlib](https://docs.julialang.org/en/v1/stdlib/Dates/) for short.

   To start your own project, first create a folder where you'll keep your code. For example, `C:\\Users\username\code`
   
   
   Open the Julia repl (command line interface...read-evaluate-print-loop) and enter the following:

```julia
cd("C:\\Users\\username\\code")  # Navigate to where you keep your code
using Pkg                        # Make Julia’s package management functions available
Pkg.generate(“MyTestPackage”)    # Generate a new package
```

In your file explorer, look at the files now present at `C:\\Users\username\code\MyTestPackage`.
You will see some newly created files with the following structure, which is the minimum requirement for Julia packages:

```bash
Project.toml
src\MyTestPackage.jl
```

Open the `Project.toml` in any editor (e.g., Notepad) and note that this file contains information about the package.
You needn't edit this file - more  information will be automatically added as you develop the package.
Close `Project.toml`.

Open `src\MyTestPackage.jl`. It contains a main module called `MyTestPackage`, and a simple print statement.
Replace the contents of this file with the following:

```julia
module MyTestPackage

export nextday  # Make nextday available outside this package

using Dates     # Import the Dates package

"Returns: The date following the input date"
function nextday(dt::Date)
    dt + Day(1)
end
```

Our package now contains a function `nextday` which takes a `Date` as input and returns the date 1 day after the input date.
Note that it uses the `Dates` package from the standard library (`using Dates`) and makes the `nextday` function available for use by other code (`nextday`).

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
Pkg.activate(“.”)
using MyTestPackage

# Make date-related functions available, including today().
using Dates

# Use the functions
nextday(today())
nextday(Date(2021, 3, 15))
nextday(Date("2021-03-15"))
```

