function [Watual,bAtual,Erroepocas] = treina_adaline_m(Watual, bAtual, Xin, Yin, alfa, maxepocas, tol, B)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      23/11/2017

Wantigo = Watual;
bAntigo = bAtual;    
t = 1;
Erroepocas = [];
[ln cl] = size(Xin);
while (t < maxepocas) && (tol > 0)
    seg = 0;
    for i=1:cl
        y = yadaline(Xin(:,i),Watual,bAtual);
        e = Yin(i) - y;
        Wnovo = Watual + alfa * e * Xin(:,i)' + B * (Watual - Wantigo);
        bNovo = bAtual + alfa * e + B * (bAtual - bAntigo);
        seg = seg + e.^2;
        Wantigo = Watual;
        Watual = Wnovo;
        bAntigo = bAtual;
        bAtual = bNovo;
    end
    Erroepocas = [Erroepocas seg];
    t = t + 1;
end

end