function distance(v,dv)
  h5disp('toy.hdf5') ;
  X = h5read('toy.hdf5','/X');
  y = h5read('toy.hdf5','/y');
  n = size(y,1);
  for i = 1 : n 
      d(i) = y(i)*(v(1)+v(2)*X(i,1)+v(3)*X(i,2));
  end
  figure
  scatter(d,dv,5,'filled','b');
end
