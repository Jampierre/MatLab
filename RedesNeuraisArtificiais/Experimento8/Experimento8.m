% Problema XOR
clc;
n = [2,2,1]; %entradas,n neuronios camada escondida,saidas
x = [0,1,0,1; %x1
    0,0,1,1]; %x2
yd = [0,1,1,0];
lp = [1,0];%taxa de aprendizagem, valor de atualização dos pesos
T = 1000; %numero de epocas de treinamento

%W = ann_FF_init(n)
%W = ann_FF_online(x,yd,n,W,lp,T)
%y = ann_FF_run(x,n,W);

%funções semelhanres no matlab
%feedforwardnet %criar a rede neural
%configure %para modificiar algum paramentro da rna
%train % para treinar a rede
%sim %  pa
%perform % para calcular o desempenho da rede (qtd de acertos)
plot(x);
W = feedforwardnet(n);
W = train(W,x,yd);
view(W)

%usar a função plotadc2d
%plotar o erro medio quadratico durante o treinamento 


%depois modificar a linha 11
% E = [];
%for i=1:T
%   W = ann_FF_online(x,yd,n,W,lp,i)
%   y = ann_FF_run(x,n,W);
%   erro2 = sum((yd-y).^2);
%   E = [E erro2];
%end
%plot(E);