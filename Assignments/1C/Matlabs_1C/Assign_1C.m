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

J = 0;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 0;                 % meters of element spacing in x-direction
nb_f = 0;               % narrowband (nb) frequency in Hz

% Setup an ULA array from the settings and plot the array configuration
my_array = arrays.ULA(J,dx,dy);

% Create a beamformer object and put settings in the beamformer object.
b = beamformer;
set(b, 'array',         my_array);
set(b, 'angles',        -180:0.5:180);
set(b, 'nb_frequency',  nb_f);

% calculate the steered response power here
%P_srp=...;
    
figure(1);plot(b.angles,P_srp);xlabel('angle [degrees]');ylabel('steered response power');title(strcat('Steered response spatial power spectrum,',num2str(b.array.number_of_sensors), ' sensor ULA'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1Cs2 a)
return %%remove this to continue
% calculate the spatial spectrum using MUSIC here
%P_music=...;

figure(2);plot(b.angles,P_music);xlabel('angle [degrees]');ylabel('P');title(strcat('MUSIC spatial pseudo spectrum',num2str(b.array.number_of_sensors), ' sensor ULA'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1Cs2 c)
return %%remove this to continue
% using the number of sources wrongly and apply the spectral-MUSIC
% algorithm

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
