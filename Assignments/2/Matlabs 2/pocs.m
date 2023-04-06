function [x_hat_new] = pocs(X, A, lambda, eps)
% X is the (non-zero-filled) undersampled Fourier measurement. 
% A is the subsampling matrix
X0 = transpose(A)*A*X;
% Initialize
i = 0;
x_hat_new = zeros( length(X0),1);
x_hat_prev = zeros(length(X0), 1);
Fx_hat_prev = fft(x_hat_prev);
    while (i == 0 || norm((x_hat_prev-x_hat_new),2)>eps)

        % calculate the inverse Furier Transform

        inv_F_T = ifft(Fx_hat_prev);

        % Soft-thresholding
        soft_tre = soft_thresholding(inv_F_T, lambda);
        X_new = fft(soft_tre);
        % Data consistency step
        for j=1:length(X_new)
        if(X0(j,1)~=0)
         X_new(1,j) = X0(j,1);
        end
        end
            
        i = i+1;
        x_hat_prev = x_hat_new;
        x_hat_new = ifft(X_new);

        % Use this plot for debugging, but comment it out if you want quicker
        % running.
         subplot(2,1,2)
         stem(x_hat_new)
         title('x_{hat}')
         pause(.1)
    end
end

