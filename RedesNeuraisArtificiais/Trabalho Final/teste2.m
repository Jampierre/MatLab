clc;
clear;
close all;
load dados_prontos.mat

Inputs = Data(:,1);
Targets = Data(:,end);

nData = size(Inputs,1);

% figure(1);
% plot (1:size(Targets),Targets);
% title('Dados de treinamento');

PERM = [1:nData]; 

pTrain=0.7;
nTrainData=pTrain*nData;
TrainInd=PERM(1:nTrainData);
TrainInputs=Inputs(TrainInd,:);
TrainTargets=Targets(TrainInd,:);

pTest=1-pTrain;
nTestData=nData-nTrainData;
TestInd=PERM(nTrainData+1:end);
TestInputs=Inputs(TestInd,:);
TestTargets=Targets(TestInd,:);

% Cria a rede neural
net = feedforwardnet([42 50]);
net.numInputs = 42;
for i=1:42
    net.inputConnect(1,i) = 1;
end
view(net)
%net = configure(net,TrainInputs,TrainTargets);

net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';

%[net,tr] = train(net,TrainInputs,TrainTargets);

% Treina a rede neural
%net = train(net,Inputs,Targets);

% Simula a rede neural
%Targets = sim(net,Inputs);

% Plota resultado da aproximacao
%figure(2);
%plot (Inputs,Targets);
%title('Resultado');