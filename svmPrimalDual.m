function [trainError,testError,numnotzero]= svmPrimalDual(trainRatings,trainLabels,testRatings,testLabels)
    
    alpha = 0.01; beta = 0.5;
    X= trainRatings; y = 2* trainLabels-ones(size(trainLabels,1),1); 
    testX = testRatings; testy = 2 * testLabels - ones(size(testLabels,1),1);
    trainError = []; testError = [];  
    k = 0;
    n = size(X,1); numnotzero = n;
    [K,KK] = svmKernal(X,y);
    
    w = svmInitial(trainLabels);  % intial w
    u = ones(n,1);
    v = ones(n,1);
    U = [u;v];  % initial U 
    lambda = 0;   % inital lambda
    stop = 0 ;
    
       [sGap,R,Grad_h,h] = svmResidual(K,w,U,lambda,y);  
       
       
      while(stop == 0)
          k = k + 1;    
          row1 = [-K, Grad_h,y]; % n*n n* 2n n*1
          row2 = [diag(U)*Grad_h',diag(h),zeros(2*n,1)]; %  2n * n 2n * 2n   2n*1
          row3 = [y', zeros(1,2*n),0]; % 1*n 1*2n 1*1
           % (n + 2n + 1)* (n + 2n +1)
          NewHessian = [row1;row2;row3];
          
           Delta = - inv(NewHessian) * R ;
           Delta_w = Delta(1:n);
           Delta_U = Delta(n+1:3*n);
           Delta_lambda = Delta(3*n+1);
        % choose a appropriate \theta
        Max = 1 ;
        for i = 1 : 2*n
            if Delta_U < 0 
                Max = min(Max,-U(i)/ Delta_U(i));
            end
        end
        % backtraking line search
        q = 0.99 * Max;
        i = 0;
        while (i < 1)
            new_w = w + q * Delta_w;
            new_U = U + q * Delta_U;
            new_lambda = lambda + Delta_lambda;
            [sGap,new_R,Grad_h,h] = svmResidual(K,new_w,new_U,new_lambda,y);
            if norm(new_R) < (1-alpha *q) * norm(R)
                i = i + 1;
            else 
                q = beta * q;
            end
        end
        while(i < n+1)
            new_w = w + q * Delta_w;
            if h(i) < 0 &&  h(n+i)< 0
                 i = i + 1;
             else 
                 q = beta * q;
             end
        end
        
        w = new_w;
        U = new_U;
        lambda = new_lambda;
        
        [trainError(k),testError(k)] = svmclassErr(X,y,testX,testy,KK,w);
        trainError(k)
        testError(k)
        
        for i = 1 : n
          if w(i) < 1e-6
              numnotzero = numnotzero - 1;
           end
        end 
        %  stop or not ?
        if ( norm (R(1:n))^2 + norm(R(n+1:3*n))^2 > 1e-6) ||   sGap >2e-6
            stop = 0;
        else 
            stop = 1;
        end
        
      end    
end

        
        
        
        
      
            
                
                
        
        
        
           
          
          
      
      
      
    