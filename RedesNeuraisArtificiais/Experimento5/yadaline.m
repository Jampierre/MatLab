function [y] = yadaline(X,W,b)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b
%16/11/2017

%X = matriz (m x t) de dados com t amostras de m características (m entradas);
%W = vetor linha (1 x m) de pesos das entradas;
%b = polarização do neurônio;
%y = vetor linha (1 x t) com os valores da saída no neurônio para cada amostra.

y = W * X + b;
end

