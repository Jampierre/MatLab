function [result] = run_FCM(data, k, iter)
% run_FCM.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 11-06-2012

%
% k = number of clusters
% iter = number of iteration
%
if nargin < 2
    k = 3;
    iter = 10;
end

%Xie-Beni
xie = [k-1 k k+1];
totalIter = 0;

for i = 1:3
    if xie(i) > 1
        p(i).val.validity.XB = -1;
        for j = 1:iter
            param.c = xie(i);
            aux.result = FCMclust(data, param);
            totalIter = totalIter + aux.result.iter;
            paramval.val = 2;
            aux.val = validity(aux.result, data, paramval);

            if p(i).val.validity.XB > aux.val.validity.XB 
                p(i).result = aux.result;
                p(i).val = aux.val;
            end

            if p(i).val.validity.XB == -1
                p(i).result = aux.result;
                p(i).val = aux.val;
            end
        end
    else
        p(i).val.validity.XB = intmax;
    end
end

[val, best] = min([p(1).val.validity.XB p(2).val.validity.XB p(3).val.validity.XB]);

result = p(best).result;
result.xieBeni = val;
result.nClusters = xie(best);
result.totalIter = totalIter;
