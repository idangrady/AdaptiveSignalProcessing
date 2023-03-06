clear all
load Assign_1B_testsignals.mat

%{
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


plot(1:L, SignalOriginal((10:9+L)));
plot(1:L, SignalOriginal((10:9+L)));
plot(1:L, SignalOriginal((10:9+L)));

xlabel('Sample');
ylabel('Amplitude');

legend('Original', 'Practical Fractional delay');

%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1B scenario 2 d)
%  1.Calculate the required delay for each sensor signal that will
%    time-align the input signals
%  2.Use delay.m to generate impulse responses that will perform the required delay. Take
%    care of causality.
%  3.Filter the input signals with their corresponding filters. Verify
%    whether the signals have been time-aligned.
 
clear all
load Assign_1B_testsignals.mat

theta=30;  
fs=25e3; 
J = 4;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 0.035;                 % meters of element spacing in x-direction
ULA_array = arrays.ULA(J,dx,dy);
P = ULA_array.sensor_positions;
c =340;

p = ULA_array.sensor_positions;

% You may use the wave_vector function:
% help wave_vector

% Implement this yourself
v= wave_vector(theta);
lambda= c/fs;
thai=(p*v)/c;
A= exp(-1i*2*pi*fs*thai);
L = 1000;


%signal 1
SignalOriginal1 = x(1,:); %Orignal Signal
FracDelay1 = abs(A(1)); % delay 3.75 samples
FracDelayInt1 = floor(FracDelay1); % Largest integer that is less than the fractional delay
FracDelayRem1 = FracDelay1 - FracDelayInt1; %Fractional part
h1 = delay(FracDelayInt1, round(FracDelayRem1 * L), L, ceil(FracDelay1)); %design the filter


%signal 2
SignalOriginal2 = x(2,:); %Orignal Signal
FracDelay2 = abs(A(2)); % delay 3.75 samples
FracDelayInt2 = floor(FracDelay2); % Largest integer that is less than the fractional delay
FracDelayRem2 = FracDelay2 - FracDelayInt2; %Fractional part
h2 = delay(FracDelayInt2, round(FracDelayRem2 * L), L, ceil(FracDelay2)); %design the filter


%signal 3
SignalOriginal3 = x(3,:); %Orignal Signal
FracDelay3 = abs(A(3)); % delay 3.75 samples
FracDelayInt3 = floor(FracDelay3); % Largest integer that is less than the fractional delay
FracDelayRem3 = FracDelay3 - FracDelayInt3; %Fractional part
h3 = delay(FracDelayInt3, round(FracDelayRem3 * L), L, ceil(FracDelay3)); %design the filter


%signal 4
SignalOriginal4 = x(4,:); %Orignal Signal
FracDelay4 = abs(A(4)); % delay 3.75 samples
FracDelayInt4 = floor(FracDelay4); % Largest integer that is less than the fractional delay
FracDelayRem4 = FracDelay4 - FracDelayInt4; %Fractional part
h4 = delay(FracDelayInt4, round(FracDelayRem4 * L), L, ceil(FracDelay4)); %design the filter


ss =x(1,:);
SignalFracDelay1 = conv(x(1,:), h1);
SignalFracDelay2 = conv(x(2,:), h2);
SignalFracDelay3 = conv(x(3,:), h3);
SignalFracDelay4 = conv(x(4,:), h4);



ProcessingDelay1 = length(h1) - ceil(FracDelay1); %The processing delay is determined by the length of the filter and dmax
SignalFracDelay1 = SignalFracDelay1(floor(ProcessingDelay1 / 2) + 1: floor(ProcessingDelay1 / 2) + length(SignalOriginal1)); 

ProcessingDelay2 = length(h2) - ceil(FracDelay2); %The processing delay is determined by the length of the filter and dmax
SignalFracDelay2 = SignalFracDelay2(floor(ProcessingDelay2 / 2) + 1: floor(ProcessingDelay2 / 2) + length(SignalOriginal2)); 

ProcessingDelay3 = length(h3) - ceil(FracDelay3); %The processing delay is determined by the length of the filter and dmax
SignalFracDelay3 = SignalFracDelay3(floor(ProcessingDelay3 / 2) + 1: floor(ProcessingDelay3 / 2) + length(SignalOriginal3)); 

ProcessingDelay4 = length(h4) - ceil(FracDelay4); %The processing delay is determined by the length of the filter and dmax
SignalFracDelay4 = SignalFracDelay4(floor(ProcessingDelay4 / 2) + 1: floor(ProcessingDelay4 / 2) + length(SignalOriginal4)); 


figure;
hold on;
box on;
grid on;
%axis([1 NSample -1 1])
plot(x(1,:));
plot(SignalFracDelay1);

plot(x(2,:));
plot(SignalFracDelay2);

plot(x(3,:));
plot(SignalFracDelay3);

plot(x(4,:));
plot(SignalFracDelay4);

xlabel('Sample');
ylabel('Amplitude');



legend('sensor1', 'shifted_1','sensor2', 'shifted_2','sensor3', 'shifted_3','sensor4', 'shifted_4');



%%

clear all
load Assign_1B_testsignals.mat


theta=30;  
fs=25e3; 
J = 4;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 0.035;             % meters of element spacing in x-direction
ULA_array = arrays.ULA(J,dx,dy);
p = ULA_array.sensor_positions;
c =340;

% Array Response
v= wave_vector(theta);
lambda= c/fs;
thai=(p*v)/c;
A= exp(-1i*2*pi*fs*thai);
L = 1000;

% Process each signal per sensor
for k = 1:J
    SignalOriginal = x(J-k+1,:); %Original Signal
    FracDelay = (dx*(J-k+1)*sind(theta)/c)*fs;%real(A(k))*k; % delay in samples -> used the absolut values from each array response
    FracDelayInt = floor(FracDelay); % Largest integer that is less than the fractional delay
    FracDelayRem = FracDelay - FracDelayInt; %Fractional part
    h = delay(FracDelayInt, round(FracDelayRem * L), L, ceil(FracDelay)); %design the filter
    SignalFracDelay = conv(x(k,:), h); %apply the filter to the signal
    
    ProcessingDelay = length(h) - ceil(FracDelay); %The processing delay is determined by the length of the filter and dmax
    SignalFracDelay = SignalFracDelay(floor(ProcessingDelay / 2) + 1: floor(ProcessingDelay / 2) + length(SignalOriginal)); 
    
    SignalFracDelayAll(k,:) = SignalFracDelay; % store processed signal
end

% Plot all signals
figure;
hold on;
box on;
grid on;
for k = 1:J
  % plot(x(k,:));
   plot(SignalFracDelayAll(k,:));
end
xlabel('Sample');
ylabel('Amplitude');
legend( 'shifted_1', 'shifted_2', 'shifted_3', 'shifted_4');

%legend('sensor1', 'shifted_1','sensor2', 'shifted_2','sensor3', 'shifted_3','sensor4', 'shifted_4');

 
