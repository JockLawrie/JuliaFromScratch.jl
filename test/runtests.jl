using Test
using MyFirstProject

@testset "calculate_age_group" begin
    @test ismissing(calculate_age_group(-3, 5, 85))
    @test calculate_age_group(-0.5, 5, 85) == "unborn"
    @test calculate_age_group(0, 5, 85)    == "0 to 4"
    @test calculate_age_group(12, 5, 85)   == "10 to 14"
    @test calculate_age_group(9999, 5, 85) == "85+" 
end