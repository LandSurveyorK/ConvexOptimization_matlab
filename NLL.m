function [f,u] = NLL(X,y,b)
    n = size(X,1);
    u =zeros(n,1);
    f = 0;
    for i = 1 : n 
       u(i) = 1.0 * exp(X(i,:)*b) / (1 + exp(X(i,:)*b));
       f = f - y(i)*(X(i,:)*b)+ log(1 + exp(X(i,:)*b));
    end
  end
   