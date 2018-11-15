function [error,b1] = pgdGroupLasso(X,y,p,group,lambda)
T = 1000;
w0=[0,sqrt(3),sqrt(3),sqrt(2),1,sqrt(2),1,1,sqrt(3)].';
w1 = ones(17,1).';
ind0 = [0,1,4,7,9,10,12,13,14,17].';
ind1 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17].';
G0 = size(w0);
G1 = size(w1);

t = 0.002;
op = 84.6952;
inb = zeros(17,1);


if  group == 1
    w = w0;
    G = G0;
    ind = ind0;
else 
    w = w1;
    G = G1;
    ind = ind1;
end


for k = 1 : 1 :T
    if k == 1
        b0 = inb;
        b1 = inb;
    end
    
   regular = 0;
   v= b1 + p*(k-2)/(k+1)* ( b1-b0);
   gradient = 2 * X.'*(X*v-y);
   
   for i = 1 :1 :G
         V = v(ind(i)+1:ind(i+1));   % SO SMART
        c = V -t* gradient(ind(i)+1:ind(i+1)); 
        if norm(c) >t *lambda*w(i)
            V = (1-t*lambda*w(i) / norm(c) )*c;
        else 
            V = 0*V;
        end
         b0(ind(i)+1:ind(i+1)) =b1(ind(i)+1:ind(i+1));
         b1(ind(i)+1:ind(i+1)) = V;
         regular = regular + w(i)*norm(V);
     end
    

    error(k) = norm(y-X*b1)^2 + lambda*regular - op ;
end


end


    
    
    