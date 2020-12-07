% Class: Vector Dynamics
% Date: 12-07-2020

% This code is meant to simulate the position of a passenger riding the
% Centrifuge amusement ride at California's Great America.

% The Centrifuge consists of a spinning circular floor tilted at an angle.
% Like spokes on a wheel, passengers ride on coasters which are attached to a hub that rotates independently of the floor.
% Ride operations allow for the control of the angular velocity of both the floor and the coaster hubs.
% The floor rotates clockwise while the hubs rotate counter-clockwise.

% Constants
x1 = 10; % x-distance from observer to the center of base in meters
y1 = 10; % y-distance from observer to the center of base in meters
L = 7; % radial distance from the center of base to the coaster hub in meters
D = 2; % radial distance from the center of the coaster hub to the passenger in meters
alpha = 10; % angle the base is tilted in the x-direction of the observer in degrees

theta = 0; % initial angle of the base in respect to the observer's horizontal in degrees
phi = 0; % initial angle of the coaster hub in respect to the base's horizontal in degrees
thetadot = -5; % angle change of theta in degrees/second (controlled by operator irl)
phidot = 10; % angle change of phu in degrees/second (controlled by operator irl)

timelength = 180;% how much time should be simulated in seconds (~3min irl)
checkspersecond = 3; % how many times a point should be plotted every second (higher number = "less choppy")

% Adjust the time constraints
thetadot = thetadot/checkspersecond;
phidot = phidot/checkspersecond;
timelength = timelength*checkspersecond;

% Initialize counter and preallocate the combined matrix as zeros
q=1;
xmatrix = zeros(1,timelength);
ymatrix = zeros(1,timelength);
dmatrix = zeros(1,timelength);

% Main loop that generates the matrices containing position data
while q ~= timelength+1

    % Adjust theta when it's greater than 360
    if theta>=360
        theta = 360 - theta;
    end

    % Adjust phi when it's greater than 360
    if phi>=360
        phi = 360 - phi;
    end

    % Position equations in the n-frame
    xcurrent = x1 + L*cosd(theta)*cos(alpha) + D*cosd(phi)*cosd(alpha);
    ycurrent = y1 + L*sind(theta) + D*sind(phi);
    dcurrent = sqrt( (xcurrent)*(xcurrent) + (ycurrent)*(ycurrent) );

    % Construct the matrices that will be used to plot the graph
    xmatrix(q,1) = xcurrent;
    ymatrix(q,1) = ycurrent;
    dmatrix(q,1) = dcurrent;
    
    % Adjust the variables and move on to the next loop
    q = q + 1;
    theta = theta + thetadot;
    phi = phi + phidot;
end

% Set matrices to variables to make plotting code easier to read
x = xmatrix;
y = ymatrix;
d = dmatrix;

% Plotting code
% comet(1:(length(d)),d); % Enable this line of code to view the distance between the passenger and an observer

comet(x,y); % Enable this line of code to view the position of a passenger
axis equal; % The axes will be square *after* the animation has completed. Do not enable if using the distance code
