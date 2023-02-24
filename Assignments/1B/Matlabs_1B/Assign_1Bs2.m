clear all
load Assign_1B_testsignals.mat

DOA=30;
fs=25e3;

J = 0;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 0;                 % meters of element spacing in x-direction
ULA_array = arrays.ULA(J,dx,dy);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1B scenario 2 d)
%  1.Calculate the required delay for each sensor signal that will
%    time-align the input signals
%  2.Use delay.m to generate impulse responses that will perform the required delay. Take
%    care of causality.
%  3.Filter the input signals with their corresponding filters. Verify
%    whether the signals have been time-aligned.
 
 
