module MyFirstProject

export calculate_age_in_years, calculate_age_group

using Dates     # Import the Dates package

function calculate_age_in_years(startdate::Date, enddate::Date)
    d     = enddate - startdate
    ndays = d.value
    round(Int, ndays / 365.25)
end

calculate_age_group(age::Missing, width, largest_lowerbound) = missing

function calculate_age_group(age::Real, width, largest_lowerbound)
    if age < -0.75    # Age prior to conception
         missing
    elseif age < 0.0  # Person is not yet born
         "unborn"
    else              # Person is born
         lowerbound = Int(width * div(age, width))
         lowerbound >= largest_lowerbound && return "$(largest_lowerbound)+"
         upperbound = Int(lowerbound + width - 1)
         "$(lowerbound) to $(upperbound)"
    end
end

end
