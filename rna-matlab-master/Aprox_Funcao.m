% Programa exemplo para aproximação

clear all;
close all;
clc;

[X, Yd] = simplefit_create; % gera cjt de dados de funcao pre definida

figure(1);
plot(X, Yd);
title('Dados de treinamento');

% Cria rede neural
net = feedforwardnet(10);
net = train(net, X, Yd);
Ys = sim (net, X);

hold on
plot(X, Ys);
title('Resultado');