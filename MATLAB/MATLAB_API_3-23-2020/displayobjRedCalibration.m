function displayobjRedCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock RedOn RedOff RedZero

img=double(inbytes.GetImageData.GetRawPixels1Byte);

if (img(20) < 50) && (img(62480) > 200)
    RedOn = img;
elseif (img(20) > 50) && (img(62480) < 200)
    RedOff = img;
elseif any(img > 50)
    RedZero = img;
end

imgh = reshape(img(), [250,250]);
set(handles.image,'CData',imgh); 
fullimage=imgh;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end