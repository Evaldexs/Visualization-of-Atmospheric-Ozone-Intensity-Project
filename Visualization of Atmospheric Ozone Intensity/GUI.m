function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 04-Mar-2020 13:19:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

axes(handles.axes1);

%The Data variable just defines the file name which is given
Data = "o3_surface_20180701000000.nc";

%Storing the longitude and latitude from the file read into a single
%array
longitude = ncread(Data, "lon");
latitude = ncread(Data, "lat");
set(gca,'Color','k')
global t;       %Defining global variable t which is going to counted as a index number for the file to open
global colour;  %Defining global variable colour which is going to be the number for the colour blindness
colour = 2;     %Setting the default colourbliness level which is 2 (for people without colourblind)
t = 1;          %Setting the first file which needs to be read
loading_Storing(t,colour);  %Calling the function loading_Storing with the given inputs


% --- Executes on button press in previous.
function previous_Callback(hObject, eventdata, handles)
% hObject    handle to previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Data = "o3_surface_20180701000000.nc";
longitude = ncread(Data, "lon");
latitude = ncread(Data, "lat");

global t;       %Defining global variable t which is going to counted as a index number for the file to open
global colour;  %Defining global variable colour which is going to be the number for the colour blindness
t = t - 1;  %Setting the previous file which needs to be read 
if t == 0
    t = 1;
end
set(handles.slider1,'Value',t)  %Setting the slider value to be at the same point where t is
assignin('base','value',t);     %Assigning the value of the slider to t
set(handles.SliderNumber, 'String',num2str(t-1)); %Setting the slider Number (as a string)
loading_Storing(t,colour);  %Calling the function loading_Storing with the given inputs

% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%The Data variable just defines the file name which is given
Data = "o3_surface_20180701000000.nc";

%Storing the longitude and latitude from the file read into a single
%array
longitude = ncread(Data, "lon");
latitude = ncread(Data, "lat");

global t;       %Defining global variable t which is going to counted as a index number for the file to open
global colour;  %Defining global variable colour which is going to be the number for the colour blindness
t = t + 1;  %Setting the second file which needs to be read
if t > 25
    t = 1;
end

set(handles.slider1,'Value',t)  %Setting the slider value to be at the same point where t is
assignin('base','value',t);     %Assigning the value of the slider to t
set(handles.SliderNumber, 'String',num2str(t-1)); %Setting the slider Number (as a string) 
loading_Storing(t,colour);  %Calling the function loading_Storing with the given inputs


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

value = round(get(hObject,'Value'));    %Setting the value of the slider to be a round number so we will not get floating points
assignin('base','value',value);         %Assigning the value of the slider to t
set(handles.SliderNumber, 'String',num2str(value-1)); %Setting the slider Number to be the same as t-1 (as a string)
global t;       %Defining global variable t which is going to counted as a index number for the file to open
global colour;  %Defining global variable colour which is going to be the number for the colour blindness
t = value;      %Setting the value of t to be the same value as the slider value
loading_Storing(t,colour);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in colour_of_the_map.
function colour_of_the_map_Callback(hObject, eventdata, handles)
% hObject    handle to colour_of_the_map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns colour_of_the_map contents as cell array
%        contents{get(hObject,'Value')} returns selected item from colour_of_the_map

global t;       %Defining global variable t which is going to counted as a index number for the file to open
global colour;  %Defining global variable colour which is going to be the number for the colour blindness
contents = get(hObject,'Value');    %Getting the contents of the value variable

%Using switch to get all strings of the contents variable and using them as
%a case
switch contents
    
    case 1  %Case 1 which does nothing, just displays the text - Colour of the map
        
    case 2  %Switches the colour of map to be to default (with all colours)
        colour = 2;
        loading_Storing(t,colour);
        
    case 3  %Switches the colour of map for people with complete colour blindness
        colour = 3;
        loading_Storing(t,colour);
        
    case 4  %Switches the colour of map to be as inferno
        colour = 4;
        loading_Storing(t,colour);
        
    
    case 5  %Switches the colour of map to be as magma
        colour = 5;
        loading_Storing(t,colour);
        
    case 6  %Switches the colour of map to be as plasma
        colour = 6;
        loading_Storing(t,colour);
        
    case 7  %Switches the colour of map to be as viridis
        colour = 7;
        loading_Storing(t,colour);
        
    case 8  %Switches the colour of map to be as jet colour
        colour = 8;
        loading_Storing(t,colour);
end

% --- Executes during object creation, after setting all properties.
function colour_of_the_map_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colour_of_the_map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
