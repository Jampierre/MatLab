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

% figure(1);
% plot(x);
% title('Dados Estação Meteorologica - Viçosa(19/12/2016 a 19/12/2017)')
% xlabel('Dias');
% legend('Temperatura','Umidade','Pressão','Precipitação');
% 
% figure(2);
% plot(x(:,end));
% title('Precipitação de chuva(19/12/2016 a 19/12/2017)')
% xlabel('Dias');
% ylabel('(mm)');

%1 - 7 -> Temperatura 
%8 - 14 -> Umidade
%15 - 21 -> Pressao
%22 - 27 -> Pressipitacao
[l c] = size(x);
%janela de 7 dias para prever o 8
for t=7:l-1
    Data(t-6,:)=[x(t-6,1) x(t-5,1) x(t-4,1) x(t-3,1) x(t-2,1) x(t-1,1) x(t,1) ...
        x(t-6,2) x(t-5,2) x(t-4,2) x(t-3,2) x(t-2,2) x(t-1,2) x(t,2) ...
        x(t-6,3) x(t-5,3) x(t-4,3) x(t-3,3) x(t-2,3) x(t-1,3) x(t,3) ...
        x(t+1,4)];
end

Inputs = Data(:,1:22);
Targets = Data(:,end);

nData = size(Inputs,1);

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
%nTestData=nTestData+1;
TestInd=PERM(nTrainData+1:end);
TestInputs=Inputs(TestInd,:);
TestTargets=Targets(TestInd,:);


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
