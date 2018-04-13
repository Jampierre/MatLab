function [ A,b ] = triangularizacao( A,b )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n = length(A);
    for p = 1:n-1
        for i = p+1:n
            M = A(i,p)/A(p,p);
            for j = p:n
                A(i,j) = A(i,j)-M*A(p,j);
            end
            b(i) = b(i)-M*b(p);
        end
    end

end

%Depois de fazer a triangulariza??o, para chegar na solu??o do sistema ?
%preciso rodar a tri_sup.
%Montar a Triangular Superior
