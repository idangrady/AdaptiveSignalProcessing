function ula = ULA(D, dx, dy)
%ULA Return ULA sensor positions
%
% INPUTS:
%   - D   = Number of sensors
%   - dx  = spacing in x-direction in meters
%   - dy  = spacing in y-direction in meters
%
% OUTPUTS:
%   - array = containing the number of sensors and the sensor
%             positions

% Calculate sensor positions
p = (-(D-1)/2 : (D-1)/2)'*[dx -dy];
% Put the sensor positions into an array
ula = array(p, 'ULA');
end

