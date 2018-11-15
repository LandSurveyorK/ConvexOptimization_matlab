function w = svmInitial(trainLabels)
     C = 1000;
     n = size(trainLabels,1);
     y = 2* trainLabels-ones(n,1);
     %  linprog(f,A,b,Aeq,beq,lb,ub
     
     f = ones(n,1);
     w = linprog(f,zeros(1,n),1,y',0,ones(n,1),C*ones(n,1));  % 1 < w < C, wTy = 0
end