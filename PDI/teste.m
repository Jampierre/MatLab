function [ M ] = teste( A,b )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

n = length(A);

%Matriz estendida
M(1:n, 1:2*n+1)=0;
M(1:n,1:n)=A;
M(1:n,n+1:2*n)=eye(n,n);
M(1:n,2*n+1)=b;

%inicio  da pivota??o
for i =  1:n
    % pos -> possi??o do valor na matrix
    % pivot -> maior valor absoluto
    [pivot,pos]  = max(abs(M(i:end,i))); % determina o maior valor das linhas a baixo da coluna i
    pos = pos + (i-1);
    pivot = M(pos,i);
    M([i,pos],:) = M([pos,i],:); % troca de linha por i
    for j=i+1:n
        M(j,:) = M(j,:)-M(i,:)*(M(j,i)/pivot);
    end
    for j=1:i-1
        M(j,:) = M(j,:)-M(i,:)*(M(j,i)/pivot);
    end
    M(i,:)=M(i,:)/pivot;    
end

