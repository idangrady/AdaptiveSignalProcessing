function [x_hat_new] = ISTA(X, A, lambda, beta, eps)
% X is the (non-zero-filled) undersampled Fourier measurement. 
% A is the subsampling matrix

F = dftmtx(length(X));
x_hat_prev = 4*ifft(transpose(A)*A*X);
x_hat_new = zeros(size(x_hat_prev));

i=0;
while (i==0 ||norm(x_hat_prev - x_hat_new) > eps)
    x_hat_prev = x_hat_new;
    % Gradient update step
% Option 1
    grad = (beta* F' *(transpose(A))*(A*F*x_hat_prev - A*X));
% Option 2
   % grad = (beta* length(X)*ifft((transpose(A))*(A*F*x_hat_prev - A*X)));
   % Soft-thresholding
    x_hat_new = soft_thresholding(x_hat_prev - grad, lambda);
    % Update x_hat_prev for next iteration
    i=i+1;
end

%{








function [x_hat_new] = ISTA(X, A, lambda, beta, eps)
% X is the (non-zero-filled) undersampled Fourier measurement. 
% A is the subsampling matrix

i = 0;
F = dftmtx(length(X));
x_hat_prev = 4*ifft(transpose(A)*A*X);  % check that this is correct

while (i == 0 || norm((x_hat_prev-x_hat_new),2)>eps)

    % Gradient update step
    grad = (beta* F' *(transpose(A))*(A*F*x_hat_prev - A*X));
    % Soft-thresholding
    x_hat_new = soft_thresholding(x_hat_prev - grad, lambda);
    i = i + 1;
    
    x_hat_prev = x_hat_new;
    x_hat_prev = transpose(x_hat_prev);
    
    % Use this plot for debugging, but comment it out if you want quicker
    % running.
%    subplot(2,1,2)
 %    stem(x_hat_new)    
  
 %title('x_{hat}')
 %   pause(.1)
    
end
%}