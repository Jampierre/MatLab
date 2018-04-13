clc, close all, clear all;

%% Chamando o arquivo do excel
%filename = 'Concrete_Data.xls';
load concrete_data.mat
%mgdata = xlsread(filename);
mgdata = table2array(ConcreteData2);
%% Colocando um tamanho para o arquivo
time = 1:size(mgdata); 
time = time';
%% pegando a ultima coluna que os dados de saida
x_n_normalize = mgdata(:, [1:7] ); %x = mgdata(:, [1:8]); x = mgdata(:, [2:5]);
x = x_n_normalize/norm(x_n_normalize);
%  x = (x_n_normalize - min(x_n_normalize)) / ( max(x_n_normalize) - min(x_n_normalize) )
% x = normc(x_n_normalize);
%% Fazendo correlação com os dados da tabela
x_corr = [mgdata(:,1:8)];
MatrizCorr = corr(x_corr);
covarianca = sum(MatrizCorr)/8    % A coluna menos correlacionada é a coluna 7, por ter o menor valor
%% Calculando o minimo da covariança
min(abs(covarianca))
%% utilizando a coluna menos correlacionada
% figure(10), plot(mgdata(:,7), x); 
% title('Serie Temporal do Concrete Data')
% xlabel('Time (sec)')

figure(1);
plot(time, x);
title('Mackey-Glass Time Series')
xlabel('Time (sec)')
xlabel('Amplitude')

% considerando 4 entradas e 1 saida
% Algoritmo Runge-Kutta de 4ª ordem: útil para obter solução numérica
inicio=118;
for t=inicio:(size(mgdata)-inicio)
   Data(t-117,:)=[x(t-18) x(t-12) x(t-6) x(t) x(t+2)]; 
    
end

trnData = Data(1:500,:);
chkData = Data(501:end,:);
corr(trnData)
clear t

% clusteriacação FCM antecedente das regras
fismat = genfis1(trnData);
% fuzzy(fismat)
% figure(2),plotmf(fismat,'input',1)
% figure(3),plotmf(fismat,'input',2)

% Ajuste fino  ajustando parametros conseqentes da regra e fazendo ajuste
% fino dos antecedentes 
[fismat1,erro1,ss,fismat2,erro2] = anfis(trnData,fismat,[100],[],chkData); %display [10]

figure('Name','Fismat1');
subplot(2,2,1), plotmf(fismat, 'input', 1)
subplot(2,2,2), plotmf(fismat, 'input', 2)
subplot(2,2,3), plotmf(fismat, 'input', 3)
subplot(2,2,4), plotmf(fismat, 'input', 4)

figure('Name','Fismat 2');
subplot(2,2,1), plotmf(fismat2, 'input', 1)
subplot(2,2,2), plotmf(fismat2, 'input', 2)
subplot(2,2,3), plotmf(fismat2, 'input', 3)
subplot(2,2,4), plotmf(fismat2, 'input', 4)


%  evolução do erro treino e check
figure('Name','erro');
plot([erro1 erro2]);
hold on
plot([erro1 erro2],'o');
xlabel('Epocas de treinamentos');
ylabel('RMSE');
title('error curves');
legend({'Train', 'Check'})

ANFISPrediction = evalfis([trnData(:,1:4); chkData(:,1:4)],fismat2);

figure('Name','Data e ANFISPrediction');
plot(Data(:,5));
hold on;
plot(ANFISPrediction)
% achar uma base de dados de regressão 
% PCA lda, tese de hipostese nula, teste tukey

figure('Name',' Comparação série Mackey-Glass original × previsão FIS');
anfis_output = evalfis([trnData(:,1:4); chkData(:,1:4)], fismat2);
index = inicio:(size(x)-inicio);
subplot(2,1,1);
plot(time(index),[x(index) anfis_output]);
xlabel('Time (sec)');
title('MG Series and ANFIS Prediction');

subplot(2,1,2);
plot(time(index),x(index) - anfis_output);
xlabel('Time (sec)');
title('Prediction Errors');
