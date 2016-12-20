function [ X ] = deslocamento(K,b,toll,kmax )
%UNTITLED2 Summary of this function goes here
%   Metodo de Jacobi 
% 

%1)Vetor aproxima??o inicial    
    n = length(K);
    D = length(b);
    for i = 1:n
        D(i) = b(i)/K(i,i);
%         x(i) = 0;
    end

     for k = 1:kmax
    
    %2)Sistema equivalente
        X = length(b);
        for i = 1:n
            B = 0;
            for j = 1:n
                B = B + K(i,j) * D(j);
            end
            X(i) = (b(i) + B); %Vetor aproxima??o
        end

    %3)C?lculo erro
         if max(abs(X - D))/max(abs(X)) < toll
             fprintf('O vetor x(k+1) = (x1, x2,...,xn)^t ? solu??o aproximada com toler?ncia menor do que TOLL = %f\n',toll);
             fprintf('Ultimo Erro calculado = %f\n',max(abs(X - D))/max(abs(X)));
             fprintf('K = %i \n',k);
             return
         end
           D = X;
     end
%      O numero de itera??es n?o foi o suficiente 
    fprintf('com (Kmax = %i) intera??es n?o ? poss?vel obter a solu??o aproximada com toler?ncia(TOLL = %f ).  \n',k, toll);
     
end

