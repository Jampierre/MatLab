% Função que implementa neurônio artificial
% data: 01/06/2016
% autor: Cristiano Garcia
% interpretador: Matlab 2016

function [y,u] = yperceptron(W, b, X)
    u=W*X+b;
    for i=1:length(u)
        if u(i)<0
            y(i)=0;
        else
            y(i)=1;
        end
    end
end