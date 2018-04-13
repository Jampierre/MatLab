%RNA

clc;
clear;
close all;

%% Create Time-Series Data 1

%Estação Meteorologica de Viçosa (19/12/2016 a 18/12/2017
load dados_vicosa.mat
dados = table2array(dadosvicosa(:,3:end));

%Estaçnao Meteorologica de Governador Valadres (21/01/2017 a 20/01/2018)
%load dados_governador_valadares.mat
%dados = table2array(dadosgv(:,3:end));

[l c] = size(dados);
aux = 1;
%Viçosa = -16; GV = -23
for i=1:24:l-16
    x(aux,1) = median(dados(i:aux*24,1));
    x(aux,2) = median(dados(i:aux*24,2));
    x(aux,3) = median(dados(i:aux*24,3));
    x(aux,4) = median(dados(i:aux*24,4));
    x(aux,5) = median(dados(i:aux*24,5));
    x(aux,6) = median(dados(i:aux*24,6));
    x(aux,7) = median(dados(i:aux*24,7));
    x(aux,8) = median(dados(i:aux*24,8));
    x(aux,9) = sum(dados(i:aux*24,end));
    aux = aux + 1;
end

%(1)temp, (2)umid, (3)orvalho, (4)pressao, (5)vento direcao, (6)vento velocidade, (7)vento
%rajada, (8)radiacao, (9)pressipitação.
[l c] = size(x);
%janela de 7 dias para prever o 8
for t=7:l-1
    Data(t-6,:)=[x(t-6,1) x(t-5,1) x(t-4,1) x(t-3,1) x(t-2,1) x(t-1,1) x(t,1) ...
        x(t-6,2) x(t-5,2) x(t-4,2) x(t-3,2) x(t-2,2) x(t-1,2) x(t,2) ...
        x(t-6,3) x(t-5,3) x(t-4,3) x(t-3,3) x(t-2,3) x(t-1,3) x(t,3) ...
        x(t-6,4) x(t-5,4) x(t-4,4) x(t-3,4) x(t-2,4) x(t-1,4) x(t,4) ...
        x(t-6,5) x(t-5,5) x(t-4,5) x(t-3,5) x(t-2,5) x(t-1,5) x(t,5) ...
        x(t-6,7) x(t-5,7) x(t-4,7) x(t-3,7) x(t-2,7) x(t-1,7) x(t,7) ...
        x(t+1,9)];
    
    %Não tem correlação com a saida
    %x(t-6,6) x(t-5,6) x(t-4,6) x(t-3,6) x(t-2,6) x(t-1,6) x(t,6)
    %x(t-6,8) x(t-5,8) x(t-4,8) x(t-3,8) x(t-2,8) x(t-1,8) x(t,8)
end

Inputs = Data(:,1:42);
Targets = Data(:,end);

nData = size(Inputs,1);

%% Shuffling Data

%PERM = randperm(nData);
PERM = [1:nData]; %Não faz permutação pois a variante do tempo é relevante,
%para adaptar ao programar o PERM simplesmente recebe a ortem exate das
%colunas, nesse caso de 1 a 22.

pTrain=0.85;
nTrainData=pTrain*nData;
TrainInd=PERM(1:nTrainData);
TrainInputs=Inputs(TrainInd,:);
TrainTargets=Targets(TrainInd,:);

pTest=1-pTrain;
nTestData=nData-nTrainData;
%nTestData=nTestData+1;
TestInd=PERM(nTrainData+1:end);
TestInputs=Inputs(TestInd,:);
TestTargets=Targets(TestInd,:);


%% Create a PMC (Perceptron Multicamadas)
net = network;

%% Setting the Parameters of RNA
%net = network(1,2,[1;0],[1; 0],[0 0; 1 0],[0 1])
net.numInputs = 6;
net.numLayers = 2;
net.biasConnect = [1;1];
for i=1:6
    net.inputConnect(1,i) = 1;
end
net.outputConnect = [0 1];
%net.targetConnect = [0 1 0]; função absoleta

net.inputs{1}.range = [11.9 25.3; 11.9 25.3; 11.9 25.3; 11.9 25.3; 11.9 25.3; 11.9 25.3; 11.9 25.3];
net.inputs{2}.range = [42 95.5; 42 95.5; 42 95.5; 42 95.5; 42 95.5; 42 95.5; 42 95.5];
net.inputs{3}.range = [8 20.7; 8 20.7; 8 20.7; 8 20.7; 8 20.7; 8 20.7; 8 20.7];
net.inputs{4}.range = [927.15 948.2; 927.15 948.2; 927.15 948.2; 927.15 948.2; 927.15 948.2; 927.15 948.2; 927.15 948.2];
net.inputs{5}.range = [0 2.9; 0 2.9; 0 2.9; 0 2.9; 0 2.9; 0 2.9; 0 2.9];
net.inputs{6}.range = [0.4 7.65; 0.4 7.65; 0.4 7.65; 0.4 7.65; 0.4 7.65; 0.4 7.65; 0.4 7.65];

net.initFcn = 'initnw';
net.performFcn = 'mse';
net.trainFcn = 'trainrp';

net = init(net);

%[net, tr] = train(net,TrainInputs,TrainTargets);
%net = configure(net,Inputs,Targets);

