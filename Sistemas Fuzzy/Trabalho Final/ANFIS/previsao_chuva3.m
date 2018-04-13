clear all
close all
clc

load dados_precipitacao_completo.mat

dados = table2array(dados1(:,3:end));
[l c] = size(dados);
aux = 1;
for i=1:24:l
    x(aux,1) = median(dados(i:aux*24,1));
    x(aux,2) = median(dados(i:aux*24,2));
    x(aux,3) = median(dados(i:aux*24,3));
    x(aux,4) = sum(dados(i:aux*24,end));
    aux = aux + 1;
end

figure(1);
plot(x);
title('Dados Estação Meteorologica - Viçosa(19/12/2016 a 19/12/2017)')
xlabel('Dias');
legend('Temperatura','Umidade','Pressão','Precipitação');

figure(2);
plot(x(:,end));
title('Precipitação de chuva(19/12/2016 a 19/12/2017)')
xlabel('Dias');
ylabel('(mm)');

%1 - 7 -> Temperatura 
%8 - 14 -> Umidade
%15 - 21 -> Pressao
%22 - 27 -> Pressipitacao
[l c] = size(x);
%janela de 7 dias para prever o 8
% for t=7:l-1
%     Data(t-6,:)=[x(t-6,1) x(t-5,1) x(t-4,1) x(t-3,1) x(t-2,1) x(t-1,1) x(t,1) ...
%         x(t-6,2) x(t-5,2) x(t-4,2) x(t-3,2) x(t-2,2) x(t-1,2) x(t,2) ...
%         x(t-6,3) x(t-5,3) x(t-4,3) x(t-3,3) x(t-2,3) x(t-1,3) x(t,3) ...
%         x(t+1,4)];
%         %x(t-6,4) x(t-5,4) x(t-4,4) x(t-3,4) x(t-2,4) x(t-1,4) x(t,4) ...
%         %x(t+1,4)];
% end

%janela de 2 dias atras para prever o terceiro 
for t = 3:l-1
    Data(t-2,:)=[ x(t-2,1) x(t-1,1) x(t,1) ...
         x(t-2,2) x(t-1,2) x(t,2)...
         x(t-2,3) x(t-1,3) x(t,3)...
        x(t+1,4)];
end

%correlacao = corr(Data); %corelação entre as colunhas com a saida
%correlacao(correlacao == 1) = 0;
%correlacao = max(abs(correlacao));
%triu tril
%OBS: As entradas de pressipitação mostraram baixa correlação
% Data = abs(Data);
% minimo = min(min(Data));
% maximo = max(max(Data));
% Data = Data - minimo;
% Data = Data/(maximo - minimo);

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
% 
fprintf('Min erro: %0.4f\n',min(error1))
[C,I] = min(error2);
fprintf('Min chkErr: %0.4f (%d)',C,I)
% 
figure(4)
ANFISPrediction = evalfis([trnData(:,1:len(2)-1); chkData(:,1:len(2)-1)],fismat2);
plot(Data(:,10));
hold on
plot(ANFISPrediction,'r');
legend('Real','ANFISPrediction')