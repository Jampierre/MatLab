function [ C ] = converte_bin_dec( Yd )
    C = zeros(1, size(Yd, 2));
    
    for x=1:size(Yd, 1)
       for y=1:size(Yd, 2)
           if (Yd(x, y) == 1)
               C(y) = x-1;
           end
       end
    end

end

