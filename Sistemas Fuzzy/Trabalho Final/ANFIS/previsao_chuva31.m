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
    Data(t-6,:)=[
        %x(t-6,1) x(t-5,1) x(t-4,1) x(t-3,1) x(t-2,1) x(t-1,1) x(t,1) ...
        %x(t-6,2) x(t-5,2) x(t-4,2) x(t-3,2) x(t-2,2) x(t-1,2) x(t,2) ...
        %x(t-6,3) x(t-5,3) x(t-4,3) x(t-3,3) x(t-2,3) x(t-1,3) x(t,3) ...
        %x(t-6,4) x(t-5,4) x(t-4,4) x(t-3,4) x(t-2,4) x(t-1,4) x(t,4) ...
        x(t-6,5) x(t-5,5) x(t-4,5) x(t-3,5) x(t-2,5) x(t-1,5) x(t,5) ...
        x(t-6,7) x(t-5,7) x(t-4,7) x(t-3,7) x(t-2,7) x(t-1,7) x(t,7) ...
        x(t+1,9)];
    %Não tem correlação com a saida
    %x(t-6,6) x(t-5,6) x(t-4,6) x(t-3,6) x(t-2,6) x(t-1,6) x(t,6)
    %x(t-6,8) x(t-5,8) x(t-4,8) x(t-3,8) x(t-2,8) x(t-1,8) x(t,8)
end

% Data = abs(Data);
% minimo = min(min(Data));
% maximo = max(max(Data));
% Data = Data - minimo;
% Data = Data/(maximo - minimo);

colunas= 6;
[coeff,score,latent,tsquared,explained,mu] = pca(Data(:,1:end-1));
sum(explained(1:colunas))
Data = [score(:,1:colunas) Data(:,end)];

len = size(Data);
%85% treinamento 20%teste
trnData = Data(1:304,:);
chkData = Data(305:end,:);

%ClusterrizaÃ§nao FCM - gera entecedentes da regra
fismat = genfis1(trnData);

%Ajustando parametros conseguentes da regura
%e fazendo ajuste fino dos antecedentes
[fismat1,error1,ss,fismat2,error2] = anfis(trnData,fismat,[200],[15],chkData);

%EvoluÃ§Ã£o erro treino e check
figure(3)
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
 
figure(4)
ANFISPrediction = evalfis([trnData(:,1:len(2)-1); chkData(:,1:len(2)-1)],fismat2);
plot(Data(:,colunas+1));
hold on
plot(ANFISPrediction,'r');
legend('Real','ANFISPrediction')