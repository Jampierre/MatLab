clear all;close all;clc

load concrete_data.mat

ConcreteData2 = table2array(ConcreteData2);
concrete_data = abs(ConcreteData2);
minimo = min(min(concrete_data));
maximo = max(max(concrete_data));
concrete_data = concrete_data - minimo;
data = concrete_data/(maximo - minimo);

clear ConcreteData2 minimo maximo;

%aleat = randperm(1030);
% for i = 1:round(length(data)*0.6)
%     trnData(i,:) = data(aleat(i),:);
% end
% 
% for i = 1:round(length(data)*0.4)
%     chkData(i,:) = data(aleat(i+618),:);
% end
data = data(1:end,:);

len = size(data);
trnData = data(1:618,:);
chkData = data(619:928,:);
tstData = data(929:end,:);




%Clusterização FCM - gera antecedentes da regra
[coeff, score, latent, tsquare] = princomp(trnData);
inmftype = 'trimf';
%trimf;trapmf;gbellmf;gaussmf;gaussmf2;pimf;dsigmf;psigmf
numMFs = 3*ones(1 , size(data,2)-1);
outmftype = 'linear';%liner;constant
%fismat = genfis1(trnData,numMFs,inmftype,outmftype);
fismat = genfis2(trnData,tsquare,1);

%Ajustando parâmetros consequentes da regra
%e fazendo ajuste fino dos antecedentes
[fismat1,error1,ss,fismat2,error2] = anfis(trnData,fismat,[],[],chkData);

%Evolução erro treino e check
figure(2)
plot([error1 error2]);
hold on
plot([error1 error2],'o');
xlabel('Epochs');
ylabel('RMSE');
title('Error curves')
legend('Training','Checking')
fprintf('Min erro: %0.4f\n',min(error1))
[C,I] = min(error2);
fprintf('Min chkErr: %0.4f (%d)',C,I)

ANFISPrediction = evalfis([trnData(:,1:len(2)-1); chkData(:,1:len(2)-1)],fismat2);
%ANFISPrediction = evalfis(data(:,1:4),fismat2);
figure(3)
plot(data(:,3));
hold on
plot(ANFISPrediction,'r')
legend('Real','ANFISPrediction')


