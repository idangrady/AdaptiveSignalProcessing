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

J = 6;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 0.034;                 % meters of element spacing in x-direction
nb_f = 2500;               % narrowband (nb) frequency in Hz
dy_g = 0.017;

% Setup an ULA array from the settings and plot the array configuration
my_array = arrays.ULA(J,dx,dy);
my_array_ref = arrays.ULA(J,dx,dy);
my_array_g = arrays.rectangular_array(J/2,dx,dy_g);

% Use the plot function that belongs to the array class (in @array
% directory)
figure;
my_array.plot();
figure;
my_array_g.plot();
% Create a beamformer object and put settings in the beamformer object.
b = beamformer;
set(b, 'array',         my_array);
set(b, 'angles',        -180:1:180);
set(b, 'nb_frequency',  nb_f);

% Display all properties of the beamformer b:
my_array_ref.sensor_positions= rot90(my_array.sensor_positions)';
figure;
my_array_ref.plot();

b_ref = beamformer;
set(b_ref, 'array',        my_array_ref);
set(b_ref, 'angles',        -180:1:180);
set(b_ref, 'nb_frequency',  nb_f);

% 2. Implement the array_response_vector.m method that is located in the
%    @beamformer folder.
% 3. Implement the calc_nb_beampattern.m method that is located in the
%    @beamformer folder
% 4. Verify the result of the matlab function with your answer at a)

% Set the beamformer weights to 1
b.nb_weights = ones(J,1);
b.calc_nb_beampattern;

b_ref.nb_weights = ones(J,1);
b_ref.calc_nb_beampattern;

%plot( b.nb_beampattern, (size(b.nb_beampattern)));
% Use the plot function that belongs to the narrowband beamformer
figure;
subplot(1,2,1);b.plot_nb;
subplot(1,2,2); b_ref.plot_nb; %plot your equation from a) here
xlabel('Angle in [degrees]')
ylabel('Beamformer gain in [dB]')
title('Beampattern for narrowband beamformer (reference)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 d)
% 1. Implement the beam_steering_nb.m method that is located in the
%    @beamformer folder.
% 2. Verify the result of the matlab function by visual inspection.

% Remove this return to continue with the assignment

theta = [30]; % row vector containing angles for which constraints hold
target = [1]; % row vector containing target values for the beampattern
b.beam_steering_nb(theta, target);
b.calc_nb_beampattern;


b_ref.beam_steering_nb(theta, target);
b_ref.calc_nb_beampattern;
% Use the plot function that belongs to the narrowband beamformer
figure;
b.plot_nb([],theta, {'k-.','LineWidth',2});
figure;
b_ref.plot_nb([],theta, {'k-.','LineWidth',2});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 f)
% 1. Add the undesired source direction and make sure that the beamformer
% has unity response at 30 degrees and a zero response at -60 degrees.

% Remove this return to continue with the assignment
theta = [30 -60]; % row vector containing angles for which constraints hold
target = [1 0]; % row vector containing target values for the beampattern
b.beam_steering_nb(theta, target);
b.calc_nb_beampattern;

% Use the plot function that belongs to the narrowband beamformer
figure;
%b.plot_nb([],theta, {'k-.','LineWidth',2});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 g)
% 1. Implement the rectangular_array.m function that is located in the
%    + array folder.

b_g = b;
b_g.array.sensor_positions = my_array_g.sensor_positions;
b_g.calc_nb_beampattern;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Assign 1BS1 h)
% 1. Compare the square array results for different frequencies













