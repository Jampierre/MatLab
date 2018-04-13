clear all
close all
clc

load mgdata.dat
time = mgdata(:,1);
x = mgdata(:,2);
% figure(1)
% plot(time,x)
% title('Mackey-Glass Time Series');
% xlabel('Time(s)');
% ylabel('Amplitude');

%Considerando 4 entradas e 1 saida
for t = 118:1110
    Data(t-117,:) = [x(t-18) x(t-12) x(t-6) x(t) x(t+85)];
end

trnData = Data(1:500,:);
chkData = Data(501:end,:);

clear t

%Clusterrizaçnao FCM - gera entecedentes da regra
fismat = genfis1(trnData);

%Ajustando parametros conseguentes da regura
%e fazendo ajuste fino dos antecedentes
[fismat1,error1,ss,fismat2,error2] = anfis(trnData,fismat,[100],[10],chkData);

%Evolução erro treino e check
figure(2)
plot([error1,error2]);
hold on
plot([error1,error2],'o');
xlabel('Epochs');
ylabel('RMSE');
title('Error curves');
legend('Train','Check');

figure(3)
ANFISPrediction = evalfis([trnData(:,1:4); chkData(:,1:4)], fismat2)
plot(Data(:,5));
hold on
plot(ANFISPrediction,'r');