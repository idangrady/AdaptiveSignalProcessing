clear all
load Assign_1B_testsignals.mat

DOA=30;  

J = 0;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 0;                 % meters of element spacing in x-direction
ULA_array = arrays.ULA(J,dx,dy);

fs=25e3; 
% Given in the assignment
% defined range
NSample =20;
L = NSample;
t = -NSample:1:NSample/2-1; % 50  samples
% Define the delays
tau0 = 3;
tau1 = 5.15;

% Define the impulse responses
d0 = sinc((tau0-t)*pi);
d1 = sinc((tau1- t)*pi);


SignalOriginal = d0; %Orignal Signal
FracDelay = tau0; % delay 3.75 samples
FracDelayInt = floor(FracDelay); % Largest integer that is less than the fractional delay
FracDelayRem = FracDelay - FracDelayInt; %Fractional part
h = delay(FracDelayInt, round(FracDelayRem * L), L, ceil(FracDelay)); %design the filter

SignalFracDelay = conv(SignalOriginal, h);
ProcessingDelay = length(h) - ceil(FracDelay); %The processing delay is determined by the length of the filter and dmax
SignalFracDelay = SignalFracDelay(floor(ProcessingDelay / 2) + 1: floor(ProcessingDelay / 2) + length(SignalOriginal)); 


ll =SignalOriginal(10:10+NSample);

figure;
hold on;
box on;
grid on;
axis([1 NSample -1 1])
plot(1:NSample, SignalOriginal((10:9+NSample)));
stem(1:NSample, SignalFracDelay(10:9+NSample), 'g-');


xlabel('Sample');
ylabel('Amplitude');

legend('Original', 'Practical Fractional delay');









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1B scenario 2 d)
%  1.Calculate the required delay for each sensor signal that will
%    time-align the input signals
%  2.Use delay.m to generate impulse responses that will perform the required delay. Take
%    care of causality.
%  3.Filter the input signals with their corresponding filters. Verify
%    whether the signals have been time-aligned.
 
 
