function [ b ] = dia_est_dom( A )
%Verifica se a Matriz ? diagonal estritamente dominante
%   Fazer uma fun??o para avaliar a converg?ncia dos m?todos 
%iterativos usando a condi??o suficiente: Se a matriz dos 
%coeficientes do sistema linear for diagonal estritamente 
%dominante, ent?o o sistema linear converge para a solu??o 
%independente do vetor inicial fornecido.

%
    %b = 1;
    %n = length(A);
    %for i = 1:n
        %for j = 1:n
            %if j ~= i
                %if abs(A(i,i)) <= abs(A(i,j))
                    %b = 0;
                    %return;
                %end
            %end    
        %end
    %end
    
    n = length(A);
    b = 1;
    for i = 1:n
        %A = abs(A(i,i));
        B = 0;
        for j = 1:n
            if j ~= i
                B = B + abs(A(i,j));
            end
        end
        if abs(A(i,i)) <= B
            b = 0;
            return;
        end
    end
end

