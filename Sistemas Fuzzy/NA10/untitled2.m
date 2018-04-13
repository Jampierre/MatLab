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

trnData = concrete_data(1:824,:);
chkData = concrete_data(825:end,:);

%Clusterrizaçnao FCM - gera entecedentes da regra
fismat = genfis2(trnData);

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
title('Error curves');
legend('Train','Check');

% fprintf('Min erro: %0.4f\n',min(error1))
% [C,I] = min(error2);
% fprintf('Min chkErr: %0.4f (%d)',C,I)

figure(3)
ANFISPrediction = evalfis([trnData(:,1:4); chkData(:,1:4)], fismat2)
plot(concrete_data(:,5));
hold on
plot(ANFISPrediction,'r');
legend('Real','ANFISPrediction')
