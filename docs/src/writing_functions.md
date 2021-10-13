# Write some functions

In this example we define our own functionality and work with data that includes dates.

## Add a package programatically

First let's add the `Dates` package to the project, so that we can use the functinality that is provides. See the [Dates](https://docs.julialang.org/en/v1/stdlib/Dates/) package in Julia's standard library for details of the available functionality. Open Julia and type the following:

```julia
cd("C:\\Users\\username\\code\\MyFirstProject")  # Navigate to the project directory (alter as required).
using Pkg          # Import the Pkg package, which is in Julia's standard library.
Pkg.activate(".")  # Set the current directory as the active directory.
Pkg.add("Dates")   # Make the Dates package available to this project.
```

Note that this is different way of adding a package to a project. Previously we interactively entered `pkg` mode and manually added the required packages. Here we have used the `Pkg` package from the standard library and added the `Dates` package programmatically.

## Create a new script

Create a new file in the `scripts` directory called `working_with_dates.jl`, and put the following code in it:

``` julia
# Get started
using Pkg          # Import the Pkg package, which is in Julia's standard library.
Pkg.activate(".")  # Set the current directory as the active directory.
Pkg.instantiate()  # Fetch any dependencies that you don't already have (Julia uses Manifest.toml to do this)

# Import required packages
using DataFrames  # For manipulating tabular data in memory.
using Dates       # A standard library package for manipulating dates.
using Statistics  # For computing basic descriptive statistics such as means and variances.

# Create data
npeople    = 100  # Number of people in our fake data
dob_range  = Date(1900, 1, 1):Day(1):Date(1920, 12, 31)  # All dates from 1/1/1900 to 31/12/1920 inclusive
birthdates = rand(dob_range, npeople)   # 100 random dates drawn from dob_range
age_range  = -5:1:95                    # All ages (in whole years) from -5 to 95 years
ages       = rand(age_range, npeople)   # 100 random ages drawn from age_range
eventdates = birthdates .+ Year.(ages)  # For each person, the date of some event occurs at the age given by the ages column
data       = DataFrame(birthdate=birthdates, eventdate=event_dates)  # Collect columns into a DataFrame

# Calculate each person's age in years
data[!, "age_in_years"] = calculate_age_in_years.(data.birthdate, data.eventdate)
```

Note the use of the `.` operator in the definition of `eventdates` in the 3rd last line. When a `.` is included with a function call, it tells Julia to apply the function to all elements of a vector. This is known as __broadcasting__. In this line the `.` appears twice. First, the `Year` function is applied to each age in the `ages` column. For a person who is 10 years old for example, this defines a period of 10 years. Then the periods are added to the birthdates. For each person, the resulting event date is x years after the birth date, where x is the person's age in years.

The last line has a few interesting features:

- A new column of the data is defined, and is called `age_in_years`.
- On the right side of the equation columns are also referenced with the `tablename.colname` notation.
- The broadcast operator (`.`) is used to apply the function `calculate_age_in_years` to each row of the columns `birthdate` and `eventdate`.

Open Julia and run these lines one by one. Note that the last line fails, and returns an `UndefVarError`, which indicates that the function `calculate_age_in_years` is not defined. Indeed, this function does not exist in any of the packages imported at the start of the script. We have to write it ourselves.

## Your first function

__We aim for our project structure to have functions defined in files contained in the `src` directory, and code that uses these functions to be contained in the `scripts` directory.__

To define the `calculate_age_in_years` function, open the `MyFirstProject.jl` in the `src` directory, and replace the contents with this:

```julia
module MyFirstProject  # Module name is also the project name

export calculate_age_in_years  # Make this function available outside the project without specifying the module name

using Dates  # Import the Dates package into the MyFirstProject 

"Calculates the time elapsed between startdate and enddate, rounded to the nearest whole number of years."
function calculate_age_in_years(startdate, enddate)
    d     = enddate - startdate
    ndays = d.value
    round(Int, ndays / 365.25)
end

end  # End of module (and project) definition
```

In the script, insert the line `using MyFirstProject` anywhere before the line containing `calculate_age_in_years`. it is good practice to import `MyFirstProject` at the same time as importing the other dependencies. Try placing `using MyFirstProject` before `using Statistics`, so that the packages are imported in alphabetical order.

Now the script should run from top to bottom without any problems.

The `MyFirstProject.jl` file has a few features:

- All code is contained within a module with the same name as the project name.
- The `export` line specifies the functionality that is available to external programs without specifying the module name, including scripts like the one we are writing. Without this line we would have to include the module name whenever we use the `calculate_age_in_years` function. That is, we would have to type `MyFirstProject.calculate_age_in_years` instead of just `calculate_age_in_years` in our script. Sometimes this is desirable because then it is clear where the function is defined. Other times it's a pain to type and visually cluttering. Use your discretion here.
- The function definition has a __docstring__ immediately above it. This provides information about the function to help users. In Julia, type `using MyFirstProject` if you haven't already, then type `?calculate_age_in_years`. Notice that the docstring that you wrote appears in the REPL.
- The function arguments, `startdate` and `enddate` could be anything...dates, integers, strings and so on. In our case, we are only using dates as inputs. If you require that the only allowed inputs are dates, replace the first line of the function definition with `function calculate_age_in_years(startdate::Date, enddate::Date)`.

## Types, methods and multiple dispatch

Add the following function to `src/myFirstProject.jl`, and replace `export calculate_age_in_years` with `export calculate_age_in_years, calculate_age_group`:

```julia
"""
Calculate the age group of a person with known age.
If the age is less than negative 9 months (prior to conception), return missing.
"""
function calculate_age_group(age::Real, width, largest_lowerbound)
    if age < -0.75    # Age prior to conception is impossible. Set age group to missing.
         missing
    elseif age < 0.0  # Person exists but is not yet born
         "unborn"
    else              # Person is born
         lowerbound = Int(width * div(age, width))
         lowerbound >= largest_lowerbound && return "$(largest_lowerbound)+"  # Insert largest_lowerbound into the result string
         upperbound = Int(lowerbound + width - 1)
         "$(lowerbound) to $(upperbound)"
    end
end

calculate_age_group(age::Missing, width, largest_lowerbound) = missing
```

Note these features:

- The docstring for the `calculate_age_group` function has more than 1 line. This is achieved by encapsulating the content with triple quotes.
- Where the function returns a string, the string is constructed from variables using _string interpolation_. For example, `Today's date is $(today())` will return a string containing the value of `today()`. Use the `$(put your code here)` notation to achieve this.
- The `calculate_age_group` function appears to be defined twice. In fact it is defined differently for different __types__ of inputs. Notice that if the input age is a `missing` value (with type `Missing`), the result is also `missing`. If the input age is a real number, then the result depends on its value. Note the distinction between a variable's type and its value.
- Julia creates compiled code for each definition of the function, where each definition is known as a __method__ of the function. When Julia encounters the function call, it identifies the types of its arguments and calls the corresponding method, which runs at native speed, which is fast. This is known as __multiple dispatch__, because the selected method depends on the types of all the function's arguments. Some older languages have single dispatch, and others, such as Python and R, have no dispatch and run the same code regardless of the input. No dispatch results in slower performance or errors.
- The type `Real` includes integers and floating point numbers as subtypes. To see all direct subtypes of a type, use the `subtypes` function. For example, `subtypes(Real)` lists 4 subtypes. Then explore the subtypes of the subtypes, such as `subtypes(Integer)`, and so on.
- Similarly, the `supertype` function specifies the type that contains its argument as a subtype. E.g., `supertype(Real)`.

Now append the following code to the `working_with_dates.jl` script:

```julia
sum(abs.(data.age_in_years .- ages)) == 0  # True if the calculated ages are the same as the input ages
quantile(data.age_in_years, [0.05, 0.25, 0.5, 0.75, 0.95])

# Calculate each person's age group
data.agegroups = calculate_age_group.(data.age_in_years, 5, 85)

calculate_age_group(-3, 5, 85)
calculate_age_group(-0.5, 5, 85)
calculate_age_group(0, 5, 85)
calculate_age_group(12, 5, 85)
calculate_age_group(9999, 5, 85)
```

Run the script and observe the results.