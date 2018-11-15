function [error,b1] = pgd2(groupTitles, groupLabelsPerRating, trainRatings, trainLabels,p,lambda,T)
X = [ones(size(trainRatings,1),1),trainRatings];
y = trainLabels;
[n,m] = size(X);
G = size(groupTitles,1);
a = [];
for i = 1:1:G
    a(i) = max(find(groupLabelsPerRating==i) );
end
d = [0,a];
c =[0, a - d(1:G)];
for i = 1: 1: G+1
    w(i)= sqrt(c(i));
end
ind =[0,1,a + ones(1,G)];

t = 0.0001;
op = 336.207;

inb = zeros(m,1);


for k = 1 : 1 :T
    if k == 1
        b0 = inb;
        b1 = inb;
    end
    
   regular = 0;
   v= b1 + p*(k-2)/(k+1)* ( b1-b0);
   gradient = grad(X,y,v);
   
   for i = 1 :1 :G+1
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
    error(k) =  g(X,y,b1)+ lambda*regular - op ;
end


end

