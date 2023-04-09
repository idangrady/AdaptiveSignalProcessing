close all;
clear all;
clc;

%% Question 17: Create sampling matrix

M = 1024;
A = reshape(randn(1, M*64^2), [M, 64^2]);
    

%% Question 18: IFFT reconstruction
% Subsample the image
im = phantom('Modified Shepp-Logan', 64);
% im_vec=im(:);
kspace=fft2(im);
kscpae_vec=kspace(:);
y =A'*A* kscpae_vec;
y_2d= reshape(y,[64 64]);
% % Reconstruction via inverse fourier transform
invReconstruction = ifft2(y_2d) ;
% inv=ifft2(y2dtest);
% % 
figure()
subplot(1,3,1)
imshow(im, [])
title('Original image')
subplot(1,3,2)
imshow(invReconstruction, [])
title(sprintf('IFFT of zero-filled \nsubsampled k-space'))

%% installin cvx

addpath(genpath('C:\Users\yooso\course\cvx'));
% cvx_setup
run('C:\Users\yooso\course\cvx\cvx_setup.m');
%% Question 19: TV based reconstruction 
N = 64; % x and y dimension of the image

F = dftmtx(N); % Create the DFT matrix

lambda = 0.1;

cvx_begin
    cvx_precision low
    variable imhat(N,N) 
    Dx_imhat = imhat(:,2:end) - imhat(:,1:end-1);
    Dx_imhat= [Dx_imhat ,zeros(N,1)];
    Dy_imhat = imhat(2:end,:) - imhat(1:end-1,:);
    Dy_imhat=[Dy_imhat ; zeros(1,N)];

    FIF=F*imhat*F;
    FIF_vec=FIF(:);
    minimize(norm(A'*A*FIF_vec - y,2) + lambda * (norm(Dx_imhat(:),1) + norm(Dy_imhat(:),1)) );
cvx_end
%% 
TVreconPhantom =imhat; % Inverse Fourier transform

figure()
subplot(1,3,1)
imshow(im, [])
title('Original image')
subplot(1,3,2)
imshow(TVreconPhantom, [])
title(sprintf('TV-domain reconstruction'))


% 
%% Question 20: IFFT vs TV-based MRI reconstruction

% Brain data
data = load('brain.mat');
im = imresize(abs(data.im), [64,64]);

% IFFT reconstruction
% y = ...;
% invReconstructionMRI = ...;
im_vec=im(:);

fft2d=fft2(im);
fft2dd=fft2d(:);
y= A'*A*fft2dd;
y_2d= reshape(y,[64 64]);
% % Reconstruction via inverse fourier transform
invReconstructionMRI = ifft2(y_2d) ;

% TV-based reconstruction
lambda = 0.1;

cvx_begin
    cvx_precision low
    variable imhat(N,N)
    Dx_imhat = imhat(:,2:end) - imhat(:,1:end-1);
    Dx_imhat= [Dx_imhat ,zeros(N,1)];
    Dy_imhat = imhat(2:end,:) - imhat(1:end-1,:);
    Dy_imhat=[Dy_imhat ; zeros(1,N)];
    FIF=F*imhat*F;
    FIF_vec=FIF(:);
    minimize(norm(A'*A*FIF_vec - y,2) + lambda * (norm(Dx_imhat(:),1) + norm(Dy_imhat(:),1)) );
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


