%-----------------------------------------------------------------------
%             -------------                             --------
%             function file                             choles.m
%             -------------                             --------
%-----------------------------------------------------------------------
%
%       ----------------------------------
%       Metodo de Decomposicao de Cholesky
%-----------------------------------------
%
%       Dada uma matriz  A,  de ordem n, simetrica e positiva-definida
%       existe uma unica matriz  G  triangular superior com  todos  os
%       elementos da diagonal principal positivos tal que   A = G'G.
%
%
%       Chamada do procedimento choles
%-------------------------------------
%       [G]  = choles(A)
%
%
%       Variaveis de Entrada
%---------------------------
%
%       A : Matriz real de ordem  n  simetrica e positiva-definida
%
%       Variaveis de Saida
%-------------------------
%
%       G : Matriz real de ordem  n  triangular superior 
%           fator de Cholesky  da matriz  A
%
%
        function [G] = choles(A)
%-------------------------------
%
%
%
%       ----------------------------------
%       Metodo de Decomposicao de Cholesky
%-----------------------------------------
%
%
%
%       Dimensoes da Matriz A
%----------------------------
        [mlin,ncol] = size(A);
%
%
        for i = 1:mlin
%
                soma = 0.0;
                for k = 1:(i-1)
                soma = soma + G(k,i)*G(k,i);
                end
%
%
                delta = A(i,i) - soma;
                G(i,i) = sqrt(delta);
%
%
                        for j = (i+1):ncol
                        soma = 0.0;
                        for k = 1:(i-1)
                        soma = soma + G(k,i)*G(k,j);
                        end
%
%
                        G(i,j) = ( A(i,j) - soma ) / G(i,i);
%
                        end
        end
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
%--------------------------------------------------
%       Petronio Pulino
%       Departamento de Matematica Aplicada - D.M.A
%       IMECC - UNICAMP
%       e-mail: pulino@ime.unicamp.br
%       http://www.ime.unicamp.br/~pulino/MS211
%--------------------------------------------------
