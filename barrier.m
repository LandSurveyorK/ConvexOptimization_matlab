function [fw,w] = barrier(X,y,w,T,alpha,beta)   % w initial, T 

   err = 1;
   m = size(X,2);
   [f,Gradient,v] = regularNLL(X,y,w,T); % regularNLL can be any function 
    while (abs(err) > 1e-2)  
       t = 1;
     % find an intial step size prior backtraking 
       i = 1;
       while(i < m)      
           d = abs( w(i+1) + t*v(i+1) ) - (w(m+i) + t*v(m+i));
           if d < 0 
               i = i + 1;
           else 
               t = 0.9 * t;
           end
       end
      % ///////////// backtraking ///////////////////
       update = 1;
       while (update == 1) 
           [f_new,Gradient_new,v_new] = regularNLL(X,y,w + t*v,T); 
           if f_new > f + alpha * t * Gradient' * v
               update = 1 ;
               t = beta * t;
           else 
               update = 0;
           end
        end
        w = w + t * v;
        Gradient = Gradient_new ;
        v = v_new;
        err =  f - f_new;
        f = f_new;
     
     end
     fw = fPlugin(X,y,w);   % f(x*(t)) plug in the solution of barrier problem    
end


