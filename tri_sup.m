function [ A,b ] = tri_sup( A,b )
%ALGORITMO 2 Resolu??o Ax = b atrav?s da Elimina??o de Gauss.
%   Seja o sistema linear Ax = b, A:n*n, x:n*1, b;n*1.  
%   Supor que o elemento que est? na posi??o A(k,k) ? diferente de zero no
%   in?cio da etapa k.

%triangular superior

%ELIMINA??O
    n = length(A);
    for k = 1:n-1
        for i = k+1:n
            M = A(i,k)/A(k,k);
            A(i,k) = 0;
            for j = k+1:n
                A(i,j) = A(i,j) - M*A(k,j);
                b(i) = b(i) - M*b(k);
            end
        end
    end
    
    x(n) = b(n)/A(n,n);
    for k = (n - 1): 1
        s = 0;
        for j = (k + 1):n
            s = s + A(k,j)*x(j);
            x(k) = (b(k) - s)/a(k,k);
        end
    end
    
end

