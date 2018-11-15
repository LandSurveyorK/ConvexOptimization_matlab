function [error,b,count] = backtracking(groupTitles, groupLabelsPerRating, trainRatings, trainLabels,lambda,T)
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

op = 336.207;
beta = 0.1;
inb = zeros(m,1);
count = 0;


for k = 1 : 1 :T
    if k ==1
        b = inb;
    end
   t = 1;
   ob = b;
   gradient = grad(X,y,ob);
   update = 1;
   while(update==1)
       regular = 0;
       count = count +1;
     for i = 1 :1 :G+1
         V = ob(ind(i)+1:ind(i+1));   % SO SMART
        c = V -t* gradient(ind(i)+1:ind(i+1)); 
        if norm(c) >t *lambda*w(i)
            V = (1-t*lambda*w(i) / norm(c) )*c;
        else 
            V = 0*V;
        end
         b(ind(i)+1:ind(i+1)) = V;      
     end
     
      for i = 1 : 1: G+1
        regular = regular + w(i)*norm( b(ind(i)+1:ind(i+1)) );
     end
     error(count) =  g(X,y,b)+ lambda*regular - op ;
     
     if g(X,y,b) > g(X,y,ob)+gradient.'*(b-ob)+ 1/(2*t)*norm(b-ob)^2
       t = beta*t;
      update =1;
     else 
      update = 0;
     end
   end
   
    
  end

end
