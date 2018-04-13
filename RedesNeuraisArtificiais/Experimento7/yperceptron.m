function [y] = yperceptron(X,W,b)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b
u = W * X + b;

[ln,cl] = size(u);

for i=1:ln
    for j=1:cl
        if u(i,j) >= 0
            y(i,j) = 1;
        else
            y(i,j) = 0;
        end
    end
end

end