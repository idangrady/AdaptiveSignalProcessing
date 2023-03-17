J = 4;                  % Number of sensors
dy = 0;                 % meters of element spacing in y-direction
dx = 0.034;                 % meters of element spacing in x-direction
nb_f = 2500;               % narrowband (nb) frequency in Hz
dy_g = 0.017;
lambda= 340/nb_f;
theta_ref = -180:180;
B = (1/J^2).*abs((sind(J*pi*sind(theta_ref)*(dx/lambda)))./(sind(pi*sin(theta_ref)*(dx/lambda))))^2;
disp(B)