function beam_steering_nb( b, theta, target)
%BEAM_STEERING_NB(b, theta, target) Calculate constrained nb beamformer
%
% Use beamsteering to obtain a desired beampattern. The beamformer has to
% fullfill the following linear constraints:
%  w' * A(theta) = target
% where:
%   w are the narrow band beamformer weights, stored as a column vector in
%   the property b.nb_weights.
%   A(theta) is the array response `matrix' containing the array response
%     vector for each theta
%   target is a vector containing the desired beampattern values for theta.
A = b.array_response_vector(theta, b.nb_frequency);
b.nb_weights = (pinv(A).* target')';
end
