function [] = plotadc2d(X,C)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      31/10/2017

% X é um vetor 2,m e C é 1,m
simbolos = ['o' '+' '*' '.' 'x' '#' '=' '-' '@' '$'];

for i=1:length(X(1, :))
    plot(X(1, i), X(2, i), simbolos(C(i)+1))
end

xlabel('x1');
ylabel('x2');
title(legend('y = 1','y = 0'),'Legenda')
end