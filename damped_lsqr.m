function [x] = damped_lsqr(A,b,N,lambda,n_iter)

x = zeros(N,1);

u = b;

beta = norm(u(:));
u = u./beta;

v = A'*u;
alpha = norm(v(:));
v = v./alpha;

w = v;
rhobar = alpha;
phibar = beta;

% rmse = zeros(n_iter,1);
for iter = 1:1:n_iter
    u = -alpha * u;
    u = u + A*v;
    beta = norm(u(:));
    u = u./beta;
    
    v = -beta*v;
    v = v + A'*u;
    alpha = norm(v(:));
    v = v./alpha;
    
    rhbar1 = rhobar;
    
    if (lambda > 0)
        rhbar1 = sqrt(rhobar*rhobar + lambda*lambda);
        c1 = rhobar / rhbar1;
        s1 = lambda / rhbar1;
        psi = s1*phibar;
        phibar = c1*phibar;
    end
    
    rho = sqrt(rhbar1*rhbar1 + beta*beta);
    c = rhbar1/rho;
    s = beta/rho;
    theta = s*alpha;
    rhobar = -c*alpha;
    phi = c*phibar;
    phibar = s*phibar;
    
    x(:) = x(:) + (phi/rho) * w;
    w = v + (-theta/rho) * w;
    
%     if(1)
%         b_recon = A*x;
%         b_error = norm(b - b_recon);
%         rmse(iter) = b_error;
%     end
    
end
    
    
    
    
