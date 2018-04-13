function [xp,cp] = geragauss(nc,npc, mc, varc)
%Autor: Jampierre V. Rocha
%Disciplina: Introdução a Redes Neurais Artificiais
%MATBLA R2017b      09/11/2017

%SAIDA
%Matrix xp vai ter qualquer numero de linhas e colunas onde cada linha
%identifia uma variavel e cada coluna uma nova amostra
%xp so vai ter 2 linhas (x1 e x2) ( Esse seria o Xin)

%cp retorna um vetor de classificação ( esse seria o Yin utilizado no
%resultado esperado pelo perceptron
%cp problemas sera classificados em ate 10 classes [0..9]

%ENTRADA
%nc é o numero de classes que vc quer gerar
%npc É um vetor linha com a quantidade de amostras por classes. Ex:. v[100
%200] a classe q tem 100 amostras e a classe dois tem 200 amostras
%mc 
%varc variação ou esperção dos dados
xp = [];
cp = [];
for i=1:nc
    nova_matriz_x = (randn(1, npc(i)) + mc(1, i)) * varc(1, i);
    nova_matriz_y = (randn(1, npc(i)) + mc(2, i)) * varc(2, i);
    novo_vetor_cp  = zeros(1, npc(i)) + (i-1);

    nova_matriz = [nova_matriz_x; nova_matriz_y];
    xp = horzcat(xp, nova_matriz);
    cp = horzcat(cp, novo_vetor_cp);
end

end