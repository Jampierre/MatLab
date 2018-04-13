clc;
clear;
close all;
load dados_prontos.mat

Inputs = Data(:,1:42);
Targets = Data(:,end);

nData = size(Inputs,1);


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

net = feedforwardnet([100 50]); 
net = configure(net,TrainInputs,TrainTargets);

net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';

%[net,tr] = train(net,TrainInputs,TrainTargets);

plot (Data(:,end),'b');
hold on;

%out = net(TestInputs);