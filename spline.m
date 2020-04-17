function [yy] = spline(i, x_points)
% Function Spline returns i base spline function S1(n, 0), defined on
% points from x_points vector.

n = length(x_points);
yy = @(x) y(x);
    function[y_val] = y(x)
        if(i==1)
            if( x_points(1)<=x&& x<=x_points(2)) 
                y_val = (x_points(2)-x)/(x_points(2)-x_points(1));
            else
                y_val = 0;
            end
        elseif(i==n)
            if(x_points(n-1)<=x && x<=x_points(n))
                y_val = (x-x_points(n-1))/(x_points(n)-x_points(n-1));
            else
                y_val = 0;
            end
        else
            if(x_points(i-1)<=x && x<=x_points(i))
                y_val = (x-x_points(i-1))/(x_points(i)-x_points(i-1));
            elseif(x_points(i)<=x && x<=x_points(i+1))
                y_val = (x_points(i+1)-x)/(x_points(i+1)-x_points(i));
            else
                y_val = 0;
            end
        end
    end     
end
