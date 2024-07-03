% Cubic polynomial interpolation between q_0 and q_1 with initial velocity dq_0 and final velocity dq_1
function [a, b, c, Delta_q] = CubicPolynomial(q_0, q_1, dq_0, dq_1)
    arguments (Input)
        q_0     (1, :) double
        q_1     (1, :) double
        dq_0    (1, :) double
        dq_1    (1, :) double
    end
    
    % Compute the matrices of the linear system needed for the polynomial
    A           = [1 1 1; 
                   0 0 1;
                   3 2 1];
    Delta_q     = q_1 - q_0;
    B           = [ones(size(Delta_q)); dq_0./Delta_q; dq_1./Delta_q];
    X           = A\B;

    % Assign the output
    a           = X(1, :)';
    b           = X(2, :)';
    c           = X(3, :)';
    Delta_q     = Delta_q';

end