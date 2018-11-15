function r = error(v,C1,C2)
  h5disp('toy.hdf5') ;
  X = h5read('toy.hdf5','/X');
  y = h5read('toy.hdf5','/y');
  n = size(y,1);
  r = 0;
  for i = 1 : n
      if v(i+3) > 1
          if y(i) == 1
              r = r-C1;
          else 
              r = r -C2;
          end
      end
  end
  
              
          