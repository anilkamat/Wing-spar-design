function F = forceDist(x)
% returns for distribution of the spar
% Inputs 
%     x: nodal points
% Outputs
%     F: force distribution

W0 = 1633.33;           % weight/length 
L = 7.5;                % m (length of spar)
n = size(x,1);
F = zeros(n,1);         % force
for i=1:n
    F(i) = W0/L*(L-x(i));
end

end
