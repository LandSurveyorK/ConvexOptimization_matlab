function w0 = initialBarrier(m)
       f = [zeros(m,1);ones(m-1,1)];
       R = eye(m-1);
       A1 = [zeros(m-1,1),R,R];
       A2 = [zeros(m-1,1),-R,R];
       A = - [A1;A2];
      w0 = linprog(f,A,-0.1*ones(2*m-2,1));
end
