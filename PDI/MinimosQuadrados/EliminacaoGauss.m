function [ x ] = EliminacaoGauss( A,b )

    n = length(A);
    
    for i=1:n-1
       for j=i+1:n
           multiplicador = A(j,i) / A(i,i);
           for k=1:n
               A(j,k) = A(j,k) - multiplicador*A(i,k);
           end
           b(j,1) = b(j,1) - multiplicador*b(i,1);
       end
    end
    
    x = TriSup(A,b);
    
end