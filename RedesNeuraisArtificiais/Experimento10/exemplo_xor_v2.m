% Programa exemplo do MATLAB para treinar uma MLP na solucao do XOR de 
% 2 entradas binarias e uma saida binaria
%
% Data: julho/2017
% versao: MATLAB 2017

clear all;
close all;
clc;

disp('Programa para treinar MLP na solucao do XOR');

% Entradas
X = [ 0 , 1 , 0 , 1 ; 0 , 0 , 1 , 1];
%X = [ -1 , 1 , -1 , 1 ; -1 , -1 , 1 , 1];
disp('Dados de entrada: ');
disp(X);

% Saida desejada: funcao logica XOR
Yd = [ 0 , 1 , 1 , 0 ];
%Yd = [ -1 , 1 , 1 , -1 ];
disp('Saida desejada: ');
disp(Yd);

% Normalizacao dos dados de entrada e saida
[Xn,settings_X] = mapminmax(X);
[Ydn,settings_Y] = mapminmax(Yd);

disp('Dados de entrada normalizados: ');
disp(Xn);

disp('Dados de saida normalizados: ');
disp(Ydn);

disp('Criando a rede MLP...');
disp('Quantidade de entradas = ');
disp(size(X,1));
disp('Quantidade de neuronios na camada escondida =');
neuronios_camada_escondida = 2;
disp(neuronios_camada_escondida);
disp('Quantidade de saidas = ');
disp(size(Yd,1));
net = feedforwardnet(neuronios_camada_escondida);
%disp('Resultado da criação:');
%view(net)
%pause(5);

disp('Configurando a rede...');
net = configure(net,Xn,Ydn);
%disp('Resultado da configuração:');
%view(net)
%pause(5);

% divisao dos dados entre treinamento, teste, validacao
net.divideFcn = 'dividetrain';
net.divideParam = 'none';
net.divideMode = 'none';   

% Ajusta parametros para treinamento
net.trainFcn = 'trainrp';          % metodo de treinamento RPROP
%net.trainFcn = 'trainlm';          % metodo de treinamento Levenberg-Marquardt backpropagation
%net.trainFcn = 'trainscg';          % Backpropagation training functions that use Jacobian derivatives
%net.trainFcn = 'traingd';           % Gradient descent backpropagation.
%net.trainFcn = 'traingdm';          % Gradient descent with momentum.
 
net.performFcn = 'mse';            % funcao a ser minimizada (erro medio quadratico)

net.trainParam.epochs = 100;        % numero maximo de epocas para treinamento
net.trainParam.lr = 0.0001;          % taxa de treinamento
net.trainParam.goal = 0.001;        % erro maximo permitido
%net.trainParam.show = NaN;        % epocas entre mostrar na tela ou NaN
%net.trainParam.min_grad = 1e-6;   % gradiente minimo
%net.trainParam.max_fail = 5;      % erro maximo de validacao
%net.trainParam.delt_inc = 1.2;    % incremento no peso
%net.trainParam.delt_dec = 0.5;    % decremento no peso
%net.trainParam.delta0 = 0.01;     % variacao inicial do peso
%net.trainParam.deltamax = 50.0;   % variacao maxima do peso
% net.trainParam.show	 = 25	   % Epochs between displays (NaN for no displays)
% net.trainParam.time	= inf	   % Maximum time to train in seconds

net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
%net.layers{1}.transferFcn = 'logsig';
%net.layers{2}.transferFcn = 'logsig';

% Inicializa a rede neural com novos valores de pesos e bias
disp('Inicializando a rede neural....');
net = init(net);
%disp('Resultado da inicialização:');
%view(net)
%pause(5);

% Treina a rede neural 
disp('Treinando a rede neural...');
net = train(net,Xn,Ydn);
%disp('Resultado do treinamento');
%view(net)
%pause(5);

% Simula a rede neural
disp('Simulando a rede neural treinada...');
%Ysaida = round(sim(net,Xn));
Ysaida = sim(net,Xn);
disp('Resultado normalizado: ');
disp(Ysaida);

% Desnormaliza a saida
disp('Desnormalizando os dados de saida...');
Ysaida_des = mapminmax.reverse(Ysaida,settings_Y);
disp('Resultado desnormalizado: ');
disp(Ysaida_des);

% Calcula o desempenho obtido
disp('Calculando o erro da rede neural...');
perf = perform(net,Yd,Ysaida_des);
disp('Desempenho: ');
disp(perf);

% Obtem os valores de pesos e bias em um unico vetor
wb = getwb(net);
%disp(wb);

% Separa os valores dos pesos e bias
[b,IW,LW] = separatewb(net,wb);
%disp(b);
%disp(IW);
%disp(LW);

% Converte de celula para vetor
b = cell2mat(b);
disp('Bias de todas camadas =');
disp(b);

% Converte de celula para vetor
Wescondida = cell2mat(IW);
disp('Pesos da camada escondida =');
disp(Wescondida);

% Converte de celula para vetor
Wsaida = cell2mat(LW);
disp('Pesos da camada de saida =');
disp(Wsaida);
 
% usar genFunction para criar uma funcao em matlab para arquivo .m
disp('Gravando em arquivo .m a rede neural treinada...');
genFunction(net,'rede_xor');

% Usando o arquivo .m criado
disp('Resposta da execução do arquivo .m para as entradas X normalizadas...');
Y_m = rede_xor(Xn);
disp(Y_m);
