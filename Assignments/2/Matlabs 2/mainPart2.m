close all;
clear all;
clc;

%% Question 17: Create sampling matrix

M = 1024;
A = ...
    

%% Question 18: IFFT reconstruction
% Subsample the image
im = phantom('Modified Shepp-Logan', 64);
y = ...;

% Reconstruction via inverse fourier transform
invReconstruction = ... ;

figure()
subplot(1,3,1)
imshow(im, [])
title('Original image')
subplot(1,3,2)
imshow(invReconstruction, [])
title(sprintf('IFFT of zero-filled \nsubsampled k-space'))


%% Question 19: TV based reconstruction 
N = 64; % x and y dimension of the image
F = ...;

lambda = 0.1;

cvx_begin
    cvx_precision low
    variable imhat(N,N)
    Dx_imhat = ...;
    Dy_imhat = ...;
    minimize(... + lambda * (norm(Dx_imhat(:),1) + norm(Dy_imhat(:),1)) );
cvx_end

TVreconPhantom = imhat;

figure()
subplot(1,3,1)
imshow(im, [])
title('Original image')
subplot(1,3,2)
imshow(TVreconPhantom, [])
title(sprintf('TV-domain reconstruction'))



%% Question 20: IFFT vs TV-based MRI reconstruction

% Brain data
data = load('brain.mat');
im = imresize(abs(data.im), [64,64]);

% IFFT reconstruction
y = ...;
invReconstructionMRI = ...;

% TV-based reconstruction
lambda = 0.1;

cvx_begin
    cvx_precision low
    variable imhat(N,N)
    Dx_imhat =  ...;
    Dy_imhat = ...;
    minimize( ... );
cvx_end
TVreconMRI = imhat;

% Plot the original image and the two reconstructions
figure()
subplot(1,3,1)
imshow(im)
title('Original image')
subplot(1,3,2)
imshow(invReconstructionMRI)
title(sprintf('IFFT of zero-filled \nsubsampled k-space'))
subplot(1,3,3)
imshow(TVreconMRI)
title('TV reconstruction')


