function [x_hat_new] = pocs(X, A, lambda, eps)
% X is the (non-zero-filled) undersampled Fourier measurement. 
% A is the subsampling matrix
X0 = transpose(A)*A*X;
% Initialize
i = 0;
x_hat_new = 0;
x_hat_prev = 0;
X_new = X0;
while (i == 0 || norm((x_hat_prev-x_hat_new))>eps)
        % calculate the inverse Furier Transform
        x_hat_prev =x_hat_new;
        % Soft-thresholding
        x_hat_new = soft_thresholding(ifft(X_new), lambda);
        X_new = fft(x_hat_new);
        % Data consistency step
        for j=1:length(X_new)
            if(X0(j,1)~=0)
             X_new(1,j) = X0(j,1);
            end
        end
        i = i+1;

    end
end


        % Use this plot for debugging, but comment it out if you want quicker
        % running.
     %    subplot(2,1,2)
      %   stem(x_hat_new)
       %  title('x_{hat}')
       %  pause(.1)
