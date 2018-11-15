function [trainError,validError,w,dualGap] = barrierOut(trainRatings,trainLabels,testRatings,testLabels)
      alpha = 0.2 ; beta = 0.9;
      T =5; mu = 20;
      optimalValue = 306.476;
      X = [ones(size(trainRatings,1),1),trainRatings];
      y = trainLabels;
      VX = [ones(size(testRatings,1),1),testRatings];
      Vy = testLabels;
      m = size(X,2);
      M = 2.0*m-1; k =0;
      trainError = [];
      validError = [];
      dualGap = [];
      
       %  linprog(f,A,b,Aeq,beq,lb,ub)
      
       w0 = initialBarrier(m);  % the initial of barrier problem
       [fw,w] = barrier(X,y,w0,T,alpha,beta); 
        % the initial of central path
      
      while (M / T > 1e-9)
          k = k + 1;
          T = mu * T
          [fw,w] = barrier(X,y,w,T,alpha,beta);
          dualGap(k) = fw - optimalValue;
          trainError(k) = classificationError(X,y,w);
          validError(k) = classificationError(VX,Vy,w);
      end
end

     
      