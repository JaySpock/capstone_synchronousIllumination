function displayobjBlueCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock BlueOn BlueOff BlueZero

img=double(inbytes.GetImageData.GetRawPixels1Byte);

% if (img(20) < 50) && (img(62480) > 200)
%     BlueOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     BlueOff = img;
% elseif any(img > 50)
%     BlueZero = img;
% end

imgh = reshape(img(), [250,250]);
set(handles.image,'CData',imgh);
fullimage=img;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end