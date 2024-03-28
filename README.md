# Wing-spar-design
The objective of this work is to develop tools to design and optimize the shape of a spar of a wing, which
will be used in building a telecommunication airplane. Specifically, the aim is to design the annulus circular
beam with a minimum weight that can withstand the load of 2.5g during the maneuver and meet the
manufacturing constraints. The length of the beam has been determined to be 7.5 m by aerodynamics
analysis, whereas the thickness of the beam should remain greater than 0.0025 m throughout the length due
to manufacturing constraints. The material is assumed to have constant density and bear the load linearly.  
The numerical computational optimization method has been leveraged here to implement the analysis as I
need to find the optimal radii out of myriad radii that are time-consuming for analytical or experimental
methods. The radii are a function of distance from the tip of the wing and must satisfy the load/stress
constraints. The bar is modeled using Euler-Bernoulli beam theory with some assumptions on planer
symmetry, normality, strain energy, linearization, material, and cross-sectional variation. The beam
geometry was discretized and the differential equations were solved using the finite element method
satisfying the boundary conditions. After setting up the problem, I used the “active-set” algorithm in the
“fmincon” function in Matlab
®
 where the gradients computed for the objective and the nonlinear constraints
using a complex step method were provided to “fmincon” for determining the design variables i.e. the radii. 
The nominal spar mass was found to be 13.257 Kg and the optimal spar mass was found to be ~ 4.877 Kg
which is 63.208% lower than the nominal mass. The optimal mass was seen to decrease gradually with each 
iteration during the optimization as expected for convergence. The performance was found to be increasing
with an increase in the number of finite elements which means the accuracy of the optimization method
improves with an increase in discretization. This was a required behavior to check if the program and model
were behaving as it is supposed to. Note that, the gradients computed with the complex step method were 
verified with the “fmincon” gradient check, which validated the code, before using them for optimization. 
The end product of this project is a computer code that can predict an optimal mass and
configuration/geometry for a wing spar given only a few constraints (minimal thickness, geometrical
dimensions, etc.). The design optimization method facilitated a comparison of different configuration and
select the optimal one. 

![SparShape](https://github.com/anilkamat/Wing-spar-design/assets/61370051/235740f4-542f-4053-bfb1-a57e2f2f4f25)
![Mesh_refinement](https://github.com/anilkamat/Wing-spar-design/assets/61370051/8d8a096e-0f51-4a56-b712-71bfc2d193ff)
![Force_distribution](https://github.com/anilkamat/Wing-spar-design/assets/61370051/370ed09b-30c2-4f02-8c75-bc16fb0af256)
![Nodal_displacements](https://github.com/anilkamat/Wing-spar-design/assets/61370051/46ee9054-0ee9-443e-9cdd-36d0adff83e2)
