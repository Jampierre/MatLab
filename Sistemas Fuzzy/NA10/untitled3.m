clear all
close all
clc

load concrete_data.mat

ConcreteData2 = table2array(ConcreteData2);
concrete_data = abs(ConcreteData2);
minimo = min(min(concrete_data));
maximo = max(max(concrete_data));
concrete_data = concrete_data - minimo;
concrete_data = concrete_data/(maximo - minimo);

clear ConcreteData2 minimo maximo;

%% Redução de dimensionalidade
colunas= 4;
[coeff,score,latent,tsquared,explained,mu] = pca(concrete_data(:,1:end-1));
sum(explained(1:colunas))
concrete_data = [score(:,1:colunas) concrete_data(:,end)];

len = size(concrete_data);
[l c] = size(concrete_data);
%80% treinamento 20%teste
trnData = concrete_data(1:l*0.8,:);
chkData = concrete_data((l*0.8)+1:end,:);


%Clusterização FCM - gera antecedentes da regra
inmftype = 'gaussmf'; %Mudar as funçnøes de entrada trimf, gaussmf, trapmf , pimf, dsigmf, psigmf
%trimf;trapmf;gbellmf;gaussmf;gaussmf2;pimf;dsigmf;psigmf
numMFs = 3*ones(1 , size(concrete_data,2)-1);
outmftype = 'linear';%liner;constant
fismat = genfis1(trnData,numMFs,inmftype,outmftype);
%fismat = genfis2(concrete_data,tsquare,1);

%Ajustando parametros conseguentes da regura
%e fazendo ajuste fino dos antecedentes
[fismat1,error1,ss,fismat2,error2] = anfis(trnData,fismat,[500],[],chkData);

%Evolução erro treino e check
figure(2)
plot([error1,error2]);
hold on
plot([error1,error2],'o');
xlabel('Epochs');
ylabel('RMSE');
title('Error curves - Entrada gaussmf');
legend('Train','Check');

fprintf('Min erro: %0.4f\n',min(error1))
[C,I] = min(error2);
fprintf('Min chkErr: %0.4f (%d)',C,I)

figure(3)
ANFISPrediction = evalfis([trnData(:,1:len(2)-1); chkData(:,1:len(2)-1)],fismat2);
plot(concrete_data(:,colunas));
hold on
plot(ANFISPrediction,'r');
legend('Real','ANFISPrediction')