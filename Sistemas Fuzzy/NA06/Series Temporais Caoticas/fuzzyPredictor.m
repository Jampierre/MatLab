%clear all; clc; close all; 

load DataSet.mat

%for i=1:size(X,1)
%    Xnorm(i,:) = (X(i,:)-min(X))./(max(X)-min(X));
%    Ynorm(i) = (Y(i)-min(Y))./(max(Y)-min(Y));
%end

%Yest = evalfis(Xnorm',readfis('FPredictor.fis'));

%RMSE = sqrt(sum((1/size(Y,1))*(Ynorm' - Yest).^2))

%figure(1);
%plot(Ynorm,'k'), hold on
%plot(Yest,'r')




abs_Xnorm = abs(X);
minimoX = min(min(abs_Xnorm));
maximoX = max(max(abs_Xnorm));
abs_Xnorm = abs_Xnorm - minimoX;
abs_Xnorm = abs_Xnorm/(maximoX-minimoX);

abs_Ynorm = abs(Y);
minimoY = min(min(abs_Ynorm));
maximoY = max(max(abs_Ynorm));
abs_Ynorm = abs_Ynorm - minimoY;
abs_Ynorm = abs_Ynorm/(maximoY-minimoY);

sysfuzzy = readfis('FPredictor2.fis');

Theta = [ones(size(abs_Xnorm,1),1) abs_Xnorm]\abs_Ynorm;
aux = Theta(1); Theta(1) = [] ; Theta(5) = aux;
sysfuzzy.output(1).mf(1).params = Theta';
sysfuzzy.output(1).mf(2).params = Theta';
sysfuzzy.output(1).mf(3).params = Theta';

writefis(sysfuzzy,'FPredictor2.fis');

Yest1 = evalfis(abs_Xnorm',sysfuzzy);

RMSE2 = sqrt(sum((1/size(Y,1))*(abs_Ynorm - Yest1).^2))

figure(1);
plot(abs_Ynorm,'k'), hold on
plot(Yest1,'r')