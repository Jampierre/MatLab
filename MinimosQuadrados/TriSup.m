function [ x ] = TriSup( A,b )

    n = length(A);
    x = zeros(n,1);
    
    for i=n:-1:1
        soma = 0;
       for j=i+1:n
          soma = soma + A(i,j)*x(j,1);
       end
       x(i,1) = (b(i,1)-soma)/A(i,i);
    end

end

