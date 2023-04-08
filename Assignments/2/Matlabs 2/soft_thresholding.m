function [x_thr] = soft_thresholding(y, lambda)
% Write one implementation that works both for y being real and complex.
x_thr = zeros(length(y),1);

for i=1:length (y)
    if(abs(y(i))>lambda)
      x_thr(i) = ((abs(y(i))-lambda)*y(i))/(abs(y(i)));
    end
end
end
