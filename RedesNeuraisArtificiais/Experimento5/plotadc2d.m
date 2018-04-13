function [] = plotadc2d(X,C,c)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      31/10/2017
%Modificado 16/11/2017
simbolos = ['o' '+' '*' '.' 'x' 's' 'd' '^' 'v' '>'];
cores = hsv(10);
cores = cores(randperm(length(cores)), :); %randomiza cores

for i=1:length(X(1, :))
    plot(X(1, i), C(1, i), simbolos(c), 'color', cores(c, :))
end
xlabel('x');
ylabel('y');
end