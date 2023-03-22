function [x_thr] = soft_thresholding(y, lambda)
% Write one implementation that works both for y being real and complex.
x_thr = zeros(1, length(y));

%x_thr = (abs(y)<=lambda).*0+ ~(abs(y)>lambda).*((abs(y)-lambda)/abs(y));

for i=1:length (y)
    if(abs(y(i))<=lambda)
    x_thr(i) =0;
    else
        x_thr(i) = abs(y(i))*lambda/(abs(y(i)))*y(i);
    end
end
end
