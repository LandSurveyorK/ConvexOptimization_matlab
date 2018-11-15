function [v,fval] = svm(C1,C2) 
  h5disp('toy.hdf5') ;
  X0 = h5read('toy.hdf5','/X');
  y = h5read('toy.hdf5','/y');
  n = size(y,1);
  X = [ones(n,1),X0];
  H= zeros(n+3);
  H(2,2) = 1;  H(3,3) = 1;
  Y = zeros(n,n);
  f = zeros(n+3,1);
  for i = 4:n+3
      Y(i-3,i-3) = y(i-3);
      if y(i-3) == 1 
          f(i) = C1;
      else 
          f(i) = C2;
      end
  end
  P = [eye(3) zeros(3,n)];
  Q = [zeros(n,3) eye(n)];
  A = -[Y*X*P+Q; Q];
  b = -[ones(n,1);zeros(n,1)];
  [v,fval] = quadprog(H,f,A,b);

figure;
for i = 1 : n 
      hold on;
      if y(i) == 1
          scatter(X(i,2),X(i,3),10,'g','filled'); 
          if v(i+3) > 10^(-10)
              text(X(i,2)+0.01,X(i,3)+0.01,'e');
          end
          
      else 
          scatter(X(i,2),X(i,3),10,'b','filled'); 
          if v(i+3) > 10^(-10)
              text(X(i,2)+0.01,X(i,3)+0.01,'e');
          end
          
      end
end
  
u = -4:0.01:10;
w1 = -1.0*v(1)/v(3)-1.0*v(2)/v(3)*u;
plot(u,w1,'r');
w2 = -(v(1)+1) / v(3)-1.0*v(2)/v(3)*u;
w3 =  -(v(1)-1) / v(3)-1.0*v(2)/v(3)*u;
plot(u,w2,'y');
plot(u,w3,'y');

end

  
  