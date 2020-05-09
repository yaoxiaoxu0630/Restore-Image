function varargout = Image_processing3(varargin)
% IMAGE_PROCESSING3 M-file for Image_processing3.fig
%      IMAGE_PROCESSING3, by itself, creates a new IMAGE_PROCESSING3 or raises the existing
%      singleton*.
%
%      H = IMAGE_PROCESSING3 returns the handle to a new IMAGE_PROCESSING3 or the handle to
%      the existing singleton*.
%
%      IMAGE_PROCESSING3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_PROCESSING3.M with the given input arguments.
%
%      IMAGE_PROCESSING3('Property','Value',...) creates a new IMAGE_PROCESSING3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_processing3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_processing3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_processing3

% Last Modified by GUIDE v2.5 16-Sep-2009 22:48:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_processing3_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_processing3_OutputFcn, ...
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


% --- Executes just before Image_processing3 is made visible.
function Image_processing3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_processing3 (see VARARGIN)

% Choose default command line output for Image_processing3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_processing3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_processing3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
bc=imread('image2\ray_traced_bottle.tif');
axes(handles.axes6);
imshow(bc,'DisplayRange',[]);
if get(handles.popupmenu2,'value')==1
   wf=fftshift(fft2(bc));
b=lbutter(bc,15,2);
wb=wf.*b;
wba=abs(ifft2(wb));
wba=uint8(255*mat2gray(wba));
axes(handles.axes7);
imshow(wba,'DisplayRange',[]);
K=0.01;
wbf=fftshift(fft2(wba));
w1=wbf.*(abs(b).^2./(abs(b).^2+K)./b); 
w1a=abs(ifft2(w1));
axes(handles.axes8);
imshow(mat2gray(w1a),'DisplayRange',[]);
end

if get(handles.popupmenu2,'value')==2
b=im2uint8(bc);
m=fspecial('motion',len,0);
bm=imfilter(b,m,'circular');
axes(handles.axes7);
imshow(bm,'DisplayRange',[]);
m2=zeros(128,128);
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
end
end


if get(handles.sel_image,'value')==2
bc=imread('image2\children.tif');
axes(handles.axes6);
imshow(bc,'DisplayRange',[]);
if get(handles.popupmenu2,'value')==1
   wf=fftshift(fft2(bc));
b=lbutter(bc,15,2);
wb=wf.*b;
wba=abs(ifft2(wb));
wba=uint8(255*mat2gray(wba));
axes(handles.axes7);
imshow(wba,'DisplayRange',[]);
K=0.01;
wbf=fftshift(fft2(wba));
w1=wbf.*(abs(b).^2./(abs(b).^2+K)./b); 
w1a=abs(ifft2(w1));
axes(handles.axes8);
imshow(mat2gray(w1a),'DisplayRange',[]);
end

if get(handles.popupmenu2,'value')==2
b=im2uint8(bc);
m=fspecial('motion',len,0);
bm=imfilter(b,m,'circular');
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
end
end
if get(handles.sel_image,'value')==3
bc=imread('image2\a.tif');
axes(handles.axes6);
imshow(bc,'DisplayRange',[]);
if get(handles.popupmenu2,'value')==1
   wf=fftshift(fft2(bc));
b=lbutter(bc,15,2);
wb=wf.*b;
wba=abs(ifft2(wb));
wba=uint8(255*mat2gray(wba));
axes(handles.axes7);
imshow(wba,'DisplayRange',[]);
K=0.01;
wbf=fftshift(fft2(wba));
w1=wbf.*(abs(b).^2./(abs(b).^2+K)./b); 
w1a=abs(ifft2(w1));
axes(handles.axes8);
imshow(mat2gray(w1a),'DisplayRange',[]);
end

if get(handles.popupmenu2,'value')==2
b=im2uint8(bc);
m=fspecial('motion',len,0);
bm=imfilter(b,m,'circular');
axes(handles.axes7);
imshow(bm,'DisplayRange',[]);
m2=zeros(512,512);
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
end
end
if get(handles.sel_image,'value')==4
bc=imread('image2\woman.tif');
axes(handles.axes6);
imshow(bc,'DisplayRange',[]);
if get(handles.popupmenu2,'value')==1
   wf=fftshift(fft2(bc));
b=lbutter(bc,15,2);
wb=wf.*b;
wba=abs(ifft2(wb));
wba=uint8(255*mat2gray(wba));
axes(handles.axes7);
imshow(wba,'DisplayRange',[]);
K=0.01;
wbf=fftshift(fft2(wba));
w1=wbf.*(abs(b).^2./(abs(b).^2+K)./b); 
w1a=abs(ifft2(w1));
axes(handles.axes8);
imshow(mat2gray(w1a),'DisplayRange',[]);
end

if get(handles.popupmenu2,'value')==2
b=im2uint8(bc);
m=fspecial('motion',len,0);
bm=imfilter(b,m,'circular');
axes(handles.axes7);
imshow(bm,'DisplayRange',[]);
m2=zeros(1024,1024);
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
end
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


% --- Executes on button press in pushbutton2.


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
