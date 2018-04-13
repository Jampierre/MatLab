% Script para aprendizado e plotagem dos pontos e reta de separação dos % conjuntos linearmente separáveis
% Autor: Cristiano Garcia
% Data: 17/06/2016

W = rand(1, 2) * 2 - 1;
b = rand();

X =  [0 1 0 1; 0 0 1 1];
Yd = [0 1 1 1];

alfa = 1.2;
maxepocas = 10;
tol = 0.1;

[W, b, erroEpoca] = treina_perceptron(W,b,X,Yd,alfa,maxepocas,tol);

%plot(erroEpoca);
%ylabel('SEQ');
%xlabel('Épocas');
%title('SEQ/Épocas - OR');

[y, u] = yperceptron(W, b, X);

hold on
plotadc2d(X, y);
plotareta(W, b, [-0.5 1.5]);
xlabel('x1');
ylabel('x2');
title('Reta de Separação OR');
hold off
