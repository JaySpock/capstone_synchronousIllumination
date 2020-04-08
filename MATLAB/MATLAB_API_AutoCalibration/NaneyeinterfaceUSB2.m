function varargout = NaneyeinterfaceUSB2(varargin)
% NANEYEINTERFACEUSB2 MATLAB code for NaneyeinterfaceUSB2.fig
%      
%   NANEYEINTERFACEUSB2, creates an interface based on MATLAB's GUIDE,
%   to be used with AWAIBA's Image Sensor NanEye2D when used on a USB2 evaluation board.
%   
%   This interface goal is to give an example of what can be done on MATLAB with NanEye Sensor.
%   Here we show how to write registers, turn on the LED (if that is an
%   option), check the histogram of all the pixels - values density or
%   pixel count - a 3D profile of the gray values or from the RGB values,
%   etc.
%   
%   It is important to maintain all the .dll downloaded with this file on
%   the MATLAB's current folder. 
%
%   More details can be found on the AWAIBA documentation that was provided
%   with this file.
%
%   If you need help please contact: support@awaiba.com

% Edit the above text to modify the response to help NaneyeinterfaceUSB2

% Last Modified by GUIDE v2.5 08-Apr-2020 09:54:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NaneyeinterfaceUSB2_OpeningFcn, ...
                   'gui_OutputFcn',  @NaneyeinterfaceUSB2_OutputFcn, ...
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

% --- Executes just before NaneyeinterfaceUSB2 is made visible.
function NaneyeinterfaceUSB2_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for NaneyeinterfaceUSB2
global lock naneye1 w h colorlist BW FPGA

clear global a; %clears the previous connection so a new updated Arduino connection can be established
hdlsetuptoolpath('ToolName','Altera Quartus II','ToolPath','C:\intelFPGA_lite\18.1\quartus\bin64\quartus.exe');
FPGA = aximaster('Intel');
writememory(FPGA,16384,0);

% The 'lock' variable is used to control if a histogram is to be displayed.
% 'lock = -1' ensures that no histogram was requested and 'lock = 3' enables the displaying of the histogram. 
% These are random values. It is possible to use any other value according to the user. 

lock=-1;
handles.output = hObject;
movegui(hObject,'center')

% Calling the .NET assemblies it's an important part of the process. 
% MSCORLIB is an internal dll from Windows and has to be loaded for the 
% below dlls to work. 
if exist('asm')~= 1
    asm = NET.addAssembly('mscorlib');
end

NET.addAssembly([pwd '\awcorecs.dll']);
NET.addAssembly([pwd '\CesysProvider.dll']);
NET.addAssembly([pwd '\AwFrameProcessing.dll']);

% Update handles structure
guidata(hObject, handles);
disp('....Application Starting')

% Setting the sensor according to the NanEye Provider Demo, and setting the
% .mat file that corresponds to the register setting to present on the
% table. The second .mat file loaded is regarding the default register
% values. Optionally not all the default registers can be edited on this
% interface.

Awaiba.Drivers.Grabbers.Location.Paths.SetFpgaFilesDirectory('')
Awaiba.Drivers.Grabbers.Location.Paths.SetBinFile('nanousb2_fpga_v07.bin')

naneye1 = Awaiba.Drivers.Grabbers.NanEye2DNanoUSB2Provider; w=250; h=250;

SensorReg=load('NaneyeRegDataUSB2.mat');
set(handles.registertable,'data',SensorReg.RegData);

SensorDefault=load('NaneyeRegDataUSB2_default.mat');

for i = 1:8
    regobj=Awaiba.Drivers.Grabbers.NanEyeRegisterPayload(false,i, true, 0, cell2mat(SensorDefault.RegData(i,4)));
    naneye1.WriteRegister(regobj)
end

%Here some of the image processing algorithms are activated. They can all
%be manually activated/deactivated on the interface.
naneye1.AutomaticExpControl().ShowROI = 0;
naneye1.AutomaticExpControl().Enabled = 0;
colorlist = Awaiba.FrameProcessing.ProcessingWrapper.Instance(0);
colorlist.colorReconstruction.Apply=1;

BW=0;

isAECon = naneye1.AutomaticExpControl().IsEnabled;
isROIon = naneye1.AutomaticExpControl().ShowROI;
isCOLORon = colorlist.colorReconstruction.Apply;
set(handles.checkbox1,'Value',isAECon);
set(handles.checkbox2,'Value',isROIon);
set(handles.checkbox3,'Value',isCOLORon);

guidata(hObject,handles);

% UIWAIT makes NaneyeinterfaceUSB2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = NaneyeinterfaceUSB2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.output;

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(handles.figure1)

% --- Executes on selection change in scriptlist.
function scriptlist_Callback(hObject, eventdata, handles)
% On the 3D graphs there is no need to have a button to freeze the axes or 
% to change the axis scales, from density mode to pixel count. Here those features are deactivated. 

 chosen_graph = get(handles.scriptlist,'Value');
 
 if chosen_graph > 1
     set(handles.axisauto,'Enable','Off');
     set(handles.togglebutton3,'Enable','Off');
     set(handles.axisauto,'Value',0);
     set(handles.axisauto,'String','Freeze Axes');
 else
     set(handles.axisauto,'Enable','On');
     set(handles.togglebutton3,'Enable','On');
 end

% --- Executes on button press in startbuttom.
function startbuttom_Callback(hObject, eventdata, handles)
% The start button starts the displaying of what the sensor is capturing,
% keeping that capture until the Stop is pressed.

global naneye1 keep_running A B C FPGA frameOrder record v r g b lh1 Aimg Bimg Cimg nextFrame count oldput previmg scalered scalegreen scaleblue

keep_running=true;
choice=get(handles.startbuttom,'string');

while keep_running
    
    switch choice
        
       case 'Start'
            disp("Setting up variables, hit Confirm Start when ready");
            A = ones(1,62500);
            B = 2*A;
            C = 3*B;
            r = reshape(A(), [250,250]);
            g = reshape(B(), [250,250]);
            b = reshape(C(), [250,250]);
            nextFrame = 'One';
            previmg = double(zeros(250,250));
            count = 'A';
            scalered = 1;
            scalegreen = 1;
            scaleblue = 1;
            frameOrder = 1;
            record = 2;
            v = VideoWriter('NewColorVideoTest.avi','Uncompressed AVI');
            writememory(FPGA,16384,2);
            disp("Ready");
            choice=set(handles.startbuttom,'string','Confirm Start');
            keep_running = false;
            
        case 'Confirm Start'
            oldput = readmemory(FPGA,16400,1);
            axes(handles.axes1);
            handles.image=image;
            axis off;
            lh1 = addlistener(naneye1,'ImageProcessed', @(o,e)displayobjRunMode(e,handles));
            naneye1.StartCapture();            
            choice=set(handles.startbuttom,'string','Stop');
            keep_running = false;
        
        case 'Stop'
            naneye1.StopCapture();
            delete(lh1);
            writememory(FPGA,16384,0);
            
            figure;
            tiledlayout(1,3);
            nexttile
            image(Aimg); title("A");
            nexttile
            image(Bimg); title("B");
            nexttile
            image(Cimg); title("C");
            
%             save('A_NormalRun.mat','Aimg');
%             save('B_NormalRun.mat','Bimg');
%             save('C_NormalRun.mat','Cimg');

            choice=set(handles.startbuttom,'string','Start');
            keep_running = false;
    end
    
end

guidata(hObject,handles);


% --- Executes on button press in saveimage, to save the image captured by
% the sensor.
function saveimage_Callback(hObject, eventdata, handles)



figure;
exported_fig=gca;
copyobj(allchild(handles.axes1), exported_fig);
axis(exported_fig,'tight','square');
axis off;

guidata(hObject,handles);


function scriptlist_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Histogram', '3D Red Values', '3D Green Values', '3D Blue Values'});


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
global naneye1

naneye1.Dispose();

disp('....Application Ended')
delete(hObject);
clear variables
close all

% --- Executes on button press in saveplot, to save any histogram or 3D
% graphic.
function saveplot_Callback(hObject, eventdata, handles)
% hObject    handle to saveplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global StatData
% assignin('base', 'DataORION', handles.axes2);

figure;
exported_fig=gca;
copyobj(allchild(handles.axes2), exported_fig);
% copyobj(allchild(handles.axes2), exported_fig);

guidata(hObject,handles);


% --- Executes on button press in RunnigScript.
function RunnigScript_Callback(hObject, eventdata, handles)
% This will use the 'lock' variable to transmit the information that there
% is something to present on the second axes ('lock = 3').

global lock data

 if get(hObject,'Value') == 1
     lock=3;
     data=[];
     set(handles.RunnigScript,'String','Stop Script');
     set(handles.saveplot,'Enable','On');
     set(handles.axisauto,'Enable','On');
     set(handles.togglebutton3,'Enable','On');
 else
     assignin('base', 'Data',data);
     lock=-1;
     set(handles.RunnigScript,'String','Run Script');
     set(handles.saveplot,'Enable','Off');
     set(handles.axisauto,'Enable','Off');
     set(handles.togglebutton3,'Enable','Off');
 end
 
 % If one of the 3D graphs options is chosen, then the options 'Freeze
 % Axes' and 'Density/Pixel Count' will be deactivated.
 chosen_graph = get(handles.scriptlist,'Value');
 
 if chosen_graph > 1
     set(handles.axisauto,'Enable','Off');
     set(handles.togglebutton3,'Enable','Off');
     set(handles.axisauto,'Value',0);
     set(handles.axisauto,'String','Freeze Axes');
 else
 end     

 
function xmin_Callback(hObject, eventdata, handles)
% hObject    handle to xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xmin as text
%        str2double(get(hObject,'String')) returns contents of xmin as a double
global limits
value=str2double(get(hObject,'String'));
limits(1)=value;
limits(3)=(str2double(get(handles.xmax,'String'))-value)+1;
set(handles.rect,'Position',limits);


% --- Executes on button press in axisauto.
function axisauto_Callback(hObject, eventdata, handles)
% This freezes the axis scale, limiting it to the max value found when the
% button is pressed. That maximum value is kept on variable 'limitation' to
% be transported into the "setgraph.m" file.
global limitation

if get(hObject,'Value') == 1
    limitation=get(handles.axes2,'YLim');
    set(handles.axes2,'YLimMode','manual');
    set(handles.axisauto,'String','Unfreeze Axes')
else
    axis(handles.axes2,'auto')
    set(handles.axisauto,'String','Freeze Axes')
end

 guidata(hObject,handles);


% --- Executes when entered data in editable cell(s) in registertable.
function registertable_CellEditCallback(hObject, eventdata, handles)
% Each of the values added to the table (on the fourth row - decimal
% values) will be writen on sensor's registers.
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global naneye1
disp('....Writting Registers');

x=eventdata.Indices(2);
y=eventdata.Indices(1);
registertable=get(handles.registertable,'data');
value=cell2mat(registertable(y,x));

    
    if x == 3 ;
        value=hex2dec(value); 
    end
    
    featureoutput = setSensorFeature(value,y);
    
    value=featureoutput;
    
    registertable(y,3)={dec2hex(value)};
    registertable(y,4)={value};
    
    RegAddress=hex2dec(cell2mat(registertable(y,2)));

    regobj=Awaiba.Drivers.Grabbers.NanEyeRegisterPayload(false,RegAddress, true, 0,value);
    naneye1.WriteRegister(regobj)

set( handles.registertable,'data',registertable)
guidata(hObject,handles);


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global naneye1

if get(handles.checkbox1,'Value') == 0
   disp('AEC disabled...')
   naneye1.AutomaticExpControl().Enabled = 1;
else
    disp('AEC enabled...')
    naneye1.AutomaticExpControl().Enabled = 0;
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global naneye1

if get(handles.checkbox2,'Value') == 0
   disp('ROI disabled...')
   naneye1.AutomaticExpControl().ShowROI = 0;
else
    disp('ROI enabled...')
    naneye1.AutomaticExpControl().ShowROI = 1;
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global colorlist BW lock

if get(handles.checkbox3,'Value') == 0
    disp('Color Reconstruction disabled...')
    colorlist.colorReconstruction.Apply=false;
    set(handles.scriptlist, 'String', {'Histogram', '3D Histogram'});
    set(handles.scriptlist, 'Value',1);
    BW = 1;
else
    disp('Color Reconstruction enabled...')
    colorlist.colorReconstruction.Apply=true;
    set(handles.scriptlist, 'String', {'Histogram', '3D Red Values', '3D Green Values', '3D Blue Values'});
    BW = 0;
end

if lock == 3
    set(handles.scriptlist, 'Value',2);
else
end

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% Reprogramming the board, in case the user has forgot to plug it before
% initializing the interface.
global naneye1 w h
naneye1 = Awaiba.Drivers.Grabbers.NanEye2DNanoUSB2Provider; w=250; h=250;
set(handles.startbuttom,'string','Start');
SensorReg=load('NaneyeRegDataUSB2.mat');
set(handles.registertable,'data',SensorReg.RegData);

SensorDefault=load('NaneyeRegDataUSB2_default.mat');

for i = 1:8
    regobj=Awaiba.Drivers.Grabbers.NanEyeRegisterPayload(false,i, true, 0, cell2mat(SensorDefault.RegData(i,4)));
    naneye1.WriteRegister(regobj)
end

%Here some of the image processing algorithms are activated. They can all
%be manually activated/deactivated on the interface.
naneye1.AutomaticExpControl().ShowROI = 0;
naneye1.AutomaticExpControl().Enabled = 0;
colorlist = Awaiba.FrameProcessing.ProcessingWrapper.Instance(0);
colorlist.colorReconstruction.Apply=1;

BW=0;

isAECon = naneye1.AutomaticExpControl().IsEnabled;
isROIon = naneye1.AutomaticExpControl().ShowROI;
isCOLORon = colorlist.colorReconstruction.Apply;
set(handles.checkbox1,'Value',isAECon);
set(handles.checkbox2,'Value',isROIon);
set(handles.checkbox3,'Value',isCOLORon);


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global presenting_mode

disposal = get(handles.togglebutton3,'String');

switch disposal
    
    case 'Density'
        set(handles.togglebutton3,'String','Pixel Count')
        presenting_mode = 1;
    
    case 'Pixel Count'
        set(handles.togglebutton3,'String','Density')
        presenting_mode = 2;

end
    

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global naneye1
led_on = get(handles.checkbox5, 'Value');
if led_on == 1
    regobj=Awaiba.Drivers.Grabbers.NanEyeRegisterPayload(false,5, true, 0, 1);
    naneye1.WriteRegister(regobj)
else
    regobj=Awaiba.Drivers.Grabbers.NanEyeRegisterPayload(false,5, true, 0, 0);
    naneye1.WriteRegister(regobj)
end


% --- Executes on button press of Calibrate button.
function calibratebutton_Callback(hObject, eventdata, handles)
% hObject    handle to calibratebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global naneye1 keeprunning previousin previousimg FPGA ZeroCal caliRed caliGreen caliBlue RedOn RedOff RedZero GreenOn GreenOff GreenZero BlueOn BlueOff BlueZero lh2 RedOnimg RedOffimg RedZeroimg GreenOnimg GreenOffimg GreenZeroimg BlueOnimg BlueOffimg BlueZeroimg

keeprunning=true;
choice=get(handles.calibratebutton,'string');

while keeprunning
   
    switch choice
        
       case 'Calibrate'
            writememory(FPGA,16384,1);
            previousin = readmemory(FPGA,16400,1);
            previousimg = zeros(250,250);                   
            axes(handles.axes1); %do these axis commands need to be called everytime?
            handles.image=image;
            axis off;
            lh2 = addlistener(naneye1,'ImageProcessed', @(o,e)displayobjCalibration(e,handles));
            naneye1.StartCapture();
            choice=set(handles.calibratebutton,'string','End Calibration');
            keeprunning = false;
         
        case 'End Calibration'
            disp("Calibration finished"); %I could put this at the actual end?
            naneye1.StopCapture();
            delete(lh2);
            writememory(FPGA,16384,0);
            CAL = double(zeros(187500,3));
            CALinv = double(zeros(187500,3));
            
            for n=1:62500
                CAL(3*n-2:3*n,:)=[RedOn(n) GreenZero(n) BlueOff(n); RedOff(n) GreenOn(n) BlueZero(n); RedZero(n) GreenOff(n) BlueOn(n)];
                CALinv(3*n-2:3*n,:)=inv([RedOn(n) GreenZero(n) BlueOff(n); RedOff(n) GreenOn(n) BlueZero(n); RedZero(n) GreenOff(n) BlueOn(n)]);
                detCAL(3*n-2:3*n,:) = det(CAL(3*n-2:3*n,:));
                if detCAL(3*n-2:3*n,:) == 0
                    CALinv(3*n-2:3*n,:) = double(zeros(3,3));
                else
                end
            end
            
            caliRed   = CALinv(1:3:end,:);
            caliGreen = CALinv(2:3:end,:);
            caliBlue  = CALinv(3:3:end,:);
            
            figure;
            tiledlayout(3,3);
            nexttile
            image(RedOnimg); title("Red On");
            nexttile
            image(RedOffimg); title("Red Off");
            nexttile
            image(RedZeroimg); title("After Red Off");
            nexttile
            image(GreenOnimg); title("Green On");
            nexttile
            image(GreenOffimg); title("Green Off");
            nexttile
            image(GreenZeroimg); title("After Green Off");
            nexttile
            image(BlueOnimg); title("Blue On");
            nexttile
            image(BlueOffimg); title("Blue Off");
            nexttile
            image(BlueZeroimg); title("After Blue Off");
            
%             save('RedOn.mat','RedOnimg');
%             save('RedOff.mat','RedOffimg');
%             save('RedZero.mat','RedZeroimg');
%             save('GreenOn.mat','GreenOnimg');
%             save('GreenOff.mat','GreenOffimg');
%             save('GreenZero.mat','GreenZeroimg');
%             save('BlueOn.mat','BlueOnimg');
%             save('BlueOff.mat','BlueOffimg');
%             save('BlueZero.mat','BlueZeroimg');

            choice=set(handles.calibratebutton,'string','Calibrate');
            keeprunning = false;
            
    end
end

guidata(hObject,handles);


% --- Executes on button press in switchorderbutton.
function switchorderbutton_Callback(hObject, eventdata, handles)
% hObject    handle to switchorderbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global frameOrder

choice=get(handles.switchorderbutton,'string');

switch choice
    case 'Switch Order (1st Time)' %I will need to be able to go right back into the normal run mode after this is changed, maybe put it somewhere else? not triggered off a button?
        frameOrder = 2;
        choice=set(handles.switchorderbutton,'string','Switch Order (2nd Time)');
    case 'Switch Order (2nd Time)'
        frameOrder = 3;
        choice=set(handles.switchorderbutton,'string','Revert to Original');
    case 'Revert to Original'
        frameOrder = 1;
        choice=set(handles.switchorderbutton,'string','Switch Order (1st Time)');
end


% --- Executes on button press in savevideobutton.
function savevideobutton_Callback(hObject, eventdata, handles)
% hObject    handle to savevideobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global record v

choice=get(handles.savevideobutton,'string');

switch choice
    case 'Start Record'
        open(v);
        record = 1;
        choice=set(handles.savevideobutton,'string','Stop Record');
    case 'Stop Record'
        record = 2;
        close(v);
        choice=set(handles.savevideobutton,'string','Start Record');
end


% --- Executes on slider movement.
function redslider_Callback(hObject, eventdata, handles)
% hObject    handle to redslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global scalered
scalered = get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function redslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to redslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function greenslider_Callback(hObject, eventdata, handles)
% hObject    handle to greenslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scalegreen
scalegreen = get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function greenslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to greenslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function blueslider_Callback(hObject, eventdata, handles)
% hObject    handle to blueslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scaleblue
scaleblue = get(hObject,'Value');

% --- Executes during object creation, after setting all properties.
function blueslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blueslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in colorscaleresetbutton.
function colorscaleresetbutton_Callback(hObject, eventdata, handles)
% hObject    handle to colorscaleresetbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scalered scalegreen scaleblue

scalered = 1;
set(handles.redslider, 'Value', 1);
scalegreen = 1;
set(handles.greenslider, 'Value', 1);
scaleblue = 1;
set(handles.blueslider, 'Value', 1);

guidata(hObject,handles);
