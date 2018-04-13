

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
        x(t-6,1) x(t-5,1) x(t-4,1) x(t-3,1) x(t-2,1) x(t-1,1) x(t,1) ...
        x(t-6,2) x(t-5,2) x(t-4,2) x(t-3,2) x(t-2,2) x(t-1,2) x(t,2) ...
        x(t-6,3) x(t-5,3) x(t-4,3) x(t-3,3) x(t-2,3) x(t-1,3) x(t,3) ...
        x(t-6,4) x(t-5,4) x(t-4,4) x(t-3,4) x(t-2,4) x(t-1,4) x(t,4) ...
        x(t-6,5) x(t-5,5) x(t-4,5) x(t-3,5) x(t-2,5) x(t-1,5) x(t,5) ...
        x(t-6,7) x(t-5,7) x(t-4,7) x(t-3,7) x(t-2,7) x(t-1,7) x(t,7) ...
        x(t+1,9)];
    %Não tem correlação com a saida
    %x(t-6,6) x(t-5,6) x(t-4,6) x(t-3,6) x(t-2,6) x(t-1,6) x(t,6)
    %x(t-6,8) x(t-5,8) x(t-4,8) x(t-3,8) x(t-2,8) x(t-1,8) x(t,8)
end

Inputs = Data(:,1:21);
Targets = Data(:,end);

nData = size(Inputs,1);

%% Shuffling Data

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
TestInd=PERM(nTrainData+1:end);
TestInputs=Inputs(TestInd,:);
TestTargets=Targets(TestInd,:);



%% Setting the Parameters of FIS Generation Methods

Prompt={'Number fo Clusters:',...
                'Partition Matrix Exponent:',...
                'Maximum Number of Iterations:',...
                'Minimum Improvemnet:'};
        Title='Enter genfis3 parameters';
        DefaultValues={'15', '2', '200', '1e-5'};
        
        PARAMS=inputdlg(Prompt,Title,1,DefaultValues);
        pause(0.01);

        nCluster=str2num(PARAMS{1});        %#ok
        Exponent=str2num(PARAMS{2});        %#ok
        MaxIt=str2num(PARAMS{3});           %#ok
        MinImprovment=str2num(PARAMS{4});	%#ok
        DisplayInfo=1;
        FCMOptions=[Exponent MaxIt MinImprovment DisplayInfo];
        
        fis=genfis3(TrainInputs,TrainTargets,'sugeno',nCluster,FCMOptions);
        
%% Training ANFIS Structure

Prompt={'Maximum Number of Epochs:',...
        'Error Goal:',...
        'Initial Step Size:',...
        'Step Size Decrease Rate:',...
        'Step Size Increase Rate:'};
Title='Enter genfis3 parameters';
DefaultValues={'200', '0', '0.01', '0.9', '1.1'};

PARAMS=inputdlg(Prompt,Title,1,DefaultValues);
pause(0.01);

MaxEpoch=str2num(PARAMS{1});                %#ok
ErrorGoal=str2num(PARAMS{2});               %#ok
InitialStepSize=str2num(PARAMS{3});         %#ok
StepSizeDecreaseRate=str2num(PARAMS{4});    %#ok
StepSizeIncreaseRate=str2num(PARAMS{5});    %#ok
TrainOptions=[MaxEpoch ...
              ErrorGoal ...
              InitialStepSize ...
              StepSizeDecreaseRate ...
              StepSizeIncreaseRate];

DisplayInfo=true;
DisplayError=true;
DisplayStepSize=true;
DisplayFinalResult=true;
DisplayOptions=[DisplayInfo ...
                DisplayError ...
                DisplayStepSize ...
                DisplayFinalResult];

OptimizationMethod=1;
% 0: Backpropagation
% 1: Hybrid
            
fis=anfis([TrainInputs TrainTargets],fis,TrainOptions,DisplayOptions,[],OptimizationMethod);


%% Apply ANFIS to Data

Outputs=evalfis(Inputs,fis);
TrainOutputs=Outputs(TrainInd,:);
TestOutputs=Outputs(TestInd,:);

%% Error Calculation

TrainErrors=TrainTargets-TrainOutputs;
TrainMSE=mean(TrainErrors.^2);
TrainRMSE=sqrt(TrainMSE);
TrainErrorMean=mean(TrainErrors);
TrainErrorSTD=std(TrainErrors);

TestErrors=TestTargets-TestOutputs;
TestMSE=mean(TestErrors.^2);
TestRMSE=sqrt(TestMSE);
TestErrorMean=mean(TestErrors);
TestErrorSTD=std(TestErrors);

%% Plot Results

figure;
PlotResults(TrainTargets,TrainOutputs,'Train Data');

figure;
PlotResults(TestTargets,TestOutputs,'Test Data');

figure;
PlotResults(Targets,Outputs,'All Data');

if ~isempty(which('plotregression'))
    figure;
    plotregression(TrainTargets, TrainOutputs, 'Train Data', ...
                   TestTargets, TestOutputs, 'Test Data', ...
                   Targets, Outputs, 'All Data');
    set(gcf,'Toolbar','figure');
end

figure;
gensurf(fis, [1 2], 1, [30 30]);
xlim([min(Inputs(:,1)) max(Inputs(:,1))]);
ylim([min(Inputs(:,2)) max(Inputs(:,2))]);

plot(Data(:,end));
hold on
plot(Outputs,'r');
legend('Real','ANFISPrediction')
