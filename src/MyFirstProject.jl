module MyFirstProject

export calculate_age_in_years, calculate_age_group  # Make these functions available outside the project without specifying the module name

using Dates     # Import the Dates package

"Calculates the time elapsed between startdate and enddate, rounded to the nearest whole number of years."
function calculate_age_in_years(startdate::Date, enddate::Date)
    d     = enddate - startdate
    ndays = d.value
    round(Int, ndays / 365.25)
end

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

end
