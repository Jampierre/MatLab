% Algoritmo de plotagem de dados de 2 dimensões
% Autor: Cristiano Garcia
% Data: 17/06/2016
% Parâmetros:
%   X = dados de entrada (k x m)
%   C = classificacao (1 x m)

function [] = plotadc2d( X, C )
    simbolos = ['o' '+' '*' '.' 'x' 's' 'd' '^' 'v' '>' '<' 'p' 'h'];
    cores = hsv(10);
    cores = cores(randperm(length(cores)), :); %randomiza cores
    
    for i=1:length(X(1, :))
       plot(X(1, i), X(2, i), simbolos(C(i)+1), 'color', cores(C(i)+1, :))
    end
end
