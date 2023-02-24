classdef array < handle
  %ARRAY Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    description;          %
    sensor_positions;     % Sensor positions in meters, [x,y] format
  end
  
  properties (SetAccess=private, GetAccess=public)
    % A trick to read the number_of_sensors without explicitly setting it.
    number_of_sensors;
  end
  
  methods
    function this = array(sensor_positions, description)
      if nargin>=1
        this.sensor_positions = sensor_positions;
      else
        this.sensor_positions = [];
        this.description = 'Empty array';
      end
      if nargin>=2 && isa(description, 'char')
        this.description = description;
      end
    end
    % A trick to read the number_of_sensors without explicitly setting it.
    function number_of_sensors = get.number_of_sensors(this)
      if isempty(this.sensor_positions)
        number_of_sensors = 0;
      else
        number_of_sensors = size(this.sensor_positions,1);
      end
    end
  end
end
