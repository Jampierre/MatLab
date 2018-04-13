function [S, centroid] = anomalous_pattern(data, gravity_center)
% anomalous_pattern.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 12-06-2012

% Find gravity center
tentative_centroid = [];
max_dist = -1;

for i=1:size(data.X, 1)
    dist = norm(data.X(i, :) - gravity_center);
    if (dist > max_dist || max_dist == -1)
        max_dist = dist;
        tentative_centroid = data.X(i,:);
    end
end

% Cluster onde d(y_i, tentative) < d(y_i, gravity_center)
S = [];

while (1 == 1)
    % Afectacao ao cluster
    for i=1:size(data.X, 1)
        d_tentative = sum((data.X(i, :) - tentative_centroid) .^ 2);
        d_gravity = sum((data.X(i, :) - gravity_center) .^ 2);
        if d_tentative < d_gravity
            S = [S; data.X(i, :)];
        end
    end

    % Actualizacao do centroide
    if size(S, 1) > 1
        new_centroid = mean(S);
    else
        new_centroid = S;
    end

    if isequal(new_centroid, tentative_centroid)
        break;
    end

    S = [];
    tentative_centroid = new_centroid;
end

centroid = new_centroid;
