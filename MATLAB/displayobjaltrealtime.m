function displayobjaltrealtime(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock w h

for i = 1:3

    hbytes=uint8(inbytes.GetImageData.GetProcessedDataARGBByte);
    b = reshape(hbytes(1:4:end), [w,h])';
    g = reshape(hbytes(2:4:end), [w,h])';
    r = reshape(hbytes(3:4:end), [w,h])';

    imgh = cat(3, r,g,b);
    pause(0.01); 

    % Set the image that is displayed as imgh
    % set(handles.image,'CData',imgh);
    % fullimage=imgh;
    
    % Save three consecutive frames as individual jpeg files
    filename = strcat(int2str(i),'.jpeg');
    imwrite(imgh,filename,'JPEG');

    
if lock == 3
    setgraph(handles,handles.axes2);
else
end
    
end

% Utilize ImageRecontructRealTime function to create single final image
imga = ImageRecontructRealTime('1.jpeg','2.jpeg','3.jpeg');

% Set the image that is displayed as imga
set(handles.image,'CData',imga);
fullimage=imga;
    
end