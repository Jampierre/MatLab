% b1 = coeficiente angular
% b0 = coeficiente linear
% d = ajuste, desvio ou res?duo
function [ b0, b1, d ] = MinimosQuadrados( x, y )

    matriz_coeficientes = [length(x) sum(x); sum(x) sum(x.^2)];
    matriz_independetes = [sum(y); sum(x.*y)];
    
    param = EliminacaoGauss(matriz_coeficientes, matriz_independetes);
    %b0 = roundn(param(1), -1);
    %b1 = roundn(param(2), -1);
    
    b0 = 0;
    b1 = 0;
    
    d = sum((y - (b0 + b1.*x)).^2);
    
end

