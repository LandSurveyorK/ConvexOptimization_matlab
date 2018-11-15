function [sGap,R,Grad_h,h] = svmResidual(K,w,U,lambda,y)
    C = 1000;
    n = size(y,1); m = 2*n;
    sigma = 0.5; % sigma \in (0,1)
    h = zeros(2*n,1);
    for i = 1 : n
        h(i) = -w(i);
        h(n+i)  = w(i) - C;
    end
    
      Grad_h = [-eye(n,n),eye(n,n)];
      tau = - (h'*U) / m;
      t = sigma * tau;  % update t in svmPrimialDual
      
      Rdual = ones(n,1) - K * w + Grad_h * U + lambda*y; % n 
      Rcent = diag(U) * h +t * ones(2*n,1); % 2n
      Rprim = y'*w; % 1
      
      R =[Rdual;Rcent;Rprim];
      sGap = tau * m;
end

   
      