% Programa exemplo do MATLAB para treinar uma MLP na aproximacao de funcao
%
% Data: julho/2016
% versao: MATLAB 2016

clear all;
close all;
clc;

% Cria os dados de entrada e saida
[X,Yd] = simplefit_create;
Yd = [Yd Yd];
figure(1);
%plot (X,Yd);
title('Dados de treinamento');

% Cria a rede neural
net = feedforwardnet(10);

% Treina a rede neural
net = train(net,X,Yd);

% Simula a rede neural
Ys = sim(net,X);

% Plota resultado da aproximacao
figure(2);
plot (X,Ys);
title('Resultado');

