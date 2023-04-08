function [x_hat_new] = ISTA(X, A, lambda, beta, eps)
% X is the (non-zero-filled) undersampled Fourier measurement. 
% A is the subsampling matrix

i = 0;
N = length(X);
F = dftmtx(N);
x_hat_prev = 4*ifft(transpose(A)*A*X);  % check that this is correct

%while (i == 0 || norm(x_hat_prev- x_hat_new,2)>eps)
while (i == 0 || norm(x_hat_prev- x_hat_new,2)>eps)

    % Gradient update step
 %   grad = beta* F'*(transpose(A)*A*F*x_hat_prev - X);
    grad = ifft(beta*(transpose(A))*(A*F*x_hat_prev - A*X));
    %grad_time = ifft(grad);
    % Soft-thresholding
    x_hat_new = soft_thresholding(x_hat_prev - grad, lambda);
    i = i + 1;
    
    x_hat_prev = x_hat_new;
    x_hat_prev = transpose(x_hat_prev);
    
    % Use this plot for debugging, but comment it out if you want quicker
    % running.
    subplot(2,1,2)
     stem(x_hat_new)    
     title('x_{hat}')
    pause(.1)
    
end