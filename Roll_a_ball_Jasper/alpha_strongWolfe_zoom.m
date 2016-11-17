function [ alpha ] = alpha_strongWolfe_zoom(func, grad, x, p, alpha_lo, alpha_hi, c1, c2)
%ALPHA_STRONGWOLFE_ZOOM     Zoom function (Algorithm 3.6)
% func                      - Function
% grad                      - Gradient
% x                         - Current iterate.
% p                         - Search direction.
% alpha_lo                  - Initial lower bound for alpha
% alpha_hi                  - Initial upper bound for alpha
% c1                        - Constant parameter that is used for satisfying
%                               the Wolfe sufficient decrease condition
% c2                        - Constant parameter that is used for
%                               satisfying the Wolfe curvature condition

%Initializing variables to be used during the zoom iterations
alpha = 0;
phi = 0;
phi_grad = 0;
done = false;

while (~done) 
    alpha = 0.5 * (alpha_lo + alpha_hi);
    phi = func(x + alpha*p);
    if ( phi > (func(x) + c1*alpha*grad(x)'*p) ) || ( phi >= func(x + alpha_lo*p) )
        alpha_hi = alpha;
    else
        phi_grad = grad(x + alpha*p)'*p;
        if ( abs(phi_grad) <= -c2*grad(x)'*p )
            done = true;
            break;
        end
        if ( phi_grad*(alpha_hi - alpha_lo) >= 0 )
            alpha_hi = alpha_lo;  
        end
        alpha_lo = alpha;
    end
end
end