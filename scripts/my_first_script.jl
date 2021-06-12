#=
  To run this script:
  1. Open PowerShell
  2. Navigate to the project directory by typing:

       cd C:\\Users\username\code\MyTestPackage

  3. Run the script:

       julia scripts\my_first_script.jl
=#

# Import required functions
using Pkg
Pkg.activate(".")
using MyTestPackage  # Make the nextday function available
using Dates          # Make date-related functions available, including today().

# Use the functions
nextday(today())
nextday(Date(2021, 3, 15))
nextday(Date("2021-03-15"))
