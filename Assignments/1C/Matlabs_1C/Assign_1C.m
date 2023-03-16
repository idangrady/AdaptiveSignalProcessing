%% Assignment 1C Scenario 1: Maximized steered response DOA estimation
%
%   Implement DOA estimation
%   Requires tools from A2
%

clear all;
close all;
clear classes;
clc;
load Observations_1C

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1Cs1 b and c)
% 1. Setup the ULA settings

J = 6;                  % Number of sensors
dy = 3.4;                 % meters of element spacing in y-direction
dx = 0;                 % meters of element spacing in x-direction
nb_f = 2500;               % narrowband (nb) frequency in Hz

% Setup an ULA array from the settings and plot the array configuration
my_array = arrays.ULA(J,dx,dy);

% Create a beamformer object and put settings in the beamformer object.
b = beamformer;
set(b, 'array',         my_array);
set(b, 'angles',        -180:0.5:180);
set(b, 'nb_frequency',  nb_f);

thetas = -180:0.5:180;
c = 340;
% calculate the steered response power here

[acf,Rx] = autocorr(observations);
p =my_array.sensor_positions;

A =b.array_response(thetas, nb_f);

P_srp=A'* Rx * A /J; 
    
%{
thetas = -180:0.5:180;
P_srp = zeros(length(thetas), 1);
C13 = true;

Rx = corr(observations');
for i =0:length(thetas)-1
    R = [cosd(i/2) -sind(i/2); sind(i/2) cosd(i/2)];
    b.array.sensor_positions = b.array.sensorpositions*R;
    a =b.array_response_vector(thetas(i+1), b.nbfrequency);
    if(C13)
        a(1,:) = 0;
        a(6,:) = 0;
    end
    check = ((a')Rxa_./J);
    P_srp(i+1) = (check);
end
%}

figure(1);plot(b.angles,P_srp);xlabel('angle [degrees]');ylabel('steered response power');title(strcat('Steered response spatial power spectrum,',num2str(b.array.number_of_sensors), ' sensor ULA'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1Cs2 a)
return %%remove this to continue
% calculate the spatial spectrum using MUSIC here
%P_music=...;
[acf,Rx] = autocorr(observations);
[Ux,Sx] = eig(Rx);
[Sx,idx] = sort(diag(Sx),'descend');

figure(2);plot(b.angles,P_music);xlabel('angle [degrees]');ylabel('P');title(strcat('MUSIC spatial pseudo spectrum',num2str(b.array.number_of_sensors), ' sensor ULA'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1Cs2 c)
return %%remove this to continue
% using the number of sources wrongly and apply the spectral-MUSIC
% algorithm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
