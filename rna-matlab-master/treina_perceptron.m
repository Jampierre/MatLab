% Algoritmo de treinamento de perceptron
% Autor: Cristiano Garcia
% Data: 12/06/2016
% Parâmetros:
%   W = pesos (1 x k)
%   b = bias (1x1)
%   X = dados de entrada (k x m)
%   Yd = saída desejada (1 x m)
%   alfa = taxa de aprendizado
%   maxepocas = maximo de epocas para treinamento
%   tol = tolerancia

function [ w, b, erroEpoca] = treina_perceptron(W,b,X,Yd,alfa,maxepocas,tol)
    t = 1; % epoca
    erro = 1; %apenas para entrar no while
    w = W;
    erroEpoca = [];
    
    while (t < maxepocas) && (erro > tol)
        erro = 0;    
        for i = 1:length(X(1, :))
            y = yperceptron(w, b, X(:, i));
            e = Yd(i) - y;
            w = w + alfa * e * X(:, i)';
            b = b + alfa * e;
            erro = erro + e^2;
        end
        erroEpoca(t) = erro;
        t = t+1;
    end
end

