module MyFirstProject

export nextday  # Make nextday available outside this package

using Dates     # Import the Dates package

"Returns: The date following the input date"
function nextday(dt::Date)
    dt + Day(1)
end

end
