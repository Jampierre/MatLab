clear
clc

%x = [0.3 2.7 4.5 5.9 7.8];
%y = [1.8 1.9 3.1 3.9 3.3];

meses = [0 1 2 3 4 5 6];
vendas = [2000 1200 1800 2100 2200 2150 2500];

[b0, b1, desvio] = MinimosQuadrados(meses,vendas)

%para calcular as vendas para mês de agosto basta aplicar os parametros na
%equação da reta

vendas_agosto = b0 + b1*7