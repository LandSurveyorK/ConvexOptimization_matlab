function f = fPlugin(X,y,w)
    [n,m] = size(X);
    u = zeros(n,1);
    lambda =15;
    size(w);
    b = w(1:m); z = w(m+1 : 2*m-1);
    
    f = 0;
    for i = 1 : n 
       u(i) = 1.0 * exp(X(i,:)*b) / (1 + exp(X(i,:)*b));
       f = f +  ( - y(i)*(X(i,:)*b)+ log(1 + exp(X(i,:)*b)) );
    end
   
    for i = 1 : m-1
        f = f + lambda*z(i);
    end