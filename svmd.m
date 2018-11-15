function [v,dfval] = svmd(C1,C2) 
  h5disp('toy.hdf5') ;
  X = h5read('toy.hdf5','/X');
  y = h5read('toy.hdf5','/y');
  n = size(y,1);
  Y = zeros(n,n);
  for i = 1:n
      Y(i,i) = y(i);
  end
  H = (Y*X)*(Y*X)';
  f = -ones(n,1);
  Aeq = y';
  beq = 0;
  lb = zeros(n,1);
  ub = zeros(n,1);
  for i = 1 : n
      if y(i) == 1
          ub(i) = C1;
      else 
          ub(i) = C2;
      end
  end
  
  [v,fval] = quadprog(H,f,[],[],Aeq,beq,lb,ub);
  dfval = -fval;