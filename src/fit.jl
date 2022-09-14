struct ConformalRegressor
    normalized::Bool
    alphas::Vector
end

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