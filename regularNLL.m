% F_VALUE, GRADIENT, STEP
function [f,Gradient,v] = regularNLL(X,y,w,T)
    lambda = 15;
    [n,m] = size(X);
    u = zeros(n,1);
    size(w);
    b = w(1:m) ;
    z = w(m+1 : 2*m-1);
    
    f = 0;
    for i = 1 : n 
       u(i) = 1.0 * exp(X(i,:)*b) / (1 + exp(X(i,:)*b));
       f = f + T* ( - y(i)*(X(i,:)*b)+ log(1 + exp(X(i,:)*b)) );
    end
   
    for i = 1 : m-1
        f = f + T * lambda*z(i) - log( z(i)^2 - b(i+1)^2 );
    end
    
         Gradient1 = T * X'*(u-y);
         Gradient2 = T * lambda*ones(m-1,1);
         Hessian1 = T * X'*diag(u)*(eye(n)-diag(u))*X;
         Hessian2 = zeros(m-1,m-1);
         for i = 1 : m-1
             Gradient1(i+1) = Gradient1(i+1) + 2 * b(i+1) / (z(i)^2-b(i+1)^2);
             Gradient2(i) = Gradient2(i) - 2 * z(i) / (z(i)^2-b(i+1)^2);
             Hessian1(i+1,i+1) = Hessian1(i+1,i+1) + 2 * ( z(i)^2+b(i+1)^2 ) / ( (z(i)^2-b(i+1)^2)^2 );
             Hessian2(i,i) = Hessian2(i,i) + 2 * ( z(i)^2+b(i+1)^2 ) / ( (z(i)^2 - b(i+1)^2)^2 );
         end
          
         Gradient = [Gradient1;Gradient2];
         Hessian  = blkdiag(Hessian1,Hessian2);
         v = - Hessian\Gradient;
  end
   