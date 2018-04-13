% test_iris.m
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

for i=0.01:0.01:1.0
    iris_Kmax = 20;
    iris_maxContr = i;

    load('iris.data');
    data.X = iris(:, 1:(size(iris,2)-1));
    data = clust_normalize_range(data);

    % correr AP_FCM
    % fprintf('A correr Iris AP-FCM com Kmax = %d...\n', iris_Kmax)
    [crvm, r, vld] = cross_val(data, 10, 1, iris_Kmax, iris_maxContr, 1);
    %FCM clustering
    param.c = size(r.cluster.v, 1);
    param.m = 2;

    fprintf('maxContr = %.2f, ', iris_maxContr);
    fprintf('K = %d, ', param.c)
    fprintf('Xie-Beni = %.5f, ', r.xieBeni)
    fprintf('CRV-M = %.5f, ', crvm)
    fprintf('Numero Iteracoes = %d\n', r.totalIter)
    fprintf('Taxa Erro = %.5f\n', r.error_rate)

    % correr FCM aleatório
    % fprintf('A correr Iris FCM com K = %d...\n', size(r.cluster.v,1))

    % iris_Kmax = param.c;

    % [crvm_2, r_2, validation_2] = cross_val(data, 10, 0, iris_Kmax, iris_maxContr, 1);
    % param.q = 2;
    % param.c = size(r_2.cluster.v, 1);

    % fprintf('K = %d, ', r_2.nClusters)
    % fprintf('Xie-Beni = %.5f, ', r_2.xieBeni)
    % fprintf('CRV-M = %.5f, ', crvm_2)
    % fprintf('Numero Iteracoes = %d\n', r_2.totalIter)

    % fprintf('-------------\n');
end

fprintf('A testar condicao de paragem por Kmax...\n')

for i=1:10
    iris_Kmax = i;
    iris_maxContr = 1;

    load('iris.data');
    data.X = iris(:, 1:(size(iris,2)-1));
    data = clust_normalize_range(data);

    % correr AP_FCM
    % fprintf('A correr Iris AP-FCM com Kmax = %d...\n', iris_Kmax)
    [crvm, r, vld] = cross_val(data, 10, 1, iris_Kmax, iris_maxContr, 1);
    %FCM clustering
    param.c = size(r.cluster.v, 1);
    param.m = 2;

    fprintf('maxContr = %.2f, ', iris_maxContr);
    fprintf('K = %d, ', param.c)
    fprintf('Xie-Beni = %.5f, ', r.xieBeni)
    fprintf('CRV-M = %.5f, ', crvm)
    fprintf('Numero Iteracoes = %d\n', r.totalIter)
    fprintf('Taxa Erro = %.5f\n', r.error_rate)
end
