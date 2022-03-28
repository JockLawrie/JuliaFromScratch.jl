#=
  To run this script:
  1. Open PowerShell
  2. Navigate to the project directory by typing (modify the path as required):

       cd C:\\Users\username\code\MyFirstProject

  3. Run the script:

       julia scripts\working_with_dates.jl
=#

# Get started
using Pkg          # Import the Pkg package, which is in Julia's standard library.
Pkg.activate(".")  # Set the current directory as the active directory.
Pkg.instantiate()  # Fetch any dependencies that you don't already have (Julia uses Manifest.toml to do this)

# Import required packages
using DataFrames  # For manipulating tabular data in memory.
using Dates       # A standard library package for manipulating dates.
using MyFirstProject  # Import the functions defined in the src directory.
using Statistics  # For computing basic descriptive statistics such as means and variances.

# Create data
npeople    = 100  # Number of people in our fake data
dob_range  = Date(1900, 1, 1):Day(1):Date(1920, 12, 31)  # All dates from 1/1/1900 to 31/12/1920 inclusive
birthdates = rand(dob_range, npeople)   # 100 random dates drawn from dob_range
age_range  = -5:1:95                    # All ages (in whole years) from -5 to 95 years
ages       = rand(age_range, npeople)   # 100 random ages drawn from age_range
eventdates = birthdates .+ Year.(ages)  # For each person, the date of some event occurs at the age given by the ages column
data       = DataFrame(birthdate=birthdates, eventdate=eventdates)  # Collect columns into a DataFrame

# Calculate each person's age in years
data[!, "age_in_years"] = calculate_age_in_years.(data.birthdate, data.eventdate)
sum(abs.(data.age_in_years .- ages)) == 0  # True if the calculated ages are the same as the input ages
quantile(data.age_in_years, [0.05, 0.25, 0.5, 0.75, 0.95])

# Calculate each person's age group
data.agegroups = calculate_age_group.(data.age_in_years, 5, 85)

calculate_age_group(-3, 5, 85)
calculate_age_group(-0.5, 5, 85)
calculate_age_group(0, 5, 85)
calculate_age_group(12, 5, 85)
calculate_age_group(9999, 5, 85)
