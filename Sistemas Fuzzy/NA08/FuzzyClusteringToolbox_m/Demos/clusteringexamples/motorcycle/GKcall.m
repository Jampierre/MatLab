clear all
close all
path(path,'../../../FUZZCLUST')
%data set
load Wine.txt
%Wine(:,[14]) = zeros();
%Wine(:,[13]) = [];
%Wine(:,[5]) = [];
data.X = Wine(:,:);

%data set
%load Abalone.txt
%data.X = (Abalone(:,:);

%Base do Ionosphere
%load Ionosphere.txt
%data.X = Ionosphere(:,:)';

%parameters
for i = 1:1:10
    i
    param.c=i;
    param.m=2;
    param.e=1e-6;
    param.ro=ones(1,param.c);
    param.val=2;
    %normalization
    data=clust_normalize(data,'range');
    %clustering
    result = GKclust(data,param);
    %plot(data.X(:,1),data.X(:,2),'b.',result.cluster.v(:,1),result.cluster.v(:,2),'ro');
    hold on
    %draw contour-map
    new.X=data.X;
    eval=clusteval(new,result,param);
    %validation
    result = validity(result,data,param);
    result.validity
end