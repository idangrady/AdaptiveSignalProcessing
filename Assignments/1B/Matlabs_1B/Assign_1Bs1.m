%% Assignment 1B Scenario 1: Narrowband beamformers
%
%   Implement tools for narrowband beamformer design and evaluation
%   Result plots: sensor locations, beampatterns in plot format.
%   Note:   Each step uses different functions of the beamformermer class.
%           These functions are denoted with each step.
%

clear all;
close all;
clear classes;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 c)
% 1. Setup the ULA settings as in figure 1 of the assignment

J = 4;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 3.4;                 % meters of element spacing in x-direction
nb_f = 2500;               % narrowband (nb) frequency in Hz

% Setup an ULA array from the settings and plot the array configuration
my_array = arrays.ULA(J,dx,dy);

% Use the plot function that belongs to the array class (in @array
% directory)
figure;
my_array.plot();

% Create a beamformer object and put settings in the beamformer object.
b = beamformer;
set(b, 'array',         my_array);
set(b, 'angles',        -180:1:180);
set(b, 'nb_frequency',  nb_f);

% Display all properties of the beamformer b:
%b

% 2. Implement the array_response_vector.m method that is located in the
%    @beamformer folder.
% 3. Implement the calc_nb_beampattern.m method that is located in the
%    @beamformer folder
% 4. Verify the result of the matlab function with your answer at a)

% Set the beamformer weights to 1
b.nb_weights = ones(J,1);
b.calc_nb_beampattern;
plot( b.nb_beampattern, (size(b.nb_beampattern)));
% Use the plot function that belongs to the narrowband beamformer
figure;
subplot(1,2,1);b.plot_nb;
subplot(1,2,2);%plot your equation from a) here
xlabel('Angle in [degrees]')
ylabel('Beamformer gain in [dB]')
title('Beampattern for narrowband beamformer (reference)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 d)
% 1. Implement the beam_steering_nb.m method that is located in the
%    @beamformer folder.
% 2. Verify the result of the matlab function by visual inspection.

% Remove this return to continue with the assignment
%return;

theta = []; % row vector containing angles for which constraints hold
target = []; % row vector containing target values for the beampattern
b.beam_steering_nb(theta, target);
b.calc_nb_beampattern;

% Use the plot function that belongs to the narrowband beamformer
figure;
b.plot_nb([],theta, {'k-.','LineWidth',2});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 f)
% 1. Add the undesired source direction and make sure that the beamformer
% has unity response at 30 degrees and a zero response at -60 degrees.

% Remove this return to continue with the assignment
return;

theta = []; % row vector containing angles for which constraints hold
target = []; % row vector containing target values for the beampattern
b.beam_steering_nb(theta, target);
b.calc_nb_beampattern;

% Use the plot function that belongs to the narrowband beamformer
figure;
b.plot_nb([],theta, {'k-.','LineWidth',2});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 g)
% 1. Implement the rectangular_array.m function that is located in the
%    + array folder.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 h)
% 1. Compare the square array results for different frequencies













