function displayobjRedCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock RedOn RedOff RedZero next Red1 Red2 Red3 Red4

img=double(inbytes.GetImageData.GetRawPixels1Byte);

switch next
    case 'First'
        Red1 = img;
        next = 'Second';
    case 'Second'
        Red2 = img;
        next = 'Third';
    case 'Third'
        Red3 = img;
        next = 'Fourth';
    case 'Fourth'
        Red4 = img;
        next = 'First';
end
% if (img(20) < 50) && (img(62480) > 200)
%     RedOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     RedOff = img;
% elseif any(img > 50)
%     RedZero = img;
% end

imgh = reshape(img(), [250,250]);
set(handles.image,'CData',imgh); 
fullimage=imgh;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end