function displayobjdatacapture(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock w h DataCaptureObj out

%  DataCaptureObj = datacapture;
%  DataCaptureObj.TriggerPosition = 0;
%  DataCaptureObj.NumCaptureWindows = 128;  
%  setRunImmediateFlag(DataCaptureObj,'1')
%  NumberOfSampledepth = 1;
%  Sample_depth = 128;
%  data_out =  int16(zeros(NumberOfSampledepth*Sample_depth, 1));
% for i=1: 1
% setTriggerCondition(DataCaptureObj,'New_Frame',true,'rising edge'); % data_out signal is the end of frame detection
data_out(1:128) = step(DataCaptureObj);
% end
if (data_out(61) == 5)
    disp('blue')
elseif (data_out(61) == 3)
    disp('green')
elseif (data_out(61) == 1)
    disp('red')
end
hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
% b = reshape(hbytes(1:end), [w,h])';
% g = reshape(hbytes(1:end), [w,h])';
% r = reshape(hbytes(1:end), [w,h])';

% imgh = cat(3, r,g,b);
% pause(0.01); 

% set(handles.image,'CData',imgh);
%  
% fullimage=imgh;
% 
% if lock == 3
%     setgraph(handles,handles.axes2);
% else
% end
    
end