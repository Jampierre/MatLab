% script.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 11-06-2012
addpath('FuzzyClusteringToolbox_m/FUZZCLUST');

clear all
close all

%----- Iris -----

iris_Kmax = 2;
iris_maxContr = 1;

load('iris.data');
data.X = iris(:, 1:(size(iris,2)-1));
data = clust_normalize_range(data);

x = 1;

% correr AP_FCM
fprintf('A correr Iris AP-FCM com Kmax = %d...\n', iris_Kmax)
[crvm, r, validation] = cross_val(data, 10, 1, iris_Kmax, iris_maxContr, 1);
%FCM clustering
param.c = size(r.cluster.v, 1);
param.m = 2;

fprintf('K = %d\n', param.c)
fprintf('Xie-Beni = %.5f\n', r.xieBeni)
fprintf('CRV-M = %.5f\n', crvm)
fprintf('Numero Iteracoes = %d\n', r.totalIter)
fprintf('Taxa de erro = %.5f\n', r.error_rate)

% Visualizar

param.q = 2;
result = PCA(data,param,r);
figure(x)
plot(result.proj.P(:,1),result.proj.P(:,2),'.')
hold on
plot(result.proj.vp(:,1),result.proj.vp(:,2),'r*')
perf = projeval(result,param);
perf
x = x + 1;


figure(x);
length = size(r.data.f,2);
for i=1:length
	subplot(length, 1, i);
	plot(1:size(r.data.f,1), r.data.f(:, i))
	hold on
end
x = x + 1;


% correr FCM aleatório
fprintf('A correr Iris FCM com K = %d...\n', size(r.cluster.v,1))

iris_Kmax = param.c;

[crvm_2, r_2, validation_2] = cross_val(data, 10, 0, iris_Kmax, iris_maxContr, 1);
param.q = 2;
param.c = size(r_2.cluster.v, 1);

fprintf('K = %d\n', r_2.nClusters)
fprintf('Xie-Beni = %.5f\n', r_2.xieBeni)
fprintf('CRV-M = %.5f\n', crvm_2)
fprintf('Numero Iteracoes = %d\n', r_2.totalIter)
fprintf('Taxa de erro = %.5f\n', r_2.error_rate)

% Visualizar

result_2 = PCA(data, param, r_2);
figure(x)
plot(result_2.proj.P(:,1),result_2.proj.P(:,2),'.')
hold on
plot(result_2.proj.vp(:,1),result_2.proj.vp(:,2),'r*')
perf = projeval(result_2,param);
perf
x = x + 1;


figure(x)
length = size(r_2.data.f,2);
for i=1:length
	subplot(length, 1, i);
	plot(1:size(r_2.data.f,1), r_2.data.f(:, i))
	hold on
end
x = x + 1;

%----- Wine -----

wine_Kmax = 8;
wine_maxContribution = 1;

load('wine.data')
data.X = wine(:, 2:size(wine, 2));
data = clust_normalize_range(data);

% correr AP_FCM
fprintf('A correr Wine AP-FCM...\n')
[crvm_wine, r_wine, validation_wine] = cross_val(data, 10, 1, wine_Kmax, wine_maxContribution, 1);
%FCM clustering
param.c = size(r_wine.cluster.v, 1);
param.m = 2;

fprintf('K = %d\n', param.c)
fprintf('Xie-Beni = %.5f\n', r_wine.xieBeni)
fprintf('CRV-M = %.5f\n', crvm_wine)
fprintf('Numero Iteracoes = %d\n', r_wine.totalIter)
fprintf('Taxa de erro = %.5f\n', r_wine.error_rate)

% Visualizar

%PCA projection
param.q = 2;
result_wine = PCA(data, param, r_wine);
figure(x)
plot(result_wine.proj.P(:,1),result_wine.proj.P(:,2),'.')
hold on
plot(result_wine.proj.vp(:,1),result_wine.proj.vp(:,2),'r*')
perf = projeval(result_wine,param);
perf
x = x + 1;


figure(x);
length = size(r_wine.data.f,2);
for i=1:length
	subplot(length, 1, i);
	plot(1:size(r_wine.data.f,1), r_wine.data.f(:, i))
	hold on
end
x = x + 1;

wine_Kmax = param.c;

% correr FCM aleatório
fprintf('A correr Wine FCM com K = %d...\n', param.c)

[crvm_2_wine, r_2_wine, validation_2_wine] = cross_val(data, 10, 0, wine_Kmax, wine_maxContribution, 1);
param.q = 2;
param.c = size(r_2_wine.cluster.v, 1);


fprintf('K = %d\n', r_2_wine.nClusters)
fprintf('Xie-Beni = %.5f\n', r_2_wine.xieBeni)
fprintf('CRV-M = %.5f\n', crvm_2_wine)
fprintf('Numero Iteracoes = %d\n', r_2_wine.totalIter)
fprintf('Taxa de erro = %.5f\n', r_2_wine.error_rate)


% Visualizar

%PCA projection

result_2_wine = PCA(data, param, r_2_wine);
figure(x)
plot(result_2_wine.proj.P(:,1),result_2_wine.proj.P(:,2),'.')
hold on
plot(result_2_wine.proj.vp(:,1),result_2_wine.proj.vp(:,2),'r*')
perf = projeval(result_2_wine,param);
perf
x = x + 1;


figure(x)
length = size(r_2_wine.data.f,2);
for i=1:length
	subplot(length, 1, i);
	plot(1:size(r_2_wine.data.f,1), r_2_wine.data.f(:, i))
	hold on
end
x = x + 1;
