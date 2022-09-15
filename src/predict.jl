"""
predict(object::ConformalRegressor, y_hat::Vector, sigmas, confidence, y_min, y_max)

Predict a ConformalRegressor

Return A matrix with two columns

# Arguments

`object::ConformalRegressor` A ConformalRegressor
`y_hat::Vector` A vector of predicted values
`sigmas::Vector` A vector of sigmas
`confidence::AbstractFloat` The confidence level
`y_min::AbstractFloat` 
`y_max::AbstractFloat`

# Examples
```julia-repl

res = [1,5,2,7,3,3, 7, 8, 6, 1, 6, 7, 8, 9]
fitted = fit(res)
y_hat = [23, 45, 34, 43]

predict(object, y_hat, nothing, 0.9, -Inf, Inf)

```

"""
function predict(object::ConformalRegressor, y_hat::Vector, sigmas::Vector, confidence::AbstractFloat, y_min::AbstractFloat, y_max::AbstractFloat)
    intervals = zeros(length(y_hat), 2)
    alpha_index = round(Int, [(1-confidence) * (length(object.alphas) + 1)][1])

    if alpha_index >= 0
        alpha = object.alphas[alpha_index]
        if object.normalized
            intervals[:, 1] = y_hat .- alpha .* sigmas 
            intervals[:, 2] = y_hat + alpha .* sigmas
        else 
            intervals[:, 1] = y_hat .- alpha
            intervals[:, 2] = y_hat .+ alpha
        end
    else
        intervals[:, 1] = -Inf
        intervals[:, 2] = Inf
    end

    if y_min > -Inf
        intervals[intervals<y_min] = y_min
    end
    
    if y_max < Inf
        intervals[intervals>y_max] = y_max
    end
    return(intervals)
end