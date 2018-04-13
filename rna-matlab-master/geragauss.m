% nc = tipo escalar que identifica  o número total de classes
% npc = vetor linha com quantidade de amostras para cada classe de dados
% mc = matriz (2 x nc) com o valor médio de cada dimensão para cada classe
% varc = matriz (2 x nc) com a variância de cada dimensão para cada classe
% X = matriz (2 x t) com as amostras (por coluna) de todas as classes
% X = [ x11 x12 x13 x14 ... x1t
%       x21 x22 x23 x24 ... x2t ]
% t = total do número de amostras
% C = vetor linha (1 x npt) com a classificação das amostras de x, variando de 0 até nc-1
%          C = [c1  c2  c3  c4  ... ct ] onde: 0 <= ci < N
%

function [X, C] = geragauss( nc, npc, mc, varc )
    X = [];
    C = [];
    for i=1:nc
        nova_matriz_x = (randn(1, npc(i)) + mc(1, i)) * varc(1, i);
        nova_matriz_y = (randn(1, npc(i)) + mc(2, i)) * varc(2, i);
        novo_vetor_c  = zeros(1, npc(i)) + (i-1);
        
        nova_matriz = [nova_matriz_x; nova_matriz_y];
        X = horzcat(X, nova_matriz);
        C = horzcat(C, novo_vetor_c);
    end
end

