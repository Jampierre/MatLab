clear all
close all
clc

%Estação Meteorologica de Viçosa (19/12/2016 a 18/12/2017
load dados_vicosa.mat
dados = table2array(dadosvicosa(:,3:end));

%Estaçnao Meteorologica de Governador Valadres (21/01/2017 a 20/01/2018)
%load dados_governador_valadares.mat
%dados = table2array(dadosgv(:,3:end));

[l c] = size(dados);
aux = 1;
%Viçosa = -16; GV = -23
for i=1:24:l-16
    x(aux,1) = median(dados(i:aux*24,1));
    x(aux,2) = median(dados(i:aux*24,2));
    x(aux,3) = median(dados(i:aux*24,3));
    x(aux,4) = median(dados(i:aux*24,4));
    x(aux,5) = median(dados(i:aux*24,5));
    %x(aux,6) = median(dados(i:aux*24,6));
    x(aux,7) = median(dados(i:aux*24,7));
    %x(aux,8) = median(dados(i:aux*24,8));
    x(aux,9) = sum(dados(i:aux*24,end));
    aux = aux + 1;
end

%(1)temp, (2)umid(not), (3)orvalho, (4)pressao, (5)vento direcao, (6)vento velocidade(not), (7)vento
%rajada, (8)radiacao(not), (9)pressipitação.
figure(1);
plot(x(1:20,1:7), 'x-');
title('Dados Estação Meteorologica - Viçosa(19/12/2016 a 19/12/2017)')
xlabel('Dias');
legend('Temperatura','Umidade','Orvalho','Pressão','Vento Direção','Vento Rajada');

figure(2);
plot(x(8:28,end), 'x-');
title('Precipitação de chuva(19/12/2016 a 19/12/2017)')
xlabel('Dias');
ylabel('(mm)');