classdef beamformer < handle & hgsetget
  %BEAMFORMER Implementation of a beamformer
  %   Detailed explanation goes here
  
  properties
    array;              % Contains a description and sensor positions
    angles;             % Angles for which a plot is made
    % Narrowband properties
    nb_beampattern      % Narrowband beampattern
    nb_frequency;       % Frequency for narrowband beamformers
    nb_weights;         % Weights for narrowband beamformer
    % Multi-tone properties
    mt_beampattern;     % Multi-tone beampattern
    mt_frequency;     % Frequencies for multi-tone beamformers
    mt_weights;         % Weights for multi-tone beamformers
  end
  
  methods
    % Class constructor
    function this = beamformer( sensor_array,...
        angles,...
        nb_frequency,...
        nb_weights,...
        mt_frequency,...
        mt_weights)
      if nargin>=1; set(this, 'array',        sensor_array);  end
      if nargin>=2; set(this, 'angles',       angles);        end
      if nargin>=3; set(this, 'nb_frequency', nb_frequency);  end
      if nargin>=4; set(this, 'nb_weights',   nb_weights);    end
      if nargin>=5; set(this, 'mt_frequency', mt_frequency);  end
      if nargin>=6; set(this, 'mt_weights',   mt_weights);    end
    end
    % Example input check function:
    function set.array(this, myArray)
      if isa(myArray, 'array')
        this.array = myArray;
      else
        error('The array input must be of class array');
      end
    end
    % Shortcut function for plot -> plot_nb
    function plot(varargin)
      plot_nb(varargin{:});
    end
  end
end


