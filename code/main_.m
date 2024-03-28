% Main function to do the experiments.
clear all; clc; close all; format long;
% constants
rho     = 1600;                       % kg/m^3
E       = 70*10^9;                    % pascal
U       = 600*10^6;                   % pascal
Weight_plane = 500;                   % Kg
L       = 7.5;                        % spar length (m)
Nelem   = 5;                         % number of elements
Nx      = Nelem+1;                    % number of nodes or x
x       = linspace(0,7.5,Nx)';
p       = 1;
h0      = zeros(2*(Nelem+1),1);
for i=1:(Nelem+1)                     % initilization
    h0(p)   = 0.05;                   % height of outer heights
    h0(p+1) = 0.04635;                % height of inner heights
    p       = p+2;
end
% computes nominal 
force   = forceDist(x);               % compute nominal force displacements
figure()
plot(force,'linewidth',2);
title('force distribution')
xlabel('Nodes')
ylabel('force')

[Nominal_Spar_weight, grad_nominal]=  obj(h0,x);

fprintf('\n nominal spar weight: %f',Nominal_Spar_weight);

Iyy = AreaMomentIyy(h0);
%%
type = 'nominal'; algo = 'active-set';

[h_coef_minimizer,fval] = optimize(x, h0, L, E, Nx, Nelem, U, algo,type);
final_stress_dist = stress_dist(L,E,Nelem,h_coef_minimizer,U,force);                 % impose non-linear constraints.

optimal_mass    = CalcSparWeight(rho,x,h_coef_minimizer);

percent         = (Nominal_Spar_weight- optimal_mass)/Nominal_Spar_weight*100;
fprintf('\n The optimal mass is %f ', optimal_mass);
fprintf('\n The optimal mass is %f %% of Nominal', percent);

% refinement effect
%mesh_refine(L, E,U, algo,rho);

h = reshape(h_coef_minimizer,2,[])';
optimal_thickness = h(:,1)-h(:,2);
for i = 1:numel(optimal_thickness)
    if optimal_thickness(i) < 0.0025
        fprintf('Thickness is above the minimum thickness');
    end
end

figure()
plot(h(:,1),'linewidth',2 ) ; hold on
plot(h(:,2), 'linewidth',2) ; hold on
plot(-h(:,1),'linewidth',2) ; hold on
plot(-h(:,2),'linewidth',2)
legend('top surface','inner surface')
xlabel('Nodes')
ylabel('Heights from center')
ttl = sprintf('Spar optimal shape with %d elements',Nelem);
title(ttl)

h0 = reshape(h0,2,[])';
%%
figure()
plot(h0(:,1),'linewidth',2 ) ; hold on
plot(h0(:,2), 'linewidth',2) ; hold on
plot(-h0(:,1),'linewidth',2) ; hold on
plot(-h0(:,2),'linewidth',2)
legend('top surface','inner surface')
xlabel('Nodes')
ylabel('Heights from center')
ttl = sprintf('Nominal shape with %d elements',Nelem);
title(ttl)