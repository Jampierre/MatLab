% Programa exemplo do MATLAB para treinar uma MLP na solucao do XOR de 
% 2 entradas binarias e uma saida binaria
%
% Data: julho/2017
% versao: MATLAB 2017

clear all;
close all;
clc;

disp('Programa para treinar MLP na solucao do XOR');
disp('-------------------------------------------');

% Entradas
%X = [ 0 , 1 , 0 , 1 ; 0 , 0 , 1 , 1];
X = [ -1 , 1 , -1 , 1 ; -1 , -1 , 1 , 1];
disp('Dados de entrada: ');
disp(X);

% Saida desejada: funcao logica XOR
%Yd = [ 0 , 1 , 1 , 0 ];
Yd = [ -1 , 1 , 1 , -1 ];
disp('Saida desejada: ');
disp(Yd);

disp('Quantidade de entradas = ');
disp(size(X,1));
disp('Quantidade de neuronios na camada escondida =');
neuronios_camada_escondida = 2;
%neuronios_camada_escondida = [4 2] ;
disp(neuronios_camada_escondida);
disp('Quantidade de saidas = ');
disp(size(Yd,1));

disp('Criando a rede MLP...');
net = feedforwardnet(neuronios_camada_escondida, 'trainlm' );
% Tipos de funcao de treinamento:
% 'trainrp'    --  metodo de treinamento RPROP
% 'trainlm'    --  metodo de treinamento Levenberg-Marquardt backpropagation
% 'trainscg'   --  Backpropagation training functions that use Jacobian derivatives
% 'traingd'    --  Gradient descent backpropagation.
% 'traingdm'   --  Gradient descent with momentum.

disp('Configurando a rede...');
net = configure(net,X,Yd);

% divisao dos dados entre treinamento, teste, validacao
net.divideParam.trainRatio = 1; % training set [%]
net.divideParam.valRatio = 0;   % validation set [%]
net.divideParam.testRatio = 0;  % test set [%]

% Ajusta parametros para treinamento
%net.trainFcn = 'trainrp';         % metodo de treinamento RPROP
%net.trainFcn = 'trainlm';         % metodo de treinamento Levenberg-Marquardt
%net.trainFcn = 'trainscg';        % Backpropagation that use Jacobian derivatives
%net.trainFcn = 'traingd';         % Gradient descent backpropagation.
%net.trainFcn = 'traingdm';        % Gradient descent with momentum.
net.performFcn = 'mse';            % funcao a ser minimizada (erro medio quadratico)
net.trainParam.epochs = 1000;      % numero maximo de epocas para treinamento
net.trainParam.lr = 0.00001;       % taxa de treinamento
net.trainParam.goal = 0.0001;      % erro maximo permitido
%net.trainParam.show = NaN;        % epocas entre mostrar na tela ou NaN
%net.trainParam.min_grad = 1e-6;   % gradiente minimo
%net.trainParam.max_fail = 0.001;  % erro maximo de validacao
%net.trainParam.delt_inc = 1.2;    % incremento no peso
%net.trainParam.delt_dec = 0.5;    % decremento no peso
%net.trainParam.delta0 = 0.01;     % variacao inicial do peso
%net.trainParam.deltamax = 50.0;   % variacao maxima do peso
% net.trainParam.show	 = 25	   % Epochs between displays (NaN for no displays)
% net.trainParam.time	= inf	   % Maximum time to train in seconds

% Ajusta funcao de ativacao de cada camada da rede
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
%net.layers{1}.transferFcn = 'logsig';
%net.layers{2}.transferFcn = 'logsig';

% Inicializa a rede neural com novos valores de pesos e bias
disp('Inicializando a rede neural....');
net = init(net);

% Treina a rede neural 
disp('Treinando a rede neural...');
net = train(net,X,Yd);

% Simula a rede neural
disp('Simulando a rede neural treinada...');
Ysaida = sim(net,X);
disp('Resultado: ');
disp(Ysaida);

% Calcula o desempenho obtido
disp('Calculando o erro da rede neural...');
perf = perform(net,Yd,Ysaida);
disp('Desempenho: ');
disp(perf);

