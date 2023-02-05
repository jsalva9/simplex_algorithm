# Simplex Algorithm

This is a Matlab implementation of the Simplex Algorithm, done for an assignment in a course on Operations Research.

### Implementation details
There are two main functions: `Simplex` and `Fase 1` (phase 1). 

Simplex does one iteration of the Simplex method. That is, given matrix A and vectors b, c that describing the problem $\min_x cx$, st: $Ax \leq b$, and a set of basic variables, returns a either the optimal (or another set of basic variables if the optimal has not been found). 

Our implementation uses the update of the inverse matrix trick. We do not compute inverses of matrices and therefore provide faster runtimes. 

`Fase 1` (phase 1) is a function that formulates and solves the phase 1 problem to find an initial feasible basic solution. It uses the `Simplex` method to solve the formulated problem.

`Read` is an auxiliar module that reads the input data.
