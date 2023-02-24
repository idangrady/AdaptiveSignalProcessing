function h=delay(d, fd, L, dmax)
%
% [h]=delay(d,fd,L,dmax)
%
% Design of delay filter h representing delta = d +fd/L
%
% delta = {-(L-1)/L, ..., -1/L, 0,1/L,2/L,... ,dmax}
% d={0,1, ..., dmax}
% fd={0,1, ... L-1}
% L={1,2,3,...}
% dmax={0,1,2,...}
%
% Use function frac_delay to generate polyphase filter h_p of length L_p
%
% Total processing delay = delta + L_p/2

h_d=zeros(dmax+1,1)';
if fd==0
  h_p=fracDelay(fd,L)';
  h_d(1,d+1)=1;
  h=conv(h_d,h_p);
else if fd > 0
    h_p=fracDelay(L-fd,L)';
    h_d(1,d+2)=1;
    h=conv(h_d,h_p);
  else    % fd <0
    h_p=fracDelay(-fd,L)';
    h_d(1,d+1)=1;
    h=conv(h_d,h_p);
  end
end
end

%% FUNCTION: [h_poly]=fracDelay(d,M)
function [h_poly]=fracDelay(d,M)
%
% Polyphase realization of fractional delay
% delay = (d/M)/fs with d=0,1, ..., M-1
%

% Design low-pass filter
fs = 1;
ripple  = [1e-3 ; 1e-3];
LPF_tran = [.99 ; 1.01].*(fs/2);
[N,Wn,beta,TYPE] = kaiserord(LPF_tran, [1 ; 0], ripple, M*fs);

% Force number N to be even
while mod(N/M,2),
  N=N+1;
end;
h_lpf = fir1(N, Wn, 'low', kaiser(N+1,beta ), 'noscale' )';

% Create polyphase filter
h_poly = M*h_lpf(d+1:M:N);

% Note: length(h_lpf)=N+1
% Note: length(h_poly)=N/M
% Note: total delay = N/2M - d/M
end