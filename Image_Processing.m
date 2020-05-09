function varargout = Image_Processing(varargin)
% IMAGE_PROCESSING M-file for Image_Processing.fig
%      IMAGE_PROCESSING, by itself, creates a new IMAGE_PROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGE_PROCESSING returns the handle to a new IMAGE_PROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGE_PROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_PROCESSING.M with the given input arguments.
%
%      IMAGE_PROCESSING('Property','Value',...) creates a new IMAGE_PROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_Processing_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_Processing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Image_Processing

% Last Modified by GUIDE v2.5 02-Sep-2009 15:17:34

% Begin initialization code - DO NOT EDIT
clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_Processing_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_Processing_OutputFcn, ...
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


% --- Executes just before Image_Processing is made visible.
function Image_Processing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_Processing (see VARARGIN)

% Choose default command line output for Image_Processing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_Processing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_Processing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in sel_image.
function sel_image_Callback(hObject, eventdata, handles)

    
% ----------------------------------------------------------------------





function sel_image_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in app_filter.
function noise_app_Callback(hObject, eventdata, handles)
% hObject    handle to app_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns app_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from app_filter


% --- Executes during object creation, after setting all properties.
function noise_app_CreateFcn(hObject, eventdata, handles)
% hObject    handle to app_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in app_filter.
function app_filter_Callback(hObject, eventdata, handles)
% hObject    handle to app_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns app_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from app_filter


% --- Executes during object creation, after setting all properties.
function app_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to app_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in Apply.
function Apply_Callback(hObject, eventdata, handles)
if get(handles.sel_image,'value')==1
f=imread('images\mri.tif'); 
f=imresize(f,[200,200]);
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
[m,n]=size(f);
axes(handles.axes1)

mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));

if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit8,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end

if get(handles.app_noise,'value')==1
j =imnoise(f,'gaussian',mean_s2_val,var_s1_val);
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper',d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end
if get(handles.app_filter,'value')==1
    set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);

end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
hj = ordfilt2(hj, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq);
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
     set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end

if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2)
imshow(f,'DisplayRange',[])
axes(handles.axes3)
imshow(hj,'DisplayRange',[])
end


if get(handles.sel_image,'value')==2
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
f=imread('images\cameraman.tif'); 
f=imresize(f,[200,200]);
axes(handles.axes1)
[m,n]=size(f);
mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));

if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit8,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end
if get(handles.app_noise,'value')==1
j = imnoise(f,'gaussian', mean_s2_val,var_s1_val);
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper', d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end

if get(handles.app_filter,'value')==1
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);
end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq);
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
    set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end
if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2)
imshow(f,'DisplayRange',[])
axes(handles.axes3)
imshow(hj,'DisplayRange',[])

end



if get(handles.sel_image,'value')==3
f=imread('images\bag.png');  
f=imresize(f,[200,200]);
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
axes(handles.axes1)
[m,n]=size(f);
mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));
if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit8,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end
if get(handles.app_noise,'value')==1
j = imnoise(f,'gaussian', mean_s2_val,var_s1_val);
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper', d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end
if get(handles.app_filter,'value')==1
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);
end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq);
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
    set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end
if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2)
imshow(f,'DisplayRange',[])
axes(handles.axes3)
imshow(hj,'DisplayRange',[])
end

%----------------------------------------

if get(handles.sel_image,'value')==4
f=imread('images\eight.tif');
f=imresize(f,[200,200]);
[m,n]=size(f);
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
axes(handles.axes1)
mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));
if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit8,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end
if get(handles.app_noise,'value')==1
j = imnoise(f,'gaussian', mean_s2_val,var_s1_val);
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper', d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end
if get(handles.app_filter,'value')==1
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);
end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq);
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
    set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end
if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2)
imshow(f,'DisplayRange',[])
axes(handles.axes3)
imshow(hj,'DisplayRange',[])
end

if get(handles.sel_image,'value')==5
f=imread('images\pout.tif');   
f=imresize(f,[200,200]);
[m,n]=size(f);
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
axes(handles.axes1)
mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));
if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit8,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end
if get(handles.app_noise,'value')==1
j = imnoise(f,'gaussian', mean_s2_val,var_s1_val);
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper', d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end
if get(handles.app_filter,'value')==1
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);
end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq)
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
    set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end
if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2)
imshow(f,'DisplayRange',[])
axes(handles.axes3)
imshow(hj,'DisplayRange',[])
end

if get(handles.sel_image,'value')==6
f=imread('images\football.tif'); 
f=rgb2gray(f);
f=imresize(f,[200,200]);
[m,n]=size(f);
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
axes(handles.axes1)
mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));
if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit8,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end
if get(handles.app_noise,'value')==1
j = imnoise(f,'gaussian', mean_s2_val,var_s1_val);
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper', d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end
if get(handles.app_filter,'value')==1
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);
end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq);
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
    set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end
if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2);
imshow(f,'DisplayRange',[])
axes(handles.axes3);
imshow(hj,'DisplayRange',[])
end

if get(handles.sel_image,'value')==7
f=imread('images\moon.tif');  
f=imresize(f,[200,200]);
[m,n]=size(f);
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
axes(handles.axes1)
mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));
if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit8,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end
if get(handles.app_noise,'value')==1
j = imnoise(f,'gaussian', mean_s2_val,var_s1_val);
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper', d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end
if get(handles.app_filter,'value')==1
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);
end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq);
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
    set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end
if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2)
imshow(f,'DisplayRange',[])
axes(handles.axes3)
imshow(hj,'DisplayRange',[])
end

if get(handles.sel_image,'value')==8
f=imread('images\peppers.png'); 
f=rgb2gray(f);
f=imresize(f,[200,200]);
[m,n]=size(f);
var_s1_val = get(handles.slider1,'Value');
mean_s2_val = get(handles.slider2,'Value');
l_v_s3_val = get(handles.slider3,'Value');
d_s4_val = get(handles.slider4,'Value');
v_s4_val = get(handles.slider5,'Value');
axes(handles.axes1)
mm=str2double(get(handles.edit8,'string'));
nn=mm;
d=str2double(get(handles.edit9,'string'));
qq=str2double(get(handles.edit10,'string'));
if mm<=1 | mm>=10 | isnan(mm)
mm=3;
nn=3;
set(handles.edit10,'string',mm);
end
if isnan(d)|d<=1 
d=2;
end
if d>6 
    d=6;
end
if mod(d,2)~=0
d=d-1;
end
if isnan(qq)
qq=1.5;
end
if get(handles.app_noise,'value')==1
j = imnoise(f,'gaussian', mean_s2_val,var_s1_val );
end
if get(handles.app_noise,'value')==2
j = imnoise(f,'localvar',ones(m,n)/(l_v_s3_val+1));
end
if get(handles.app_noise,'value')==3
j = imnoise(f,'poisson');
end
if get(handles.app_noise,'value')==4
j = imnoise(f,'salt & pepper', d_s4_val);
end
if get(handles.app_noise,'value')==5
j = imnoise(f,'speckle', v_s4_val);
end
if get(handles.app_filter,'value')==1
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
w1=fspecial('average');
hj=imfilter(j,w1);
end
if get(handles.app_filter,'value')==2
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = exp(imfilter(log(j), ones(mm, nn), 'replicate')).^(1 / mm / nn); 
end
if get(handles.app_filter,'value')==3
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
j = im2double(j); 
hj = mm* nn ./ imfilter(1./(j + eps),ones(mm, nn), 'replicate'); 
end
if get(handles.app_filter,'value')==4
    set(handles.edit9,'string','');
    set(handles.edit10,'string',qq);
j = im2double(j); 
hj = imfilter(j.^(qq+1), ones(mm, nn), 'replicate'); 
hj = hj ./ (imfilter(j.^qq, ones(mm, nn), 'replicate') + eps); 
end
if get(handles.app_filter,'value')==5
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = medfilt2(j, [mm nn], 'symmetric'); 
end
if get(handles.app_filter,'value')==6
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==7
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
end
if get(handles.app_filter,'value')==8
      set(handles.edit10,'string','');
    set(handles.edit9,'string','');
hj1 = ordfilt2(j, 1, ones(mm, nn), 'symmetric'); 
   hj2 = ordfilt2(j, mm*nn, ones(mm, nn), 'symmetric'); 
   hj = imlincomb(0.5, hj1, 0.5, hj2); 
end
if get(handles.app_filter,'value')==9
      set(handles.edit10,'string','');
    set(handles.edit9,'string',d);
j = im2double(j); 
hj = imfilter(j, ones(mm, nn), 'symmetric'); 
for k = 1:d/2 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
for k = (mm*nn - (d/2) + 1):mm*nn 
   hj = imsubtract(hj, ordfilt2(j, k, ones(mm, nn), 'symmetric')); 
end 
hj = hj / (mm*nn - d);
end
if get(handles.app_filter,'value')==10
     
j = im2double(j); 
  hj=wiener2(j,[mm,nn]);
end

if get(handles.app_filter,'value')==11
     
j = im2double(j); 
    a3=fspecial('average',[mm,nn]);
 hj=filter2(a3,j);
end
imshow(j,'DisplayRange',[])
axes(handles.axes2)
imshow(f,'DisplayRange',[])
axes(handles.axes3)
imshow(hj,'DisplayRange',[])
end
% hObject    handle to Apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




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







% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function f = gmean(g, m, n) 
%  Implements a geometric mean filter. 
inclass = class(g); 
g = im2double(g); 
% Disable log(0) warning. 
warning off; 
f = exp(imfilter(log(g), ones(m, n), 'replicate')).^(1 / m / n); 
warning on; 
f = changeclass(inclass, f); 
 




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






function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
    close all;

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
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


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function [out, H] = butterworth_high (im,fc,n)
    [co,ro] = size(im);
    cx = round(co/2); % find the center of the image
    cy = round (ro/2);
    imf=fftshift(fft2(im));
    H=zeros(co,ro);
    for i = 1 : co
        for j =1 : ro
               d = (i-cx).^2 + (j-cy).^ 2;
               if d ~= 0
               H(i,j) = 1/(1+((fc*fc/d).^(2*n)));
           end;
               
        end;
    end;
    outf = imf .* H;
    out = abs(ifft2(outf));
    %--------------------------------------------------
    %--------------------------------------------------
    function [out, H] = butterworth_low (im,fc,n)
    [co,ro] = size(im);
    cx = round(co/2); % find the center of the image
    cy = round (ro/2);
    imf=fftshift(fft2(im));
    H=zeros(co,ro);
    for i = 1 : co
        for j =1 : ro
               d = (i-cx).^2 + (j-cy).^ 2;
               H(i,j) = 1/(1+((d/fc/fc).^(2*n)));
        end;
    end;
    outf = imf .* H;
    out = abs(ifft2(outf));
    
    %--------------------------------------------------
    %--------------------------------------------------
    function  [out, H] = gaussian_high(im, fc)
    imf = fftshift(fft2(im));
    [co,ro]=size(im);
    H = gaussian_filter(co,ro, fc);
    H = 1-H;
    out = zeros(co,ro);
    outf= imf.*H;
    out=abs(ifft2(outf));
    
 %--------------------------------------------------
 %--------------------------------------------------
 function  [out, H] = gaussian_low(im, fc)
    imf = fftshift(fft2(im));
    [co,ro]=size(im);
    out = zeros(co,ro);
    H = gaussian_filter(co,ro, fc);
    outf= imf.*H;
    out=abs(ifft2(outf));
%--------------------------------------------------
 %--------------------------------------------------
% gaussian filter
function  H = gaussian_filter(co,ro, fc)   
     cx = round(co/2); % find the center of the image
    cy = round (ro/2);
    H = zeros(co,ro);
    for i = 1 : co
        for j = 1 : ro
            d = (i-cx).^2 + (j-cy).^2;
            H(i,j) = exp(-d/2/fc/fc);
        end;
    end;
 %--------------------------------------------------
 %--------------------------------------------------
    
% Ideal High pass filter
function  [out, H] = ideal_high(im, fc)
      imf = fftshift(fft2(im));
    [co,ro]=size(im);
    H = ideal_filter(co,ro,fc);
    H = 1-H;
    outf=imf.*H;
    out=abs(ifft2(outf));
 %--------------------------------------------------
 %--------------------------------------------------
% Ideal Low pass filter
function  [out, H] = ideal_low(im, fc)
    imf = fftshift(fft2(im));
    [co,ro]=size(im);
    H = ideal_filter(co,ro,fc);
    outf=imf.*H;
    out=abs(ifft2(outf));
 %--------------------------------------------------
 %--------------------------------------------------
%Ideal filter
function H = ideal_filter(co,ro,fc)
    cx = round(co/2); % find the center of the image
    cy = round (ro/2);
    H=zeros(co,ro);
    if fc > cx & fc > cy
        H = ones(co,ro);
        return;
    end;
    for i = 1 : co
        for j = 1 : ro
            if (i-cx).^2 + (j-cy).^2 <= fc .^2
                H(i,j)=1;
            end;
        end;
    end;


% --- Executes on button press in Apply.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to Apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in app_noise.
function app_noise_Callback(hObject, eventdata, handles)
% hObject    handle to app_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns app_noise contents as cell array
%        contents{get(hObject,'Value')} returns selected item from app_noise


% --- Executes during object creation, after setting all properties.
function app_noise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to app_noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in app_filter.
function popupmenu14_Callback(hObject, eventdata, handles)
% hObject    handle to app_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns app_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from app_filter


% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to app_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sel_image.
function popupmenu15_Callback(hObject, eventdata, handles)
% hObject    handle to sel_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sel_image contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_image


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider21_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider22_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider23_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider24_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider25_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit32_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text92_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function text92_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text92.
function text92_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double


% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double


% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit37_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu16


% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider26_Callback(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider27_Callback(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function cutoffEdit_Callback(hObject, eventdata, handles)
% hObject    handle to cutoffEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutoffEdit as text
%        str2double(get(hObject,'String')) returns contents of cutoffEdit as a double


% --- Executes during object creation, after setting all properties.
function cutoffEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutoffEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function butflyEditt_Callback(hObject, eventdata, handles)
% hObject    handle to butflyEditt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of butflyEditt as text
%        str2double(get(hObject,'String')) returns contents of butflyEditt as a double


% --- Executes during object creation, after setting all properties.
function butflyEditt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to butflyEditt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
