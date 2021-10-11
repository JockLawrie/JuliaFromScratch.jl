#=
  To run this script:
  1. Open PowerShell
  2. Navigate to the project directory by typing (modify the path as required):

       cd C:\\Users\username\code\MyFirstProject

  3. Run the script:

       julia scripts\explore_iris_data.jl
=#

# Import required functions
using Pkg
Pkg.activate(".")
Pkg.instantiate()  # Fetch any dependencies that you don't already have (once-off, may take a few minutes)

using CSV
using DataFrames
using RDatasets
using Statistics

# Data
data    = dataset("datasets", "iris")
outfile = tempname()
CSV.write(outfile, data)
data = CSV.read(outfile, DataFrame)

# Basic statistics
size(data)
names(data)
first(data, 5)
last(data, 5)
describe(data)

# View/subset where Species is "setosa"
unique(data.Species)
v = view(data, data.Species .== "setosa", :)
v[1:5, :]
describe(v)

# Basic statistics grouped by Species
bySpecies = groupby(data, :Species)  # Splits data into 3 views
bySpecies[1]
bySpecies[2]
bySpecies[3]
smry = combine(bySpecies, nrow, :SepalLength => mean, :SepalWidth => mean, :PetalLength => mean, :PetalWidth => mean)

# Sorting
sort!(data, "Species")  # Sort by 1 column
sort!(data, ["Species", "SepalLength"])  # Sort by multiple columns