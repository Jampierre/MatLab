%
%
%
%
function [ X, C ] = mistura( X, C )
    iteracoes = size(X, 2);
    
    for i=1:iteracoes
        valor1 = round(rand() * iteracoes);
        valor2 = round(rand() * iteracoes);
        if (valor1 == 0)
            valor1=1;
        end
        if (valor2 == 0)
            valor2=1;
        end
        
        x1 = X(:, valor1);
        x2 = X(:, valor2);
        aux = X(:, valor1);
        
        c1 = C(:, valor1);
        c2 = C(:, valor2);
        caux = C(:, valor1);
        
        X(:, valor1) = X(:, valor2);
        X(:, valor2) = aux;
        
        C(:, valor1) = C(:, valor2);
        C(:, valor2) = caux;
    end
end

