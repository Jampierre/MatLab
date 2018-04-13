clear;
clc;

a = -1;
b = 1;

W = [((b-a).*rand() + a) ((b-a).*rand() + a)];
b = (b-a).*rand() + a;
Xin = [0 1 0 1; 0 0 1 1];
%AND
%Yin = [0 0 0 1];
%ORD
Yin = [0 1 1 1];
alfa = 1.2;
maxepocas = 10;
tol = 0.001;

[W,b,Erroepocas] = treina_perceptron(W,b,Xin,Yin,alfa,maxepocas,tol);

figure(1);
plot(Erroepocas);
title('GRAFICO');
xlabel('Epocas');
ylabel('SEG');