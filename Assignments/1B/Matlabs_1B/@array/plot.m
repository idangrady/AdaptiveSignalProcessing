function plot(this, linspec)
% PLOT(this, linspec) Plots the sensor positions
%
% linspec may be a cell array containing multiple options, e.g.,
%  linspec = {'rx','MarkerSize',12,'LineWidth',2}

if ~exist('linspec', 'var') || isempty(linspec)
  linspec = {'rx','MarkerSize',12,'LineWidth',2};
elseif isa(linspec, 'char')
  linspec{1} = linspec;
end

if ~isempty(this.sensor_positions)
  
  px = this.sensor_positions(:,1);
  py = this.sensor_positions(:,2);
  
  plot(px,py,linspec{:});
  
  title('Sensor positions');
  xlabel('x position in meters');
  ylabel('y position in meters');
  
end
end