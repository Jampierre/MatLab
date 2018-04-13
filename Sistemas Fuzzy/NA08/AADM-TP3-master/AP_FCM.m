function [result] = AP_FCM(data_input, max_clusters, max_contribution, threshold)
% AP_FCM.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 12-06-2012


% 0. Setting. Put t = 1 and I_t the original entity set. Specify a threshold to discard
% all AP clusters whose cardinalities are less than the threshold.

t = 1;

Sets = struct('set', {});
centroids = [];
contribution = [];

K = max_clusters;

I.X = data_input.X;

gravity_center = mean(data_input.X);

while(1==1)

% 1. Anomalous pattern. Apply AP to I_t to find S_t(cluster t) and c_t (centroid t). 
% There can be either option taken:
% do Step 1 of AP (standardization of the data) at each t or only at t = 1. The latter is the
% recommended recomended option as it is compatible with theory in section 5.5.

	[s, c] = anomalous_pattern(I, gravity_center);
	Sets(t) = struct('set', s);
	centroids = [centroids; c];

	% Contribuição que este run do AP deu.
	currContribution = (size(s, 1) * sum(c .^ 2)) / sum(sum((data_input.X .^ 2)'));
	contribution = [contribution; currContribution];

% 2. Control. If Stop-Condition (see below) does not hold, put I_t <- I_t - S_t and t <- t + 1
% and go to Step 1. 
		% 1. All clustered. S_t = I_t so that there are no unclustered entitites left.
		% 2. Large Cumulative Contribution. The total contribution of the first t clusters
		%    ti tge data scatter has reached a pre-specified threshold such as 50%.
		% 3. Small cluster contribution of t-th cluster is too small, say, compared to 
		%    the order of average contribution of a single entity, 1/N.
		% 4. Number of Cluster reached. Number of clusters, t, has reached a pre-specified
		%    value K.

	I.X = setdiff(I.X, s, 'rows');

	if isempty(I.X) % 1.
		break;
	end

	% Mudar este valor possivelmente.
	if sum(contribution) > max_contribution
		break;
	end

	if currContribution < (1 / size(data_input.X, 1))
		break;
	end

	if size(centroids, 1) == K
		break;
	end

	t = t + 1;
	acum_contribution = 0;
end

% 3. Removal of small clusters. Remove all of the found clusters that are smaller
% than a pre-specified cluster discarding threshold for the cluster sizµe. 
% (Entities comprising singleton clusters should be checked for errors in their data entries.)
% Denote the number of remaining clusters by K and their centroid c_1,...,c_K.
finalSets = cell(size(centroids, 1));
finalCentroids = [];

for i=1:size(centroids, 1)
	if size(Sets(i).set, 1) >= threshold
		finalCentroids = [finalCentroids; centroids(i, :)];
		finalSet{size(finalCentroids, 1)} = Sets(i).set;
	end
end

for i=1:size(Sets, 1)
	if size(Sets(i).set, 1) < threshold
		distances = [];

		for j=1:size(Sets(i).set, 1)
			x = repmat(Sets(i).set(j, :), size(finalCentroids, 1), 1);
			distances = sum(((x - finalCentroids).^2)');
			[C, Idx] = min(distances);

			% Re-afectar os centroids depois de juntar os singletons aos clusters.
			finalSets{Idx} = [finalSets{Idx}; Sets(i).set(j, :)];
			finalCentroids(Idx, :) = mean(finalSets{Idx});
		end
	end
end

for i=1:size(finalCentroids, 1)
	for j=1:size(I.X, 1) 
		x = repmat(I.X(j, :), size(finalCentroids, 1), 1);
		distances = sum(((x - finalCentroids) .^ 2)');
		[C, Idx] = min(distances);

		% Re-afectar os centroids depois de juntar os singletons aos clusters.
		finalSets{Idx} = [finalSets{Idx}; I.X(j, :)];
		finalCentroids(Idx, :) = mean(finalSets{Idx});
	end
end

% 4. K-Means. Do straight (or Incremental) K-Means with c_1,..,c_K as initial seeds.

% c = number of clusters,
% m = weighting exponent [1.25 2], 
% e = termination tolerance, default 0.001

param = struct('c', size(finalCentroids, 1), 'p', finalCentroids);

result = FCM(data_input, param);
param.val = 2;
%paramval.c = size(result.cluster.v, 1);
val = validity(result, data_input, param);

result.xieBeni = val.validity.XB;
result.totalIter = result.iter + t;
