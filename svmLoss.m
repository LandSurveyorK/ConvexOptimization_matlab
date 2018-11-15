function [f,Gradient,Hessian, v] = svmLoss(K,y,T,w)
    C = 1000 ;
    n = size(w,1);
    logbarrier = 0;
    for i = 1 : n 
        logbarrier = logbarrier + log(C*w(i)-w(i)*w(i));
    end
    f = T*(ones(n,1)'*w - 1.0/2 * w'*K*w) - logbarrier;
    Gradient = T * (ones(n,1) - K*w);
    Hessian = T * (-K);
    for i = 1 : n
        Gradient(i) = Gradient(i) - (C-2*w(i)) / (C*w(i)-w(i)*w(i));
        Hessian(i,i)  = Hessian(i,i) + (C*C + 2*w(i)*w(i) - 2*C*w(i)) / ( (C*w(i)-w(i)*w(i))^2 );
    end
    NewtonHess = [[Hessian,y];[y',0]];
    NewtonGrad = [Gradient;0];
    NewtonV = - inv(NewtonHess)* NewtonGrad; % (w,u)
    v = NewtonV(1: n);  % step of w 
end

    