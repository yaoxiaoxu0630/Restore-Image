function varargout = Image_processing2(varargin)
% IMAGE_PROCESSING2 M-file for Image_processing2.fig
%      IMAGE_PROCESSING2, by itself, creates a new IMAGE_PROCESSING2 or raises the existing
%      singleton*.
%
%      H = IMAGE_PROCESSING2 returns the handle to a new IMAGE_PROCESSING2 or the handle to
%      the existing singleton*.
%
%      IMAGE_PROCESSING2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_PROCESSING2.M with the given input arguments.
%
%      IMAGE_PROCESSING2('Property','Value',...) creates a new IMAGE_PROCESSING2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_processing2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_processing2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_processing2

% Last Modified by GUIDE v2.5 12-Sep-2009 01:32:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_processing2_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_processing2_OutputFcn, ...
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


% --- Executes just before Image_processing2 is made visible.
function Image_processing2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_processing2 (see VARARGIN)

% Choose default command line output for Image_processing2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_processing2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_processing2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
clc
theta=str2double(get(handles.edit10,'string'));
len=str2double(get(handles.edit9,'string'));
if isnan(len) |len>25
    len=7;
end
if isnan(theta) |theta>360
    theta=0;
end
if len<=2 
    len=3;
end
if mod(len,2)==0
    len=len-1;
end
 set(handles.edit9,'string',len);
 set(handles.edit10,'string',theta);
if get(handles.sel_image,'value')==1
bc=imread('D:\Project_M_B\image2\cameraman.tif');
b=im2uint8(bc);
m=fspecial('motion',len,0);
mm=fspecial('motion',len,theta);
bmm=imfilter(b,mm,'circular');
bm=imfilter(b,m,'circular');
axes(handles.axes6);
imshow(b,'DisplayRange',[]);
axes(handles.axes7);
imshow(bm,'DisplayRange',[]);
m2=zeros(256,256);
m2(1,1:len)=m;
mf=fft2(m2);
bmi=ifft2(fft2(bm)./mf);
fa=abs(bmi);
fm=max(fa(:));
d=0.02;
mf=fft2(m2);mf(find(abs(mf)<d))=1;
bmi=ifft2(fft2(bm)./mf);
axes(handles.axes8);
imshow(mat2gray(abs(bmi))*2)
 %-----------------------------------------
 %-----------------------------------------
fr=deconvwnr(bmm,mm);
axes(handles.axes9);
imshow(fr,'DisplayRange',[]);
end


if get(handles.sel_image,'value')==2
bc=imread('D:\Project_M_B\image2\children.tif');
b=im2uint8(bc);
m=fspecial('motion',len,0);
mm=fspecial('motion',len,theta);
bmm=imfilter(b,mm,'circular');
bm=imfilter(b,m,'circular');
axes(handles.axes6);
imshow(b,'DisplayRange',[]);
axes(handles.axes7);
imshow(bm,'DisplayRange',[]);
m2=zeros(256,256);
m2(1,1:len)=m;
mf=fft2(m2);
bmi=ifft2(fft2(bm)./mf);
fa=abs(bmi);
fm=max(fa(:));
d=0.02;
mf=fft2(m2);mf(find(abs(mf)<d))=1;
bmi=ifft2(fft2(bm)./mf);
axes(handles.axes8);
imshow(mat2gray(abs(bmi))*2)
 %-----------------------------------------
 %-----------------------------------------
fr=deconvwnr(bmm,mm);
axes(handles.axes9);
imshow(fr,'DisplayRange',[]);
end



if get(handles.sel_image,'value')==3
bc=imread('D:\Project_M_B\image2\satellite image of Florida.tif');
b=im2uint8(bc);
m=fspecial('motion',len,0);
mm=fspecial('motion',len,theta);
bmm=imfilter(b,mm,'circular');
bm=imfilter(b,m,'circular');
axes(handles.axes6);
imshow(b,'DisplayRange',[]);
axes(handles.axes7);
imshow(bm,'DisplayRange',[]);
m2=zeros(256,256);
m2(1,1:len)=m;
mf=fft2(m2);
bmi=ifft2(fft2(bm)./mf);
fa=abs(bmi);
fm=max(fa(:));
d=0.02;
mf=fft2(m2);mf(find(abs(mf)<d))=1;
bmi=ifft2(fft2(bm)./mf);
axes(handles.axes8);
imshow(mat2gray(abs(bmi))*2)
 %-----------------------------------------
 %-----------------------------------------
fr=deconvwnr(bmm,mm);
axes(handles.axes9);
imshow(fr,'DisplayRange',[]);
end




% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
if get(handles.sel_image,'value')==1
f=imread('D:\Project_M_B\image2\ray_traced_bottle.tif');
s=size(f);
[x y]=meshgrid(1:s(1),1:s(2));
mid1=s(1)/2;
p=4+sin(x+y/1.5);
tp=(double(f)/mid1+p)/10;
axes(handles.axes1);
imshow(f,'DisplayRange',[]);
axes(handles.axes2);
imshow(tp,'DisplayRange',[]);
F = fft2(tp);
Fc = fftshift(F);
Sc = log(1+abs(Fc));
axes(handles.axes3);
imshow(Sc,'DisplayRange',[]);
axes(handles.axes5);
[co,ro] = size(f);
    cx = round(co/2)+1;
    cy = round (ro/2)+1;
if get(handles.sel_filt1,'value')==1
    
br=ones(co,ro);
d=zeros(co,ro);
d= sqrt((x-cx).^2 + (y-cy).^ 2);
br=(d< 22 | d > 26);
outf = Fc .* br;
out =real(abs(ifft2(outf)));
axes(handles.axes4);
imshow(log(1+abs(outf)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
 end
 if get(handles.sel_filt1,'value')==2
Fc(79,:)=0;
Fc(51,:)=0;
Fc(:,85)=0;
Fc(:,45)=0;
Fc(78,:)=0;
Fc(50,:)=0;
Fc(:,84)=0;
Fc(:,44)=0;
Fc(80,:)=0;
Fc(52,:)=0;
Fc(:,86)=0;
Fc(:,46)=0;
out =real(abs(ifft2(Fc)));
axes(handles.axes4);
imshow(log(1+abs(Fc)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
  end
end


if get(handles.sel_image,'value')==2
f=imread('D:\Project_M_B\image2\children.tif');
s=size(f);
[x y]=meshgrid(1:s(1),1:s(2));
mid1=s(1)/2;
p=4+sin(x+y/1.5);
tp=(double(f)/mid1+p)/10;
axes(handles.axes1);
imshow(f,'DisplayRange',[]);
axes(handles.axes2);
imshow(tp,'DisplayRange',[]);
F = fft2(tp);
Fc = fftshift(F);
Sc = log(1+abs(Fc));
axes(handles.axes3);
imshow(Sc,'DisplayRange',[]);
[co,ro] = size(f);
    cx = round(co/2)+1; % find the center of the image
    cy = round (ro/2)+1;
    if get(handles.sel_filt1,'value')==1
br=ones(co,ro);
d=zeros(co,ro);
d= sqrt((x-cx).^2 + (y-cy).^ 2);
br=(d< 47 | d > 51);
outf = Fc .* br;
out =real(abs(ifft2(outf)));
axes(handles.axes4);
imshow(log(1+abs(outf)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
    end
if get(handles.sel_filt1,'value')==2
Fc(156,:)=0;
Fc(102,:)=0;
Fc(:,170)=0;
Fc(:,88)=0;
Fc(157,:)=0;
Fc(103,:)=0;
Fc(:,171)=0;
Fc(:,89)=0;
Fc(155,:)=0;
Fc(101,:)=0;
Fc(:,169)=0;
Fc(:,87)=0;
out =real(abs(ifft2(Fc)));
axes(handles.axes4);
imshow(log(1+abs(Fc)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
 end
end



if get(handles.sel_image,'value')==3
f=imread('D:\Project_M_B\image2\a.tif');
s=size(f);
[x y]=meshgrid(1:s(1),1:s(2));
mid1=s(1)/2;
p=4+sin(x+y/1.5);
tp=(double(f)/mid1+p)/10;
axes(handles.axes1);
imshow(f,'DisplayRange',[]);
axes(handles.axes2);
imshow(tp,'DisplayRange',[]);
F = fft2(tp);
Fc = fftshift(F);
Sc = log(1+abs(Fc));
axes(handles.axes3);
imshow(Sc,'DisplayRange',[]);
[co,ro] = size(f);
    cx = round(co/2)+1; % find the center of the image
    cy = round (ro/2)+1;
    if get(handles.sel_filt1,'value')==1
br=ones(co,ro);
d=zeros(co,ro);
d= sqrt((x-cx).^2 + (y-cy).^ 2);
br=(d< 93 | d > 101);
outf = Fc .* br;
out =real(abs(ifft2(outf)));
axes(handles.axes4);
imshow(log(1+abs(outf)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
    end
 if get(handles.sel_filt1,'value')==2
Fc(311,:)=0;
Fc(203,:)=0;
Fc(:,338)=0;
Fc(:,176)=0;
Fc(310,:)=0;
Fc(202,:)=0;
Fc(:,337)=0;
Fc(:,175)=0;
Fc(312,:)=0;
Fc(204,:)=0;
Fc(:,339)=0;
Fc(:,177)=0;
out =real(abs(ifft2(Fc)));
axes(handles.axes4);
imshow(log(1+abs(Fc)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
  end
end


if get(handles.sel_image,'value')==4
f=imread('D:\Project_M_B\image2\woman.tif');
s=size(f);
[x y]=meshgrid(1:s(1),1:s(2));
mid1=s(1)/2;
p=4+sin(x+y/1.5);
tp=(double(f)/mid1+p)/10;
axes(handles.axes1);
imshow(f,'DisplayRange',[]);
axes(handles.axes2);
imshow(tp,'DisplayRange',[]);
F = fft2(tp);
Fc = fftshift(F);
Sc = log(1+abs(Fc));
axes(handles.axes3);
imshow(Sc,'DisplayRange',[]);
[co,ro] = size(f);
    cx = round(co/2)+1; % find the center of the image
    cy = round (ro/2)+1;
    if get(handles.sel_filt1,'value')==1
br=ones(co,ro);
d=zeros(co,ro);
d= sqrt((x-cx).^2 + (y-cy).^ 2);
br=(d<192 | d > 200);
outf = Fc .* br;
out =real(abs(ifft2(outf)));
axes(handles.axes4);
imshow(log(1+abs(outf)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
    end
 if get(handles.sel_filt1,'value')==2
Fc(623,:)=0;
Fc(404,:)=0;
Fc(:,676)=0;
Fc(:,351)=0;
Fc(622,:)=0;
Fc(403,:)=0;
Fc(:,675)=0;
Fc(:,350)=0;
Fc(624,:)=0;
Fc(405,:)=0;
Fc(:,677)=0;
Fc(:,352)=0;
out =real(abs(ifft2(Fc)));
axes(handles.axes4);
imshow(log(1+abs(Fc)),'DisplayRange',[]);
axes(handles.axes5);
imshow(out,'DisplayRange',[]);
  end
end




% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in sel_image.
function sel_image_Callback(hObject, eventdata, handles)
% hObject    handle to sel_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sel_image contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_image


% --- Executes during object creation, after setting all properties.
function sel_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sel_filt1.
function sel_filt1_Callback(hObject, eventdata, handles)
% hObject    handle to sel_filt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sel_filt1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_filt1


% --- Executes during object creation, after setting all properties.
function sel_filt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_filt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sel_filt2.
function sel_filt2_Callback(hObject, eventdata, handles)
% hObject    handle to sel_filt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sel_filt2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_filt2


% --- Executes during object creation, after setting all properties.
function sel_filt2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_filt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sel_image.
function popupmenu13_Callback(hObject, eventdata, handles)
% hObject    handle to sel_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sel_image contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_image


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sel_filt1.
function set_filt1_Callback(hObject, eventdata, handles)
% hObject    handle to sel_filt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sel_filt1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_filt1


% --- Executes during object creation, after setting all properties.
function set_filt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_filt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sel_filt2.
function set_filt2_Callback(hObject, eventdata, handles)
% hObject    handle to sel_filt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sel_filt2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_filt2


% --- Executes during object creation, after setting all properties.
function set_filt2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_filt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
