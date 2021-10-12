# Test your code

A _unit test_ is a comparison of a computation's output to a required result.
For example, if we have a function `add(x, y)` that adds 2 numbers, then we require that `add(2, 3)` returns 5.

A _test suite_ is a set of unit tests that we use to check whether our code still functions as required.
As our code base becomes larger and more complex, the risk of inadvertently changing the behaviour of existing functions rises.
A test suite that covers asll or most of our code gives us some reassurance that the code still behaves as required.

Julia packages contain their tests in the `test` folder in the package's root directory.
The `runtests.jl` file is the starting point for a test suite.
Here we construct a simple test suite:

1. Create a `test` directory and place an empty `runtests.jl` file inside. That is, you should have `\\path\to\MyFirstProject\test\runtests.jl`.
2. In the REPL, navigate to the project directory and then type `]`, and then `activate .\test`. This tells Julia that `\\path\to\MyFirstProject\test` is the active directory.
3. Type `add Test`. This step creates the `Project.toml` and `Manifest.toml` files specifically for the test environment. That is, the test suite can have dependencies that the package does not have. In this case we have made the `Test` package a dependency of the test environment, even though `MyFirstProject` itself does not require `Test` to function. The `Test` package is in Julia's standard library.
4. Put the following code in the `runtests.jl` file and save it.

    ```julia
    using Test
    using MyFirstProject
    
    @testset "calculate_age_group" begin
        @test ismissing(calculate_age_group(-3, 5, 85))
        @test calculate_age_group(-0.5, 5, 85) == "unborn"
        @test calculate_age_group(0, 5, 85)    == "0 to 4"
        @test calculate_age_group(12, 5, 85)   == "10 to 14"
        @test calculate_age_group(9999, 5, 85) == "85+"
    end
    ```

5. In the REPL, type `activate .`, which sets the project directory as the active directory.
6. Type `test`. The test suite should run and give an output something like this:

```
     Testing Running tests...
Test Summary:       | Pass  Total
calculate_age_group |    5      5
     Testing MyFirstProject tests passed 
```

Now you can create new test sets and add them to your test suite.
Take a look at the [Unit Testing](https://docs.julialang.org/en/v1/stdlib/Test/) section of the Julia manual for further testing functionality that the `Test` package provides.