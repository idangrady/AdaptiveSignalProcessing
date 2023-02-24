function [x_hat_new] = pocs(X, A, lambda, eps)
% X is the (non-zero-filled) undersampled Fourier measurement. 
% A is the subsampling matrix

% Initialize
i = 0;
x_hat_new = 0;
x_hat_prev = 0;
Fx_hat_prev = ...;
    while (i == 0 || ...>eps)

        ...

        % Soft-thresholding
        ...

        % Data consistency step
        ...
            
        i = i+1

        % Use this plot for debugging, but comment it out if you want quicker
        % running.
    %     subplot(2,1,2)
    %     stem(x_hat_new)
    %     title('x_{hat}')
    %     pause(.1)
    end
end

