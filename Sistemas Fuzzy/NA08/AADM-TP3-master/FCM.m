function result = FCM(data,param)
% FCM.m
% AADM-1112
%
% Eduardo Duarte no. 38900
% Fernando Alexandre no. 36812
% Ricardo Martins no. 26315
%
% 11-06-2012

%data normalization
X=data.X;

f0=param.c;
%checking the parameters given
%default parameters
if exist('param.m')==1, m = param.m;else m = 2;end; % FUZZEHNESS
if exist('param.e')==1, e = param.e;else e = 1e-4;end; % DEFAULT É BOM TAMBÉM

[N,n] = size(X);
X1 = ones(N,1);

% Initialize fuzzy partition matrix
c = f0;
v = param.p;

for j = 1 : c
  xv = X - X1*v(j,:);
  d(:,j) = sum((xv*eye(n).*xv),2);
end

d = (d+1e-10).^(-1/(m-1));
f0 = (d ./ (sum(d,2)*ones(1,c)));

c = size(f0,2);
fm = f0.^m; sumf = sum(fm);

f = zeros(N,c);                % partition matrix
iter = 0;                       % iteration counter

% Iterate
while  max(max(f0-f)) > e
  iter = iter + 1;
  f = f0;
  % Calculate centers
  fm = f.^m;
  sumf = sum(fm);
  v = (fm'*X)./(sumf'*ones(1,n));
  for j = 1 : c,
    xv = X - X1*v(j,:);
    d(:,j) = sum((xv*eye(n).*xv),2);
  end;
  distout=sqrt(d);
  J(iter) = sum(sum(f0.*d));
  % Update f0
  d = (d+1e-10).^(-1/(m-1));
  f0 = (d ./ (sum(d,2)*ones(1,c)));
end

fm = f.^m; 
sumf = sum(fm);

result.data.f=f0;
result.data.d=distout;
result.cluster.v=v;
result.iter = iter;
result.cost = J;
