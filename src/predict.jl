function predict(object::ConformalRegressor, y_hat::Vector, sigmas::Union{Vector, Nothing} = nothing, confidence::Vector = 0.95, y_min::Union{Int, float}= - Inf, y_max::Union{Int, float} = Inf)
    intervals = zeros(length(y_hat), 2)
    alpha_index = round.(Int, [(1-confidence).* length(object.alphas) + 1])
    if alpha_index >= 0
        alpha = object.alphas[alpha_index]
        if object.normalized
            intervals[, 1] = y_hat .- alpha .* sigmas 
            intervals[, 2] = y_hat .+ alpha .* sigmas
        else
            intervals[, 1] = y_hat .- alpha
            intervals[, 2] = y_hat .+ alpha
        end
    else
        intervals[, 1] = -Inf
        intervals[, 2] = Inf
    end
    
    if y_min > -Inf
        intervals[intervals<y_min] = y_min
    end

    if y_max < Inf
        intervals[intervals>y_max] = y_max
    end
    return(intervals)
end