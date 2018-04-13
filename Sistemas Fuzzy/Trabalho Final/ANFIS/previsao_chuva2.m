clear all
close all
clc

load dados_precipitacao_completo.mat

dados = table2array(dados1(:,6));
[l c] = size(dados);
aux = 1;
for i=1:24:l
    x(aux) = sum(dados(i:aux*24,:));
    aux = aux + 1;
end

figure(1);
plot(x);
title('PrecipitaÁ„o de chuva(19/12/2016 a 19/12/2017)')
xlabel('Dias');
ylabel('(mm)');

[l c] = size(x');
i = 1;
for t=7:l-1
    Data(t-6,:)=[x(t-6) x(t-5) x(t-4) x(t-3) ... 
        x(t-2) x(t-1) x(t) x(t+1)];
end
len = size(Data);
% Data = abs(Data);
% minimo = min(min(Data));
% maximo = max(max(Data));
% Data = Data - minimo;
% Data = Data/(maximo - minimo);

%80% treinamento 20%teste
trnData = Data(1:304,:);
chkData = Data(305:end,:);

%Clusterriza√ßnao FCM - gera entecedentes da regra
fismat = genfis1(trnData);

%Ajustando parametros conseguentes da regura
%e fazendo ajuste fino dos antecedentes
[fismat1,error1,ss,fismat2,error2] = anfis(trnData,fismat,[200],[15],chkData);

%Evolu√ß√£o erro treino e check
figure(2)
plot([error1,error2]);
hold on
plot([error1,error2],'o');
xlabel('Epochs');
ylabel('RMSE');
title('Error curves');
legend('Train','Check');

fprintf('Min erro: %0.4f\n',min(error1))
[C,I] = min(error2);
fprintf('Min chkErr: %0.4f (%d)',C,I)

figure(3)
ANFISPrediction = evalfis([trnData(:,1:len(2)-1); chkData(:,1:len(2)-1)],fismat2);
plot(Data(:,8));
hold on
plot(ANFISPrediction,'r');
legend('Real','ANFISPrediction')