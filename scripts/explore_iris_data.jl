#=
  To run this script:
  1. Open PowerShell
  2. Navigate to the project directory by typing (modify the path as required):

       cd C:\\Users\username\code\MyFirstProject

  3. Run the script:

       julia scripts\explore_iris_data.jl
=#

# Get started
using Pkg          # Import the Pkg package, which is in Julia's standard library.
Pkg.activate(".")  # Set the current directory as the active directory.
Pkg.instantiate()  # Fetch any dependencies that you don't already have (Julia uses Manifest.toml to do this)

# Import required packages
using CSV         # For reading and writing delimted (including CSV) files.
using DataFrames  # For manipulating tabular data in memory.
using RDatasets   # Fetches the iris data set for us.
using Statistics  # For computing basic descriptive statistics such as means and variances.

# Fetch data from the web
data = dataset("datasets", "iris")   # Use the RDatasets package to fetch the iris data set

# Exercise: Read/write data
outfile = tempname()                 # Create a temporary file name
CSV.write(outfile, data)             # Write the data to a CSV file located at the temporary file location
data = CSV.read(outfile, DataFrame)  # Read the data from the CSV file

# Basic statistics
size(data)      # Number of rows and columns (nrow and ncol also work)
names(data)     # List the column names
first(data, 5)  # Display the first 5 rows
last(data, 5)   # Display the last 5 rows
describe(data)  # Basic counts and quantiles
quantile(data.SepalLength, [0.05, 0.25, 0.5, 0.75, 0.95])  # More quantiles

# View/subset where Species is "setosa"
unique(data.Species)  # List the unique values of the Species column
v = view(data, data.Species .== "setosa", :)  # Rows with Species equal to setosa
describe(v)  # Basic counts and quantiles for this view

# Basic statistics grouped by Species
bySpecies = groupby(data, :Species)  # Splits data into 3 views, 1 for each value of Species
bySpecies[1]  # Group 1: Species is setosa
bySpecies[2]  # Group 2: Species is versicolor
bySpecies[3]  # Group 3: Species is virginica
smry = combine(bySpecies, nrow, :SepalLength => mean, :SepalWidth => mean, :PetalLength => mean, :PetalWidth => mean)

# Sorting
sort!(data, "Species")  # Sort by 1 column
sort!(data, ["Species", "SepalLength"])  # Sort by multiple columns