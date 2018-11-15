function [error,b] = pdgBacktrakingVSbarrier(trainRatings, trainLabels,lambda,T)
    X = [ones(size(trainRatings,1),1),trainRatings];
    y = trainLabels;
    [n,m] = size(X);
    op = 306.476;
    beta = 0.5;
    inb = zeros(m,1);

    for k = 1 : 1 :T
        if k ==1
            b = inb;
        end
        ob = b;
        gradient = grad(X,y,ob);
        regular = 0;
        t = 1;
        update = 1;
        while(update == 1)
             b(1) = ob(1) - t * gradient(1); 
             for i = 2 : 1 :m
                 V = ob(i);   
                 c = V -t* gradient(i); 
                 if norm(c) > t * lambda
                     V = (1-t* lambda / norm(c) )*c;
                 else 
                     V = 0*V;
                 end
                 b(i) = V;      
              end
     
              if g(X,y,b) > g(X,y,ob)+gradient.'*(b-ob)+ 1/(2*t)*norm(b-ob)^2
                  t = beta * t;
                  update = 1;
              else 
                  update = 0;
              end
     
        end
        for i = 2 : 1: m
             regular = regular +norm( b(i));
        end
        error(k) =  g(X,y,b) + lambda*regular - op ;  
    end
end
