module ConformalRegressor

struct ConformalRegressor
    normalized::Bool
    alphas::Vector
end

function Fit(residuals::Vector, sigmas::Union{Vector, Nothing} = nothing)
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


function predict(object::ConformalRegressor, y_hat::Vector, sigmas::Vector, confidence::Vector, y_min::Union{Int, float}, y_max::Union{Int, float})
    
end

end
