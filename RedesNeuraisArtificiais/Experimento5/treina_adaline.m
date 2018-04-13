function [W,b,Erroepocas] = treina_adaline(W, b, Xin, Yin, alfa, maxepocas, tol)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      16/11/2017
%editado    
t = 1;
Erroepocas = [];
[ln cl] = size(Xin);
while (t < maxepocas) && (tol > 0)
    seg = 0;
    for i=1:cl
        y = yadaline(Xin(:,i),W,b);
        e = Yin(i) - y;
        W = W + alfa * e * Xin(:,i)';
        b = b + alfa * e ;
        seg = seg + e.^2;
    end
    Erroepocas = [Erroepocas seg];
    t = t + 1;
end

end