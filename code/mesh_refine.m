function [] = mesh_refine(L, E,U, algo,rho)
% Runs the mesh_refine algorithm by increaseing the number of elements

num_mesh    = 50;       % number of mesh; +2
OptimalMass = zeros(num_mesh-1,1);
type        = 'refine';

for i =2:num_mesh       % Loop for mesh refinment
    %clc;
    fprintf('Running refinment for %d elements',i);
    Nelem   = i;
    h0      = zeros(2*(Nelem+1),1);
    Nx      = Nelem+1;
    x       = linspace(0,7.5,Nx)';
    p       =1;
    for j=1:(Nelem+1)               % initilization
        h0(p)   = 0.05;             % height of outer heights
        h0(p+1) = 0.04635;          % height of inner heights
        p       = p+2;
    end
    [h_coef_minimizer,~] = optimize(x, h0, L, E, Nx, Nelem, U, algo, type);
    OptimalMass(i-1)       = CalcSparWeight(rho,x,h_coef_minimizer);
end

figure()
plot(OptimalMass,'linewidth',2)
title('Mesh refinement')
xlabel('number of element')
ylabel('Optimal Mass')
end