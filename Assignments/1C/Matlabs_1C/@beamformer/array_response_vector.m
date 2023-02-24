function A = array_response_vector(b, theta, f)
%ARRAY_RESPONSE_VECTOR(b, DOA) Returns array response vectors
%
%   Implement in this function the array response vector calculation for a
%   2D sensor array. The input theta may be a row vector containing
%   multiple angles, which means that the output may become a matrix
%   containing multiple array response vectors next to each other.
%
%   Use the input f as the narrowband frequency. 
%
%   In this function the beamformer b is available with all its properties
%   which you can access with a .
%   For example:
%

% Get the sensor array from the beamformer object:
ULA_array = b.array;

% Get the sensor positions from the array object:
p = ULA_array.sensor_positions;

% You may use the wave_vector function:
% help wave_vector

% Implement this yourself

A=..;

end

