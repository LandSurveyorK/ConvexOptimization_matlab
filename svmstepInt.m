function t = svmstepInt(w,v)
    C = 1000;
    t = 1 ;
    m = size(w,1);
    i = 1;
     while(i < m+1)      
        new_wi = w(i) + t * v(i); 
        if new_wi > 0 && new_wi < C
            i = i +1;
        else 
            t = 0.99 * t;
        end
    
     end
end

    
            
        
        