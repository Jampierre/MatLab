function [xp,cp] = mistura(x,c)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      09/11/2017

iteracoes = size(x, 2);    
for i=1:iteracoes
    valor1 = round(rand() * iteracoes);
    valor2 = round(rand() * iteracoes);
    if (valor1 == 0)
        valor1=1;
    end
    if (valor2 == 0)
        valor2=1;
    end

    x1 = x(:, valor1);
    x2 = x(:, valor2);
    aux = x(:, valor1);

    c1 = c(:, valor1);
    c2 = c(:, valor2);
    caux = c(:, valor1);

    xp(:, valor1) = x(:, valor2);
    xp(:, valor2) = aux;

    cp(:, valor1) = c(:, valor2);
    cp(:, valor2) = caux;
end
end