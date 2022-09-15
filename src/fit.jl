struct ConformalRegressor
    normalized::Bool
    alphas::Vector
end


"""
fit(residuals::Vector, sigmas::Union{Vector, Nothing} = nothing)

Fit a ConformalRegressor

# Arguments

`residuals::Vector` The residuals a model
`sigmas::Union{Vector, Nothing}` An optional argument. 

# Examples
```julia-repl

res = [1,5,2,7,3,3, 7, 8, 6, 1, 6, 7, 8, 9]

fitted = fit(res)

```
"""
function fit(residuals::Vector, sigmas::Union{Vector, Nothing} = nothing)
    abs_residuals = abs.(residuals)
    if isnothing(sigmas)
       normalized = false
       alphas = reverse(sort!(abs_residuals))
    else 
        normalized = true
        alphas = reverse(sort!(abs_residuals ./ sigmas))
    end
    return ConformalRegressor(normalized, alphas)
end