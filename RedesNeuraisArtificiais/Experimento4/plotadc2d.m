function [] = plotadc2d(X,C)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      31/10/2017
%Modificado 09/11/2017

% X é um vetor 2,m e C é 1,m
simbolos = ['o' '+' '*' '.' 'x' 's' 'd' '^' 'v' '>'];
cores = hsv(10);
cores = cores(randperm(length(cores)), :); %randomiza cores

for i=1:length(X(1, :))
    plot(X(1, i), X(2, i), simbolos(C(i)+1), 'color', cores(C(i)+1, :))
end

xlabel('x1');
ylabel('x2');

switch max(C)+1
    case 1
        title(legend('y = 0'),'Legenda')
    case 2
        title(legend('y = 0','y = 1'),'Legenda')
    case 3
        title(legend('y = 0','y = 1','y = 2'),'Legenda')
    case 4
        title(legend('y = 0','y = 1','y = 2','y = 3'),'Legenda')
    case 5
        title(legend('y = 0','y = 1','y = 2','y = 3','y = 4'),'Legenda')
    case 6
        title(legend('y = 0','y = 1','y = 2','y = 3','y = 4','y = 5'),'Legenda')
    case 7
        title(legend('y = 0','y = 1','y = 2','y = 3','y = 4','y = 5','y = 6'),'Legenda')
    case 8
        title(legend('y = 0','y = 1','y = 2','y = 3','y = 4','y = 5','y = 6','y = 7'),'Legenda')
    case 9
        title(legend('y = 0','y = 1','y = 2','y = 3','y = 4','y = 5','y = 6','y = 7','y = 8'),'Legenda')
    case 10
        title(legend('y = 0','y = 1','y = 2','y = 3','y = 4','y = 5','y = 6','y = 7','y = 8','y = 9'),'Legenda')
    otherwise
        disp('erro')
end

end

