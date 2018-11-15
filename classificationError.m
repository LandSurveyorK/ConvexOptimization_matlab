function errorRate = classificationError(X,y,w)
      [n,m] = size(X);
      b = w(1:m);
      errorRate = 0 ;
      for i = 1 : n 
           u = 1.0 * exp(X(i,:)*b) / (1 + exp(X(i,:)*b));
           if u > 0.5
               yhat = 1;
           else 
               yhat = 0;
           end
           if y(i) ~= yhat
               errorRate = errorRate + 1;
           end
      end
      errorRate = 1.0 * errorRate / n;
end
