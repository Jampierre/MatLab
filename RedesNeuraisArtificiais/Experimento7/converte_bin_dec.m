function [C] = converte_bin_dec(Yd)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b       15/12/2017
C = zeros(1,size(Yd,2)); 
for x=1:size(Yd,1)
   for y=1:size(Yd,2)
       if (Yd(x,y) == 1)
           C(y) = x-1;
       end
   end
end
end