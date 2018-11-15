function [trainError,testError,objValue,numnotzero]= svmOut(trainRatings,trainLabels,testRatings,testLabels)
    
    
    X= trainRatings; y = 2* trainLabels-ones(size(trainLabels,1),1); 
    testX = testRatings; testy = 2 * testLabels - ones(size(testLabels,1),1);
    trainError = []; testError = [];  
    T = 1000; k = 0;
    n = size(X,1); mu = 1.5;
    m = 2.0 * n; 
    numnotzero = n;
    
    [K,KK] = svmKernal(X,y);
    w0 = svmInitial(trainLabels);
    [fw,w] = svmBarrier(K,y,T,w0); 
    

    while(m / T >1e-8)
        k = k + 1;
          T = mu * T;
          [fw,w] = svmBarrier(K,y,T,w);
          objValue(k) = fw;
          [trainError(k),testError(k)] = svmclassErr(X,y,testX,testy,KK,w); 
          trainError(k)
          testError(k)
    end
    
    for i = 1 : n
        if w(i) < 1e-6
            numnotzero = numnotzero - 1;
        end
    end 
   
        
end

        