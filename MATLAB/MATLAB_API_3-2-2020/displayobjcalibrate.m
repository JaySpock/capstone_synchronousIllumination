function displayobjcalibrate(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock w h

hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
img = reshape(hbytes(), [w,h]);
pause(0.01); 

if serialIn == 110 %red signal from FPGA
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgR1 = reshape(hbytes(), [w,h]);
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgR2 = reshape(hbytes(), [w,h]);
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgR3 = reshape(hbytes(), [w,h]);
elseif serialIn == 101
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgG1 = reshape(hbytes(), [w,h]);
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgG2 = reshape(hbytes(), [w,h]);
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgG3 = reshape(hbytes(), [w,h]);
elseif serialIn == 011
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgB1 = reshape(hbytes(), [w,h]);
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgB2 = reshape(hbytes(), [w,h]);
    hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
    imgB3 = reshape(hbytes(), [w,h]);
end

set(handles.image,'CData',img); 
fullimage=img;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end