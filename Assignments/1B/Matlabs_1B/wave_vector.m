function q = wave_vector( theta )
%WAVE_VECTOR(theta) returns a wave vector pointing from source to origin
%   Return a column vector containing the [x;y] direction of a signal. The
%   vector points from the source location towards the origin. The length
%   of the vector is normalized, i.e., norm(q)=1.
%
%   Orientation:
%   For theta= 0, the source is in the positive y-axis position
%   For theta=90, the source is in the negative x-axis position
%
%   Examples:
%     q=wave_vector( 0) -> q = [ 0; -1]
%     q=wave_vector(90) -> q = [ 1;  0]
%

%% Test inputs
if ~exist('theta','var')
  theta = 0;
elseif ~isnumeric(theta)
  error('WAVE_VECTOR:inputs','Input theta must be numeric.');
end

%% Perform calculations
q = [sind(theta); -cosd(theta)];

end

