function [ filter ] = update_filter( filter,e )

x=filter.x_delayed;
w_old = filter.w;
R_old = filter.R;
r=filter.r;
re_old = filter.re;
filter_type=filter.type;

%% A1 scenario 1:f
if strcmpi(filter_type,'SGD')
    %implement the SGD update rule here
    alpha=filter.adaptation_constant;
    Rx =[2 -1; -1 2];
    rex = [0;3];
    filter.w= w_old+2*alpha*(rex- Rx*w_old);
end

 %% A1 scenario 1:i
 if strcmpi(filter_type,'Newton')
    alpha=filter.adaptation_constant;
    Rx =[2 -1; -1 2];
    rex = [0;3]; 
    t=(rex-Rx*w_old);
    filter.w= w_old + 2*alpha*Rx\(rex-Rx*w_old);

%% A1 scenario 2:a
if strcmpi(filter_type,'LMS')
    %implement the LMS update rule here
    alpha=filter.adaptation_constant;
    filter.w= w_old + 2*alpha* x*r;
end

%% A1 scenario 2:b
if strcmpi(filter_type,'NLMS')
    %implement the NLMS update rule here
    alpha=filter.adaptation_constant;
    [n,d]= size(x);
    filter.w= w_old + 2/(dot(x,x')/d)*alpha* x*r;
end

%% A1 scenario 2:d
if strcmpi(filter_type,'RLS')
    %implement the RLS update rule here
    lambda=filter.adaptation_constant;
    disp(size(filter.R))
    disp(lambda)

    down =x'*R_old*x + lambda;
    up = R_old*x;
    g=(up)/( down);
    filter.R =lambda^(-2)*(R_old - g*x'*R_old);
    filter.re = lambda^2* re_old + x*e;
    filter.w= filter.R* filter.re;
end

 %% A1 scenario 2:e
 if strcmpi(filter_type,'FDAF')
    alpha = filter.adaptation_constant;
    X = filter.F * x;
    beta = 0.5;
    filter.est_p = beta * filter.est_p + (1 - beta) * (X .* conj(X)')/length(x);
    %convert back to frequency domain
    W_old = filter.F_inverse * w_old;
    
    % Precompute diag_spectrum and inv_diag_spectrum
    diag_spectrum = diag(filter.est_p);
    inv_diag_spectrum = inv(diag(diag_spectrum));
    
    % Update w in frequency domain
    W_new  = W_old + (2 * alpha) * inv_diag_spectrum * conj(X) * r;
    %return to time domain
    filter.w = filter.F * W_new;

 end
 
end

