clc
clear all
%5.1.3
% Given values
M = 0.4480223834;  % mean anomaly
e = 0.3765106201e-002;   % eccentricity
sqrta = 5153.614258;  % square root of the semi-major axis length
a = sqrta^2; %length of the semi major axis
RE = 6358000; % Radius of the Earth in meters
Omega = 0.7017688714; %Right Acension
incl = 0.9617064849; %orbital inclination
w = 0.434909394; %argumenbt of perigee
thetaE = deg2rad(39); %Earth Station Latitude
phiE = deg2rad(77); %Earth station longitude

% Function definition
f = @(E) E - e*sin(E) - M;

% Derivative of the function 
df = @(E) 1 - e*cos(E);

% Initial guess

E0 = 1;

% Set a tolerance for convergence
tolerance = 1e-6;

% Maximum number of iterations
maxIterations = 100;

% Newton-Raphson method
E = E0;
for i = 1:maxIterations
    ENew = E - f(E) / df(E);

    % Check for convergence
    if abs(ENew - E) < tolerance
        fprintf('Converged to solution: E = %.6f\n', ENew);
        break;
    end

    % Update E for the next iteration
    E = ENew;
end

% Display a message if the maximum number of iterations is reached
if i == maxIterations
    fprintf('Maximum number of iterations reached. No convergence.\n');
end

x0 = a*(cos(E)-e);
y0 = a*((1-e^2)^0.5)*sin(E);
r = (x0^2+y0^2)^0.5;
% 
% Px = cos(w)*cos(Omega)- sin(w)*sin(Omega)*cos(incl);
% Py = cos(w)*sin(Omega) +sin(w)*cos(Omega)*cos(incl);
% Pz = sin(w)*sin(incl);
% Qx = -sin(w)*cos(Omega) - cos(w)*sin(Omega)*cos(incl);
% Qy = -sin(w)*sin(Omega) + cos(w)*cos(Omega)*cos(incl);
% Qz = cos(w)*sin(incl);
% 
% x= Px*x0 + Qx*y0;
% y= Py*x0 + Qy*y0;
% z = Pz*x0 + Qz*y0;
% 
% decl = atan(z/sqrt(x^2+y^2));
% alpha = atan(y/x);
decl = pi/2 - incl;
phiSE = phiE-Omega;
etaS = asin(sin(decl)*sin(thetaE)+cos(decl)*cos(thetaE)*cos(phiSE));

El = rad2deg(atan((sin(etaS)-(RE/r))/cos(etaS)));
Az = rad2deg(atan(sin(phiSE)/(cos(thetaE)*tan(decl)-sin(thetaE)*cos(phiSE))));

fprintf('Azimuth = %.6f\n', Az);
fprintf('Elevation = %.6f\n', El);