clc;
clear;
close all;

load dados_vicosa.mat

dados = table2array(dadosvicosa(:,3:end));
[l c] = size(dados);
aux = 1;
%Viçosa = -16; GV = -23
for i=1:24:l-16
    x(aux,1) = median(dados(i:aux*24,1));
    x(aux,2) = median(dados(i:aux*24,2));
    x(aux,3) = median(dados(i:aux*24,3));
    x(aux,4) = median(dados(i:aux*24,4));
    x(aux,5) = median(dados(i:aux*24,5));
    x(aux,6) = median(dados(i:aux*24,6));
    x(aux,7) = median(dados(i:aux*24,7));
    x(aux,8) = median(dados(i:aux*24,8));
    x(aux,9) = sum(dados(i:aux*24,end));
    aux = aux + 1;
end
%(1)temp, (2)umid(not), (3)orvalho, (4)pressao, (5)vento direcao, (6)vento velocidade(not), (7)vento
%rajada, (8)radiacao(not), (9)precipitação.


[l c] = size(x);
%janela de 7 dias para prever o 8
for t=7:l-1
    Data(t-6,:)=[x(t-6,1) x(t-5,1) x(t-4,1) x(t-3,1) x(t-2,1) x(t-1,1) x(t,1) ...
        x(t-6,2) x(t-5,2) x(t-4,2) x(t-3,2) x(t-2,2) x(t-1,2) x(t,2) ...
        x(t-6,3) x(t-5,3) x(t-4,3) x(t-3,3) x(t-2,3) x(t-1,3) x(t,3) ...
        x(t-6,4) x(t-5,4) x(t-4,4) x(t-3,4) x(t-2,4) x(t-1,4) x(t,4) ...
        x(t-6,5) x(t-5,5) x(t-4,5) x(t-3,5) x(t-2,5) x(t-1,5) x(t,5) ...
        x(t-6,6) x(t-5,6) x(t-4,6) x(t-3,6) x(t-2,6) x(t-1,6) x(t,6) ...
        x(t-6,7) x(t-5,7) x(t-4,7) x(t-3,7) x(t-2,7) x(t-1,7) x(t,7) ...
        x(t-6,8) x(t-5,8) x(t-4,8) x(t-3,8) x(t-2,8) x(t-1,8) x(t,8) ...
        x(t-6,9) x(t-5,9) x(t-4,9) x(t-3,9) x(t-2,9) x(t-1,9) x(t,9) ...
        x(t+1,9)];
      
    %x(t-6,6) x(t-5,6) x(t-4,6) x(t-3,6) x(t-2,6) x(t-1,6) x(t,6) ...
    % vento velocidade
    %x(t-6,8) x(t-5,8) x(t-4,8) x(t-3,8) x(t-2,8) x(t-1,8) x(t,8) ...
    %...Radiação
end

correlacao = corr(Data); %corelação entre as colunhas com a saida
correlacao(correlacao == 1) = 0;
correlacao = max(abs(correlacao));

aux = 1;
for i=1:7:63
    y(1,aux) = median(correlacao(1,i:aux*7));
    aux = aux + 1;
end