function [ A,b ] = pivotamentoParcial( A,b )
%Elimina??o de Gauss com Pivoteamento Parcial
%   Entrada: Matriz n?o-singular A ? Rn?n e vetor coluna b ? Rn.
%   Sa?da: Matriz triangular superior A e b.
    n = length(A);
    for j = 1:n-1 
        %A(abs(A(k,j))) = max(abs(A(j:end,j)));
        %[b,a] = max(abs(A(j:end,j))); %indice do pivo
        %b = A(r+j-1,:);
        %A(r+j-1,:) = A(j,:);    %Permuta as linhas j e k
        %A(j,:) = b;
        
        %k([b,a],:) = max(abs(A(j:end,j)));
        
        temp1 = a(j);
        temp2 = b(j);
        a(j) = a(k)
        b(j) = b(k);
        a(k) = temp1;
        b(k) = temp2;
        
        for i = j + 1
            M = A(i,j)/A(j,j);
            a(i) = a(i) - M*a(j);
            b(i) = b(i) - M*b(j);
        end
    end
end

