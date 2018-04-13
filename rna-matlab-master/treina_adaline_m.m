% Algoritmo de treinamento de perceptron Adaline com momentum
% Autor: Cristiano Garcia
% Data: 23/06/2016
% Parâmetros:
%   W = pesos (1 x k)
%   b = bias (1x1)
%   X = dados de entrada (k x m)
%   Yd = saída desejada (1 x m)
%   alfa = taxa de aprendizado
%   maxepocas = maximo de epocas para treinamento
%   tol = tolerancia
%   beta = taxa de momentum

function [ w_atual, b_atual, erroEpoca] = treina_adaline_m(W, b, X, Yd, alfa, maxepocas, tol, beta)
    t = 1; % epoca
    erro = 1; %apenas para entrar no while
    
    w_atual = W;
    w_antigo = W;
    
    b_atual = b;
    b_antigo = b;
    
    erroEpoca = [];
    
    while (t < maxepocas) && (erro > tol)
        erro = 0;    
        for i = 1:length(X(1, :))
            y = yadaline(w_atual, b, X(:, i));
            e = Yd(i) - y;
            
            w_futuro = w_atual + alfa * e * X(:, i)' + beta * (w_atual - w_antigo);
            w_antigo = w_atual;
            w_atual = w_futuro;
            
            b_futuro = b_atual + alfa * e + beta * (b_atual - b_antigo);
            b_antigo = b_atual;
            b_atual = b_futuro;
            
            erro = erro + e^2;
        end
        erroEpoca(t) = erro;
        t = t+1;
    end
end

