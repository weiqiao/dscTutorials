function dz = dynamics_5_link(~,z,P) 
%DZ = DYNAMICS_5_LINK(T,Z,P)
% 
%FUNCTION:  This function computes the dynamics of a 5
%    link pendulum, and is designed to be called from ode45.
%    The model allows for arbitrary mass and inertia for each
%    link, but no friction or actuation
% 
%INPUTS: 
%    t = time. Dummy input for ode45. Not used.
%    z = [10 X nTime]  matrix of states
%    P = struct of parameters
%OUTPUTS: 
%    dz = [10 X nTime]  matrix of state derivatives
% 
%NOTES:
%    This file was automatically generated by writeDynamics.m

g  = P.g ; %gravity
m1 = P.m(1); % Link 1 mass
m2 = P.m(2); % Link 2 mass
m3 = P.m(3); % Link 3 mass
m4 = P.m(4); % Link 4 mass
m5 = P.m(5); % Link 5 mass
l1 = P.l(1); % Link 1 length
l2 = P.l(2); % Link 2 length
l3 = P.l(3); % Link 3 length
l4 = P.l(4); % Link 4 length
l5 = P.l(5); % Link 5 length
I1 = P.I(1); % Link 1 moment of inertia about its center of mass
I2 = P.I(2); % Link 2 moment of inertia about its center of mass
I3 = P.I(3); % Link 3 moment of inertia about its center of mass
I4 = P.I(4); % Link 4 moment of inertia about its center of mass
I5 = P.I(5); % Link 5 moment of inertia about its center of mass
d1 = P.d(1); % Link 1 distance between center of mass and parent joint
d2 = P.d(2); % Link 2 distance between center of mass and parent joint
d3 = P.d(3); % Link 3 distance between center of mass and parent joint
d4 = P.d(4); % Link 4 distance between center of mass and parent joint
d5 = P.d(5); % Link 5 distance between center of mass and parent joint

nTime = size(z,2);
dz = zeros(size(z)); 
M = zeros(5,5,nTime);
f = zeros(5,nTime);

th1 = z(1,:); 
th2 = z(2,:); 
th3 = z(3,:); 
th4 = z(4,:); 
th5 = z(5,:); 

dth1 = z(6,:); 
dth2 = z(7,:); 
dth3 = z(8,:); 
dth4 = z(9,:); 
dth5 = z(10,:); 

dz(1,:) = dth1; 
dz(2,:) = dth2; 
dz(3,:) = dth3; 
dz(4,:) = dth4; 
dz(5,:) = dth5; 

M(1,1,:) = - I1 - d1.^2.*m1 - l1.^2.*m2 - l1.^2.*m3 - l1.^2.*m4 - l1.^2.*m5;
M(1,2,:) = - d2.*l1.*m2.*cos(th1 - th2) - l1.*l2.*m3.*cos(th1 - th2) - l1.*l2.*m4.*cos(th1 - th2) - l1.*l2.*m5.*cos(th1 - th2);
M(1,3,:) = - d3.*l1.*m3.*cos(th1 - th3) - l1.*l3.*m4.*cos(th1 - th3) - l1.*l3.*m5.*cos(th1 - th3);
M(1,4,:) = - d4.*l1.*m4.*cos(th1 - th4) - l1.*l4.*m5.*cos(th1 - th4);
M(1,5,:) = -d5.*l1.*m5.*cos(th1 - th5);
M(2,1,:) = - d2.*l1.*m2.*cos(th1 - th2) - l1.*l2.*m3.*cos(th1 - th2) - l1.*l2.*m4.*cos(th1 - th2) - l1.*l2.*m5.*cos(th1 - th2);
M(2,2,:) = - I2 - d2.^2.*m2 - l2.^2.*m3 - l2.^2.*m4 - l2.^2.*m5;
M(2,3,:) = - d3.*l2.*m3.*cos(th2 - th3) - l2.*l3.*m4.*cos(th2 - th3) - l2.*l3.*m5.*cos(th2 - th3);
M(2,4,:) = - d4.*l2.*m4.*cos(th2 - th4) - l2.*l4.*m5.*cos(th2 - th4);
M(2,5,:) = -d5.*l2.*m5.*cos(th2 - th5);
M(3,1,:) = - d3.*l1.*m3.*cos(th1 - th3) - l1.*l3.*m4.*cos(th1 - th3) - l1.*l3.*m5.*cos(th1 - th3);
M(3,2,:) = - d3.*l2.*m3.*cos(th2 - th3) - l2.*l3.*m4.*cos(th2 - th3) - l2.*l3.*m5.*cos(th2 - th3);
M(3,3,:) = - I3 - d3.^2.*m3 - l3.^2.*m4 - l3.^2.*m5;
M(3,4,:) = - d4.*l3.*m4.*cos(th3 - th4) - l3.*l4.*m5.*cos(th3 - th4);
M(3,5,:) = -d5.*l3.*m5.*cos(th3 - th5);
M(4,1,:) = - d4.*l1.*m4.*cos(th1 - th4) - l1.*l4.*m5.*cos(th1 - th4);
M(4,2,:) = - d4.*l2.*m4.*cos(th2 - th4) - l2.*l4.*m5.*cos(th2 - th4);
M(4,3,:) = - d4.*l3.*m4.*cos(th3 - th4) - l3.*l4.*m5.*cos(th3 - th4);
M(4,4,:) = - I4 - d4.^2.*m4 - l4.^2.*m5;
M(4,5,:) = -d5.*l4.*m5.*cos(th4 - th5);
M(5,1,:) = -d5.*l1.*m5.*cos(th1 - th5);
M(5,2,:) = -d5.*l2.*m5.*cos(th2 - th5);
M(5,3,:) = -d5.*l3.*m5.*cos(th3 - th5);
M(5,4,:) = -d5.*l4.*m5.*cos(th4 - th5);
M(5,5,:) = - I5 - d5.^2.*m5;

f(1,:) = - d1.*g.*m1.*cos(th1) - g.*l1.*m2.*cos(th1) - g.*l1.*m3.*cos(th1) - g.*l1.*m4.*cos(th1) - g.*l1.*m5.*cos(th1) - d2.*dth2.^2.*l1.*m2.*sin(th1 - th2) - d3.*dth3.^2.*l1.*m3.*sin(th1 - th3) - d4.*dth4.^2.*l1.*m4.*sin(th1 - th4) - d5.*dth5.^2.*l1.*m5.*sin(th1 - th5) - dth2.^2.*l1.*l2.*m3.*sin(th1 - th2) - dth2.^2.*l1.*l2.*m4.*sin(th1 - th2) - dth2.^2.*l1.*l2.*m5.*sin(th1 - th2) - dth3.^2.*l1.*l3.*m4.*sin(th1 - th3) - dth3.^2.*l1.*l3.*m5.*sin(th1 - th3) - dth4.^2.*l1.*l4.*m5.*sin(th1 - th4);
f(2,:) = d2.*dth1.^2.*l1.*m2.*sin(th1 - th2) - g.*l2.*m3.*cos(th2) - g.*l2.*m4.*cos(th2) - g.*l2.*m5.*cos(th2) - d2.*g.*m2.*cos(th2) - d3.*dth3.^2.*l2.*m3.*sin(th2 - th3) - d4.*dth4.^2.*l2.*m4.*sin(th2 - th4) - d5.*dth5.^2.*l2.*m5.*sin(th2 - th5) + dth1.^2.*l1.*l2.*m3.*sin(th1 - th2) + dth1.^2.*l1.*l2.*m4.*sin(th1 - th2) + dth1.^2.*l1.*l2.*m5.*sin(th1 - th2) - dth3.^2.*l2.*l3.*m4.*sin(th2 - th3) - dth3.^2.*l2.*l3.*m5.*sin(th2 - th3) - dth4.^2.*l2.*l4.*m5.*sin(th2 - th4);
f(3,:) = d3.*dth1.^2.*l1.*m3.*sin(th1 - th3) - g.*l3.*m4.*cos(th3) - g.*l3.*m5.*cos(th3) - d3.*g.*m3.*cos(th3) + d3.*dth2.^2.*l2.*m3.*sin(th2 - th3) - d4.*dth4.^2.*l3.*m4.*sin(th3 - th4) - d5.*dth5.^2.*l3.*m5.*sin(th3 - th5) + dth1.^2.*l1.*l3.*m4.*sin(th1 - th3) + dth1.^2.*l1.*l3.*m5.*sin(th1 - th3) + dth2.^2.*l2.*l3.*m4.*sin(th2 - th3) + dth2.^2.*l2.*l3.*m5.*sin(th2 - th3) - dth4.^2.*l3.*l4.*m5.*sin(th3 - th4);
f(4,:) = d4.*dth1.^2.*l1.*m4.*sin(th1 - th4) - g.*l4.*m5.*cos(th4) - d4.*g.*m4.*cos(th4) + d4.*dth2.^2.*l2.*m4.*sin(th2 - th4) + d4.*dth3.^2.*l3.*m4.*sin(th3 - th4) - d5.*dth5.^2.*l4.*m5.*sin(th4 - th5) + dth1.^2.*l1.*l4.*m5.*sin(th1 - th4) + dth2.^2.*l2.*l4.*m5.*sin(th2 - th4) + dth3.^2.*l3.*l4.*m5.*sin(th3 - th4);
f(5,:) = d5.*dth1.^2.*l1.*m5.*sin(th1 - th5) - d5.*g.*m5.*cos(th5) + d5.*dth2.^2.*l2.*m5.*sin(th2 - th5) + d5.*dth3.^2.*l3.*m5.*sin(th3 - th5) + d5.*dth4.^2.*l4.*m5.*sin(th4 - th5);

for i=1:nTime 
    MM = M(:,:,i);  ff = f(:,i); 
    dz(6:10,i) = -MM \ ff;
end 

end 
