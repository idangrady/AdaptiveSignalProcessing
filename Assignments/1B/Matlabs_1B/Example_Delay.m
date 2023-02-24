%This is an example code to show how to use delay.m

clear all;
close all;
clc;

NSample = 50;
t = 0: NSample - 1; % 50  samples
SignalOriginal = sin(2 * pi / NSample .* t); %Orignal Signal

FracDelay = 3.75; % delay 3.75 samples
FracDelayInt = floor(FracDelay); % Largest integer that is less than the fractional delay
FracDelayRem = FracDelay - FracDelayInt; %Fractional part
L = 100; 
h = delay(FracDelayInt, round(FracDelayRem * L), L, ceil(FracDelay)); %design the filter


SignalFracDelay = conv(SignalOriginal, h); %Convolution of signal and filter
ProcessingDelay = length(h) - ceil(FracDelay); %The processing delay is determined by the length of the filter and dmax
SignalFracDelay = SignalFracDelay(floor(ProcessingDelay / 2) + 1: floor(ProcessingDelay / 2) + length(SignalOriginal)); 
SignalFracDelayTheoretical = sin(2 * pi / NSample .* (t - FracDelay)) .* [zeros(1, ceil(FracDelay)), ones(1, NSample - ceil(FracDelay))];


figure;
hold on;
box on;
grid on;
axis([1 NSample -1 1])
plot(1:NSample, SignalOriginal);
plot(1:NSample, SignalFracDelayTheoretical, 'r-');
stem(1:NSample, SignalFracDelay, 'g-');


xlabel('Sample');
ylabel('Amplitude');

legend('Original', 'Theoretical Fractional delay', 'Practical Fractional delay');
