function [res] = score_fun(Po, Pv)
% score_fun.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 11-06-2012

%
% Pv = Test
% Po = Training
%

clusters_Po = cell(size(Po.cluster.v, 1));
clusters_Pv = cell(size(Pv.cluster.v, 1));

for i=1:size(Po.data.f, 1)
	[~, I] = min(Po.data.f(i, :));
	clusters_Po{I} = [clusters_Po{I}; i];
end

for i=1:size(Pv.data.f, 1)
	[~, I] = min(Pv.data.f(i, :));
	clusters_Pv{I} = [clusters_Pv{I}; i];
end

confusion = [];

% fazer matriz de confusa, como eu
for i=1:size(Po.cluster.v, 1)
	for j=1:size(Pv.cluster.v, 1)
		[rows, ~] = size(setdiff(clusters_Po{i}, clusters_Pv{j}));
		confusion(i, j) = rows / size(Pv.data.f, 1);
	end
end

%Minimize mismatch coeff.
colsum = sum(confusion,1);
rowsum = sum(confusion,2);
res = sum(colsum .^ 2) + sum(rowsum .^ 2) - (2 * sum(sum(confusion .^ 2)));
