clear all
close all
path(path,'..\..\..\FUZZCLUST')
%data set
load Wine.txt
data.X = Wine(:,[1 2]);


%parameters
param.c=10;
param.m=2;
param.e=1e-6;
param.ro=ones(1,param.c);
param.val=1;
%normalization
data=clust_normalize(data,'range');
%clustering
result = GKclust(data,param);
plot(data.X(:,1),data.X(:,2),'b.',result.cluster.v(:,1),result.cluster.v(:,2),'ro');
hold on
%draw contour-map
new.X=data.X;
eval=clusteval(new,result,param);
%validation
result = validity(result,data,param);
result.validity