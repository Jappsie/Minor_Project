function [ alpha ] = alpha_strongWolfe( func, grad, x, p, steplengthParam )
%ALPHA_STRONGWOLFE          Line Search function (Algorithm 3.5)
% func                      - Function
% grad                      - Gradient
% x                         - Current iterate.
% p                         - Search direction.
% steplengthParam           - Array containing the following parameters in
%                               their respective order:
%        c1                        - Constant parameter that is used for satisfying
%                                     the Wolfe sufficient decrease condition
%        c2                        - Constant parameter that is used for
%                                     satisfying the Wolfe curvature condition
%        alpha_1                  - Initial guess for alpha
%        alpha_max                - Initial upper bound for alpha
%        gamma                    - Constant parameter that is used to
%                                     determin the next alpha during the Line Search

%Initializing variables to be used during the line search iterations
%[c1, c2, alpha_cur, alpha_max, gamma] = steplengthParam;
alpha_prev = 0;
c1 = steplengthParam(1);
c2 = steplengthParam(2);
alpha_cur = steplengthParam(3);
alpha_max = steplengthParam(4);
gamma = steplengthParam(5);
alpha = 0;
done = false;
it = 1;

while (~done)
    phi = func(x + alpha_cur*p);
    phi_grad = grad(x + alpha_cur*p)'*p;
    if (phi > func(x) + c1*alpha_cur*grad(x)'*p || (phi >= func(x + alpha_prev*p) && it > 1))
        alpha = alpha_strongWolfe_zoom(func, grad, x, p, alpha_prev, alpha_cur, c1, c2);
        done = true;
        break;
    end
    if (abs(phi_grad) <= -c2*grad(x)'*p)
        alpha = alpha_cur;
        done = true;
        break;
    end
    if (phi_grad >= 0)
        alpha = alpha_strongWolfe_zoom(func, grad, x, p, alpha_cur, alpha_prev, c1, c2);
        done = true;
        break;
    end
    alpha_prev = alpha_cur;
    alpha_cur = gamma * alpha_cur;
    it = it + 1;
end
end



