A = rand(50,30);
x = rand(30,1);
b = A*x;

x_e = A\b;
[x_lsqr,rmse] = damped_lsqr(A,50,30,b,0,30);
x_e_error = norm(x - x_e)
x_lsqr_error = norm(x - x_lsqr)
figure;plot(rmse)