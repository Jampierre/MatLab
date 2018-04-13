% Exemplo 1: funcao XOR
% Data: 21/07/2016

clear all;
close all;
clc;
disp('Programa MLP XOR');

% Cria dados

X = [
    0 0 1 1 
    0 1 0 1
];
Yd = [0 1 1 0];

disp(' - Criando MLP');
net = feedforwardnet(2, 'trainrp'); % Cria a rede com 2 neurons escondidos
                                    % Para MLP, [ 2 3 ] 2 na primeira
                                    % camada e 3 na segunda camada
                                    
disp(' - Configurando a MLP');
net.divideMode  = 'none';           %
net.divideFcn   = 'dividetrain';    % 
net.divideParam = 'none';           %
%net.trainFcn    = 'trainrp';        %
net.performFcn  = 'mse';            % define função a ser minimizada para ajuste
net.trainParam.epochs = 30;         %
net.trainParam.goal = 0;

disp(' - Treinando a MLP');
net = train(net, X, Yd);

disp(' - Simulando ');
Ys = sim(net, X);

disp(' - Resultado');
disp(Ys);

% Calcula desempenho
perf = perform(net, Yd, Ys);
disp(' - Desempenho: ');
disp(perf);

disp(' *** FIM *** ');