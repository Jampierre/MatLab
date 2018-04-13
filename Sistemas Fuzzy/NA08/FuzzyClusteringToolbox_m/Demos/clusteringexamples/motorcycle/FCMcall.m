clear all
close all
path(path,'../../../FUZZCLUST')
%Dados Ionosphere
load Ionosphere.txt
%Exclui as linhas com maior de 90% de zeros
[l c] = size(Ionosphere);
temp = Ionosphere;
for i = 1:1:l
    cont = 0;
    for j = 1:1:c
        if Ionosphere(i,j) == 0
            cont = cont + 1;
        end
    end
    if cont/j >= 0.9
        temp([i],:) = [];
    end
end
Ionosphere = temp;
data.X = abs(Ionosphere(:,:)');

%Dados Abalone
%load Abalone.txt
%data.X = Abalone(:,:);

%Dados Wine
%load Wine.txt
%Wine(:,[1]) = [];
%Wine(:,[5]) = [];
%Wine(:,[14]) = []; -> essa linha deu maior diferença
%Wine(:,[6]) = [];
%Wine(:,[5]) = [];
%Wine(:,[12]) = [];
%Wine = mean(Wine);
%data.X = Wine(:,:);

%parameters
for i = 1:1:10
    i
    param.c=i; %numero de cluster
    param.m=2;
    param.e=1e-6;
    param.ro=ones(1,param.c);
    param.val=2;
    %normalization
    data=clust_normalize(data,'range');
    %clustering
    result = FCMclust(data,param);
    %plot(data.X(:,1),data.X(:,2),'b.',result.cluster.v(:,1),result.cluster.v(:,2),'ro');
    hold on
    %draw contour-map
    new.X=data.X;
    eval=clusteval(new,result,param);
    %validation
    result = validity(result,data,param);
    result.validity
end