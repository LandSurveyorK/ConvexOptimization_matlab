function [K,KK] = svmKernal(X,y)
    n = size(X,1);
    K = zeros(n,n);
    KK = zeros(n,n);
    sigma2 = 10^6;
    for i = 1 : n 
        for j = 1 : n 
            KK(i,j) = exp( - norm(X(i,:)-X(j,:))^2 / (2*sigma2));
            K(i,j) = y(i)*y(j)*KK(i,j);  
        end
    end
end

     