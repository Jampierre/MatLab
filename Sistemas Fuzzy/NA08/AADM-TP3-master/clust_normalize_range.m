function data = clust_normalize_range(data);
% clust_normalize_range.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 12-06-2012

%  uses 'range'    Values are normalized between [0,1] (linear operation).

data.Xold=data.X;

data.min=min(data.X);
data.max=max(data.X);
data.X=((data.X-repmat(mean(data.X),size(data.X,1),1))) ./ (repmat(max(data.X),...
size(data.X,1),1)-repmat(min(data.X),size(data.X,1),1));
