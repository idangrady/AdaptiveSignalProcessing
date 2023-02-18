clc;clear all;close all;
%% generate x1 and x2
nsample=200;
[x e]=generate_input(nsample);
%% set up filter
filterA1=adaptive_filter(2,'FDAF', 0.01);

%% perform nsample iterations
for sample=1:nsample
   filterA1=filterA1.filter(x(sample),e(sample)); 
end

%% plot filter coefficients
hold on
plot(filterA1.w_history(:,1),filterA1.w_history(:,2));
title(strcat('filter algorithm: ',filterA1.type,' adaptation constant: ',num2str(filterA1.adaptation_constant)))
hold off