function plot_nb( this, linspec , DOA, linspec_DOA)
% PLOT_NB(this, linspec, DOA, linspec_DOA) Plot beampattern
%
% linspec may be a cell array containing multiple options, e.g.,
%  linspec = {'rx','MarkerSize',12,'LineWidth',2}
%
% DOA may contain a row vector with the DOAs in degrees, lines with
% linspec_DOA properties will be shown

%% Check linspec input
if ~exist('linspec', 'var') || isempty(linspec)
  linspec = {'b-','LineWidth',2};
elseif isa(linspec, 'char')
  c{1} = linspec;
  linspec = c;
end

%% Plot the nb_beampattern
B = 10*log10(this.nb_beampattern);
plot(this.angles, B, linspec{:});
axis tight
title('Beampattern for narrowband beamformer')
xlabel('Angle in [degrees]');
ylabel('Beamformer gain in [dB]');

%% Check if DOAs are submitted, othwerwise return

if ~exist('DOA','var') || isempty(DOA)
  return
end

%% Check linspec_DOA input
if ~exist('linspec_DOA', 'var') || isempty(linspec_DOA)
  linspec_DOA = {'g-.','LineWidth',2};
elseif isa(linspec_DOA, 'char')
  c{1} = linspec_DOA;
  linspec_DOA = c;
end

%% Plot DOAs as lines with linspec_DOA line options
holdstate = ishold;

hold on;
DOA = reshape(DOA, 1, length(DOA));
plot([DOA; DOA], [min(B.*(1-isinf(B))) max(B)]'* ones(1,length(DOA)), linspec_DOA{:});

% Set back hold state
if holdstate
  hold on;
else
  hold off;
end

end % plot_nb

