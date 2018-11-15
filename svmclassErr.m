function [trainErrRate, testErrRate] = svmclassErr(X,y,testX,testy,KK,w)
    
    C = 1000;
    % Get b_0
    J = 0;
    b0 = 0 ;
    n = size(y,1);
    
    for j = 1 : n 
        if 0 < w(j) && w(j) < C
            J = J + 1;
            b0 = b0 + (-y(j) + KK(:,j)'*(w.*y));
        end
    end
    b0 = b0 / J;
    
    trainErrRate = 0;
    for j = 1 : n
        yhat = sign(KK(j,:)*(w.*y)+ b0);
        if yhat ~= y(j)
            trainErrRate = trainErrRate + 1;
        end
    end
    trainErrRate = trainErrRate / n;
    
    m = size(testX,1);
    testErrRate = 0;
    for j = 1 : m
        s = 0;
        for i = 1 :n 
            s = s + w(i)*y(i)* exp(- norm(testX(j,:)-X(i,:)) );
        end
        yhat = sign(s + b0);
        if yhat ~= testy(j)
            testErrRate = testErrRate + 1;
        end
    end
    testErrRate = testErrRate / m;
    
end

    
            
    
    
    
    
    
            
  
    