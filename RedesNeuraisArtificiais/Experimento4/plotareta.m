function [] = plotareta(W,b,intervalo)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      31/10/2017


Xreta= intervalo;
Yreta = -W(1)* Xreta/W(2)-b/W(2);
plot(Xreta,Yreta)
end