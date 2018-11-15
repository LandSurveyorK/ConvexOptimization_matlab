function [fw,w]= svmBarrier(K,y,T,w)
    alpha = 0.01; beta = 0.5;
    decrement = 1;
    
    [f, Gradient,Hessian, v] = svmLoss(K,y,T,w);
   
     while (decrement> 1e-6)
         
     t = svmstepInt(w,v);  % initial step for backtracking t
                            % to allow the upcoming update to be feasible
     update = 1;
     while (update == 1 )
         w = w + t* v;
         [f_new, Gradient_new, Hessian_new,v_new] = svmLoss(K,y,T,w);  % since the loss function doesn't contain u, 
         if f_new > f + alpha * t * Gradient' * v
             t = beta * t;
             update = 1 ;
         else 
             update = 0;
             Gradient = Gradient_new;
             Hessian = Hessian_new;
             v = v_new;
         end
     end
     
     decrement = sqrt(Gradient'*Hessian*Gradient);  % solve constraint barrier 
     end
     
     fw = 0.5 * w'*K*w - norm(w);  % the optima; value at the optimal training weights.
end

         
             
         
    