function [Yd] = converte_dec_bin(C)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b       15/12/2017
Yd = [];
classes = unique(C);

for x= 0 : length(classes)-1
    for y=1: length(C)
        Yd(x+1, y) = (x == C(y));
    end
end
end