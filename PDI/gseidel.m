%-----------------------------------------------------------------------
%              --------------                       -------
%              function  file                       gseidel
%              --------------                       -------
%-----------------------------------------------------------------------
%                         ----------------------
%                         Metodo de Gauss-Seidel
%-----------------------------------------------
%
%                         Sistema Linear   Ax = b
%------------------------------------------------
%
%
%       Chamada do Procedimento  gseidel
%---------------------------------------
%       function  [x,iter,erro] = gseidel(A,b,xo,epsilon,limax)
%
%
%       Variaveis de Entrada
%---------------------------
%       epsilon         : precisao desejada
%       limax           : numero maximo de iteracoes
%       A               : Matriz do Sistema Linear
%       b               : Vetor do Lado Direito do Sistema Linear
%       xo              : Aproximacao Inicial
%
%       Variaveis de Saida
%-------------------------
%       x               : Vetor Solucao do Sistema Linear
%       iter            : numero de iteracoes
%       erro            : erro absoluto 
%
%
%
        function  [x,iter,erro] = gseidel(A,b,xo,epsilon,limax)
%--------------------------------------------------------------
%
%
%       Verifica as Dimensoes da Matriz A
%----------------------------------------
        [mlin,ncol] = size(A);          
%        
        xnew = xo;
           x = xo;
        erro = 1.0;
        iter = 0;
%        
        while ( ( erro > epsilon )  &  ( iter < limax ) )
        iter = iter+1;
%
                for i = 1:mlin
%
                     soma = 0.0;
                     for j=1:(i-1)
                     soma = soma + A(i,j)*xnew(j);
                     end
%
                     for j=(i+1):ncol
                     soma = soma + A(i,j)*xnew(j);
                     end
%
                xnew(i) = ( b(i) - soma ) / A(i,i);
%
                end
%
%
%	Erro Absoluto - Norma do Maximo
%--------------------------------------
        erro = norm( abs(x - xnew), 'inf' );
	   x = xnew;
%
        end
%
%
%
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
%--------------------------------------------------
%       Petronio Pulino
%       Departamento de Matem?tica Aplicada - D.M.A
%       IMECC - UNICAMP
%       e-mail: pulino@ime.unicamp.br
%       http://www.ime.unicamp.br/~pulino/MS211/
%--------------------------------------------------