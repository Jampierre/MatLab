% test_wine.m
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

%----- Wine -----

for i=0.01:0.01:1.0
    wine_Kmax = 20;
    wine_maxContr = i;

    load('wine.data');
    data.X = wine(:, 2:size(wine,2));
    data = clust_normalize_range(data);

    % correr AP_FCM
    % fprintf('A correr Iris AP-FCM com Kmax = %d...\n', iris_Kmax)
    [crvm, r, vld] = cross_val(data, 10, 1, wine_Kmax, wine_maxContr, 1);
    %FCM clustering
    param.c = size(r.cluster.v, 1);
    param.m = 2;

    fprintf('maxContr = %.2f, ', wine_maxContr);
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
    wine_Kmax = i;
    wine_maxContr = 1;

    load('wine.data');
    data.X = wine(:, 2:size(wine,2));
    data = clust_normalize_range(data);

    % correr AP_FCM
    % fprintf('A correr Iris AP-FCM com Kmax = %d...\n', iris_Kmax)
    [crvm, r, vld] = cross_val(data, 10, 1, wine_Kmax, wine_maxContr, 1);
    %FCM clustering
    param.c = size(r.cluster.v, 1);
    param.m = 2;

    fprintf('maxContr = %.2f, ', wine_maxContr);
    fprintf('K = %d, ', param.c)
    fprintf('Xie-Beni = %.5f, ', r.xieBeni)
    fprintf('CRV-M = %.5f, ', crvm)
    fprintf('Numero Iteracoes = %d\n', r.totalIter)
    fprintf('Taxa Erro = %.5f\n', r.error_rate)
end

