function sa = rectangular_array(J, dx, dy )
%RECTANGULAR_ARRAY(J, dx, dy) Generate a 2D array with four elements
%   Generate a rectangular array with:
%     - sensor spacing in the x direction of dx
%     - sensor spacing in the y direction of dy
%     - center of the array in the origin

% Calculate the sensor positions in a matrix with all x-axis locations in
% the first column and all y-axis locations in the second column.

%p = [px, py];

p = zeros(J,2);
for i = 1:J
    for j = 1:2
        p((i-1)*J+j,:) = [(i-1)*dx, (j-1)*dy];
    end
end
% Generate the rectangular array with sensor positions p
sa = array(p, 'Rectangular array');
end

