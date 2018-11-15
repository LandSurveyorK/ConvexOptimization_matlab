function [error,trainError,testError] = IRLS(trainRatings,trainLabels,testRatings,testLabels)
   X = [ones(size(trainRatings,1),1),trainRatings];
   y = trainLabels;
   testX = [ones(size(testRatings,1),1),testRatings];
   testy = testLabels;
   [n,m] = size(X);
   optimalValue = 186.637;
   alpha = 0.01 ; beta = 0.9;
   err = 1; k =0;
   error = [];
   b = zeros(m,1);
   [f_old,u] = NLL(X,y,b);
   
   while (abs(err) >1e-6)
        
         Hessian = X'*diag(u)*(eye(n)-diag(u))*X;
         Gradient = X'*(u-y);
         v = - Hessian \ Gradient;
      
     t = 1;
     update = 1;
     while (update == 1) 
         
         [f_new,u_new] = NLL(X,y,b+t*v);
         
         if f_new > f_old + alpha * t * Gradient' * v
             update = 1 ;
             t = beta * t ;
         else 
             update = 0;
             b = b + t*v;
             u = u_new ;
         end
     end
     
     err =  f_old - f_new;
     f_old= f_new;
     k = k + 1;
     error(k) = log(abs(f_old - optimalValue));
      
   end
   trainError  = classificationError(X,y,b);
   testError = classificationError(testX,testy,b);
   
end


    
    
    