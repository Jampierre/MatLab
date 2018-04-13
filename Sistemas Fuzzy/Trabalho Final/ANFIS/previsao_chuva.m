clear all
close all
clc

load dados_precipitacao.mat

dados = abs(dados);
minimo = min(min(dados));
maximo = max(max(dados));
dados = dados - minimo;
dados = dados/(maximo - minimo);

len = size(dados);
[l c] = size(dados);
%80% treinamento 20%teste
trnData = dados(1:l*0.8,:);
chkData = dados((l*0.8)+1:end,:);

%Clusterização FCM - gera antecedentes da regra
inmftype = 'gbellmf'; %Mudar as funçnøes de entrada trimf, gaussmf, trapmf , pimf, dsigmf, psigmf
%trimf;trapmf;gbellmf;gaussmf;gaussmf2;pimf;dsigmf;psigmf
numMFs = 3*ones(1 , size(dados,2)-1);
outmftype = 'constant';%liner;constant
fismat = genfis1(trnData,numMFs,inmftype,outmftype);

%Ajustando parametros conseguentes da regura
%e fazendo ajuste fino dos antecedentes
[fismat1,error1,ss,fismat2,error2] = anfis(trnData,fismat,[100],[],chkData);

%Evolução erro treino e check
figure(2)
plot([error1,error2]);
hold on
plot([error1,error2],'o');
xlabel('Epochs');
ylabel('RMSE');
title('Error curves - Entrada gbellmf');
legend('Train','Check');

fprintf('Min erro: %0.4f\n',min(error1))
[C,I] = min(error2);
fprintf('Min chkErr: %0.4f (%d)',C,I)

figure(3)
ANFISPrediction = evalfis([trnData(:,1:len(2)-1); chkData(:,1:len(2)-1)],fismat2);
plot(dados(:,c-1));
hold on
plot(ANFISPrediction,'r');
legend('Real','ANFISPrediction')