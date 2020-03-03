`function displayobjaltrealcat(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock w h a s



%writeDigitalPin(a, 'D13', 0);

    write(s,1,"uint8"); %writeDigitalPin(a, 'D5', 1); %turn on red
    %don't need a pause because all the time is taken by
    %writing to arduino pins, not reading in image data
    %writeDigitalPin(a, 'D5', 0); %turn off red
    write(s,2,"uint8");%writeDigitalPin(a, 'D7', 1); %turn on green
    
    %RED
    hbytes=uint8(inbytes.GetImageData.GetProcessedDataARGBByte);
    img1 = reshape(hbytes(1:4:end), [w,h])'; %this range of bits corresponds to the red values for de-bayered pixels
    %pause(0.01); this was originally in the code but may not be necessary
    
    %writeDigitalPin(a, 'D7', 0); %turn off green
    write(s,3,"uint8");%writeDigitalPin(a, 'D4', 1); %turn on blue
    
    %GREEN
    hbytes=uint8(inbytes.GetImageData.GetProcessedDataARGBByte);
    img2 = reshape(hbytes(1:4:end), [w,h])';
    %pause(0.01); 
    
    %writeDigitalPin(a, 'D4', 0); %turn off blue
    %writeDigitalPin(a, 'D5', 1); %turn on red
    
    %BLUE
    hbytes=uint8(inbytes.GetImageData.GetProcessedDataARGBByte);
    img3 = reshape(hbytes(1:4:end), [w,h])';
    %pause(0.01); 
    
    
if lock == 3
    setgraph(handles,handles.axes2);
else
end

% Blinks the onboard Arduino LED every three frames
% writeDigitalPin(a, 'D13', 0);
% pause(0.03);
% writeDigitalPin(a, 'D13', 1);

%concatenates the three images into one taking each as r,g,b respectively
imga = cat(3,img1,img2,img3);

%writeDigitalPin(a, 'D13', 1);


%displays the merged image
set(handles.image,'CData',imga);
fullimage=imga;

  
end