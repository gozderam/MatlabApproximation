function [mse] = mean_squared_error(w, g)
% Function MEAN_SQUARED_ERROR returns a scalar mse which is the value of
% mean squared error for w and v - column vectors.
mse = sum((w-g).^2)/length(w);

end