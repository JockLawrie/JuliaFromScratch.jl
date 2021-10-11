#=
  To run this script:
  1. Open PowerShell
  2. Navigate to the project directory by typing (modify the path as required):

       cd C:\\Users\username\code\MyFirstProject

  3. Run the script:

       julia scripts\working_with_dates.jl
=#

# Import required functions
using Pkg
Pkg.activate(".")
Pkg.instantiate()  # Fetch any dependencies that you don't already have (once-off, may take a few minutes)
using MyFirstProject

using DataFrames
using Dates
using MyFirstProject
using Statistics

# https://docs.julialang.org/en/v1/stdlib/Dates/

# Create data
npeople    = 100
dob_range  = Date(1900, 1, 1):Day(1):Date(1920, 12, 31)
birthdates = rand(dob_range, npeople)
age_range  = -5:1:95
ages       = rand(age_range, npeople)
eventdates = birthdates .+ Year.(ages)
data       = DataFrame(birthdate=birthdates, eventdate=event_dates)

# Use functions defined in this package

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