function varargout = Cins_Regress(varargin)
% Link: https://www.mathworks.com/matlabcentral/fileexchange/53293-simple-linear-regression-
%       code-with-simple-gui-support
% CINS_REGRESS c?digo MATLAB para Cins_Regress.fig
% CINS_REGRESS, por si s?, cria um novo CINS_REGRESS ou aumenta o singleton existente *.
%
% H = CINS_REGRESS retorna o identificador para um novo CINS_REGRESS ou o 
% identificador para o singleton * existente.
%
% CINS_REGRESS ( 'CALLBACK', hObject, eventData, handles, ...) chama o local
% Nomeado CALLBACK em CINS_REGRESS.M com os argumentos de entrada fornecidos.
%
%      CINS_REGRESS('Property','Value',...) cria um novo CINS_REGRESS ou 
%       aumenta o singleton existente *. Partindo da esquerda, pares de 
%       valor de propriedade s?o aplicados ? GUI antes de Cins_Regress_OpeningFcn 
%       ser chamado. Um nome de propriedade n?o reconhecido ou valor inv?lido 
%       torna a aplica??o de propriedade parar. Todas as entradas s?o passadas 
%       para Cins_Regress_OpeningFcn via varargin.
%
%      *Consulte Op??es GUI no menu Ferramentas do GUIA. Escolha "GUI allows only one
%      instance to run (singleton)".s
%
% Consulte tamb?m: GUIDE, GUIDATA, GUIHANDLES

% Edite o texto acima para modificar a resposta para ajudar Cins_Regress

% ?ltima modifica??o por GUIDE v2.5 09-Sep-2015 00:24:08

% Come?ar o c?digo de inicializa??o - N?O EDITAR

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cins_Regress_OpeningFcn, ...
                   'gui_OutputFcn',  @Cins_Regress_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% C?digo de inicializa??o final - N?O EDITAR


% --- Executar imediatamente antes Cins_Regress ? tornado vis?vel.
function Cins_Regress_OpeningFcn(hObject, eventdata, handles, varargin)
% Esta fun??o n?o tem args de sa?da, consulte OutputFcn.
% hObject    al?a para figura
% eventdata  reservado - a ser definido em uma vers?o futura do MATLAB
% handles    estrutura com al?as e dados do usu?rio (consulte GUIDATA)
% varargin   argumentos de linha de comando para Cins_Regress (consulte VARARGIN)

% Escolha sa?da de linha de comando padr?o para Cins_Regress
handles.output = hObject;

% Atualizar estrutura de handles
guidata(hObject, handles);

% UIWAIT faz com que Cins_Regress aguarde a resposta do usu?rio (veja UIRESUME)
% uiwait(handles.figure1);


% --- Sa?das desta fun??o s?o retornadas para a linha de comando.
function varargout = Cins_Regress_OutputFcn(hObject, eventdata, handles) 
% varargout  matriz de c?lulas para devolver args de sa?da (ver VARARGOUT);
% hObject    lidar com a figura
% eventdata  reservado - a ser definido em uma vers?o futura do MATLAB
% handles    estrutura com al?as e dados do usu?rio (consulte GUIDATA)

% Obter sa?da de linha de comando padr?o da estrutura de al?as
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    Manipular para editar1 (ver GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Estrutura com al?as e dados do usu?rio (consulte GUIDATA)
handles.min_x_axis = str2num(get(hObject,'String'))
guidata(hObject, handles);
% sugest?es: get(hObject,'String') retorna o conte?do de edit1 como texto
%        str2double(get(hObject,'String')) Retorna o conte?do de edit1 como
%        um double


% --- Executa durante a cria??o do objeto, ap?s definir todas as propriedades.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    Manipular para editar1 (ver GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Vazio - al?as n?o criadas at? depois de tudo CreateFcns chamado

% Dica: os controles de edi??o geralmente t?m um fundo branco no Windows.
%       Consulte ISPC e COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    Identificador para editar2 (consulte GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Estrutura com al?as e dados do usu?rio (consulte GUIDATA)

handles.max_x_axis = str2num(get(hObject,'String'))
guidata(hObject, handles);
% sugest?es: get(hObject,'String') Retorna o conte?do de edit2 como texto
%        str2double(get(hObject,'String')) Retorna o conte?do de edit2 como
%        um double



% --- Executa durante a cria??o do objeto, ap?s definir todas as propriedades.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    Identificador para editar2 (consulte GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Vazio - al?as n?o criadas at? depois de tudo CreateFcns chamado

% Dica: os controles de edi??o geralmente t?m um fundo branco no Windows.
%       Consulte ISPC e COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    Identificador para editar3 (veja GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Estrutura com al?as e dados do usu?rio (consulte GUIDATA)


handles.min_y_axis = str2num(get(hObject,'String'))
guidata(hObject, handles);
% sugest?es: get(hObject,'String') Retorna o conte?do de edit3 como texto
%        str2double(get(hObject,'String')) Retorna o conte?do de edit3 como
%        um double


% --- Executa durante a cria??o do objeto, ap?s definir todas as propriedades.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    Identificador para editar3 (veja GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Vazio - al?as n?o criadas at? depois de tudo CreateFcns chamado

% Dica: os controles de edi??o geralmente t?m um fundo branco no Windows.
%       Consulte ISPC e COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    Para editar4 (veja GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Estrutura com al?as e dados do usu?rio (consulte GUIDATA)

handles.max_y_axis = str2num(get(hObject,'String'))
guidata(hObject, handles);
% sugest?es: get(hObject,'String') Retorna o conte?do de edit4 como texto
%        str2double(get(hObject,'String')) Retorna o conte?do de edit4 como
%        um double


% --- Executa durante a cria??o do objeto, ap?s definir todas as propriedades.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    Para editar4 (veja GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Vazio - al?as n?o criadas at? depois de tudo CreateFcns chamado

% Dica: os controles de edi??o geralmente t?m um fundo branco no Windows.
%       Consulte ISPC e COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  Reservado - a ser definido em uma vers?o futura do MATLAB
% handles    Estrutura com al?as e dados do usu?rio (consulte GUIDATA)

[handles.min_x_axis handles.max_x_axis handles.min_y_axis handles.max_y_axis]

axis([handles.min_x_axis handles.max_x_axis handles.min_y_axis handles.max_y_axis]);


hold on
% Loop, pegando os pontos.
disp('Left mouse button picks points.')
disp('Right mouse button picks last point.')
but = 1;
n=0;
xy=[];
while but == 1
    [xi,yi,but] = ginput(1);
    plot(xi,yi,'r+');
    n=n+1;
    xy = [xy;[xi yi]];
end
handles.x=xy(:,1);
handles.y=xy(:,2); 
guidata(hObject,handles);
hold off


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% pushbutton1_Callback'te k?rm?z? ile ?izdirmeden ?nce buradan topluca ?izim
% yap?yorduk. Gerek kalmad?. Console'a output olarak tum (x,y) ikililerini
% yazdirabiliriz.

% hold on
%    scatter(handles.x, handles.y);  // Handles.x ve Handles.y girilen
%    koordinatlari tasimaktadir.
% hold off

 
 %% Plotting the simple linear regression line
 theta = [handles.x ones(size(handles.x))]\handles.y ;
 
 % y = b1*x + b0;
 % theta(1,1) ==> b1 g?sterilmektedir.  theta(2,1) ==> b0 g?r?lmektedir.
 
 reg_y = theta(1,1)*handles.x + repmat(theta(2,1), [length(handles.x) 1]);
 hold on
 plot(handles.x,reg_y);
 hold off
 
 
 
 
 
 
 
