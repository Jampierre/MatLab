function [cvrm, fcm_res, fcm_validation] = cross_val(data_input, f, func, max_clusters, max_contribution, threshold)
% cross_val.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 12-06-2012

% f = number of folds
% k = number of cluster 
% iter = number of iteration for FCM
% func = 0 -> FCM ; 1 -> AP_FCM
%

if( isfield(data_input,'X') ~= 1 )
    data_input.X = data_input;
end

if nargin<3
    f = 10;
    func = 1;
end

if nargin<5
    max_clusters = 3;
    max_contribution = 1;
    threshold = 1;
end

[rows,cols] = size(data_input.X);

% Split data into f sets
for i=1:f
    fset(i).values = data_input.X((1 + round(rows * (i - 1) / f)) : round((rows * i ) / f), :);
end

% P(S,C)
if func == 1
    P = AP_FCM(data_input, max_clusters, max_contribution, threshold);
else
    P = run_FCM(data_input, max_clusters, 10);
end

% Run 1 set as test and rest as training
for i=1:f
    %test = fset(i).values;
    training = [];
    for j=1:f
        if j ~= i
            training = [training; fset(j).values];
        end
    end
    
    training_data.X = training;

    if func == 1
        Pv(i) = AP_FCM(training_data, max_clusters, max_contribution, threshold);
    else
        Pv(i) = run_FCM(training_data);
    end
    
    score(i) = score_fun(P, Pv(i));
end

[V, I] = min(score);
cvrm = V / f;
P.error_rate = sum(score) / f;
fcm_res = P;
fcm_validation = Pv(I);
