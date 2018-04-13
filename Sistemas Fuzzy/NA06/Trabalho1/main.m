function varargout = main(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

initialize_gui(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Inicializa a GUI
function initialize_gui(fig_handle, handles)
handles.metricdata.x = 0;
handles.metricdata.y = 0;
handles.metricdata.f = 0;

set(handles.x, 'String', handles.metricdata.x);
set(handles.y, 'String', handles.metricdata.y);
set(handles.f, 'String', handles.metricdata.f);
set(handles.xOut, 'String', 0);
set(handles.yOut, 'String', 0);
set(handles.fOut, 'String', 0);
set(handles.qOut, 'String', 0);

% Update handles structure
guidata(handles.figure1, handles);

% Desenha o 'carro' na posi�ao passada como par�metro
function drawCar(x,y)
tam = 5
rectangle('Position',[x-tam/2,y-tam/2,tam,tam],'FaceColor','b')
drawnow

% --- Executes on button press in starbutton.
% Inicia a simulacao do sistema Fuzzy tendo como os parametro iniciais
%passados como parametro
function starbutton_Callback(hObject, eventdata, handles)
% hObject    handle to starbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(gcf,'CurrentAxes', handles.grade)
% Desenha a arena onde o caminhao ir� percorrer
rectangle('Position',[0,0,100,100],'FaceColor','w')
rectangle('Position',[49,95,2,5],'FaceColor','r')
daspect([1 1 1])

x = handles.metricdata.x %posicao X inicial
y = handles.metricdata.y %posicao Y inicial
f = handles.metricdata.f %angulo inicial
q = 0;                  %angulo do volante
r = 2;                  %variacao
sleepTime = 0.1         %tempo de pausa entre as intera��es

sisFuzzy = readfis('FuzzyController.fis')

while (((x<49)||(x>51))||((y<99)||(y>101)))
    if (y > 100)
        break
    end
    [q] = evalfis([x f],sisFuzzy)
    x = x + r*cos(f*pi/180)
    y = y + r*sin(f*pi/180)
    f = mod(f - q,360)
    set(handles.xOut, 'String', x)
    set(handles.yOut, 'String', y)
    set(handles.qOut, 'String', q)
    set(handles.fOut, 'String', f);
    drawCar(x,y)
    pause(sleepTime)
end

function x_Callback(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = str2double(get(hObject,'String'))
if ((x>=0)&&(x<=100))
    handles.metricdata.x = x;
    guidata(hObject,handles)
else
    handles.metricdata.x = 0;
    set(handles.x, 'String', handles.metricdata.x);
end

function y_Callback(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y = str2double(get(hObject,'String'))
if ((y>=0)&&(y<=100))
    handles.metricdata.y = y;
    guidata(hObject,handles)
else
    handles.metricdata.y = 0;
    set(handles.y, 'String', handles.metricdata.y);
end

function f_Callback(hObject, eventdata, handles)
% hObject    handle to f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = str2double(get(hObject,'String'))
if ((f>=0)&&(f<=360))
    handles.metricdata.f = f;
    guidata(hObject,handles)
else
    handles.metricdata.f = 0;
    set(handles.f, 'String', handles.metricdata.f);
end


% --- Executes during object creation, after setting all properties.
function y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes during object creation, after setting all properties.
function x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla (handles.grade)




function xOut_Callback(hObject, eventdata, handles)
% hObject    handle to xOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xOut as text
%        str2double(get(hObject,'String')) returns contents of xOut as a double


% --- Executes during object creation, after setting all properties.
function xOut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function Yout_Callback(hObject, eventdata, handles)
% hObject    handle to Yout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yout as text
%        str2double(get(hObject,'String')) returns contents of Yout as a double


% --- Executes during object creation, after setting all properties.
function Yout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function yOut_Callback(hObject, eventdata, handles)
% hObject    handle to yOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yOut as text
%        str2double(get(hObject,'String')) returns contents of yOut as a double


% --- Executes during object creation, after setting all properties.
function yOut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

function fOut_Callback(hObject, eventdata, handles)
% hObject    handle to fOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fOut as text
%        str2double(get(hObject,'String')) returns contents of fOut as a double


% --- Executes during object creation, after setting all properties.
function fOut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


