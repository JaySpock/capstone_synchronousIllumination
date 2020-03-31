function displayobjCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock FPGA ZeroCal RedOn RedOff GreenOn GreenOff BlueOn BlueOff

hbytes=double(inbytes.GetImageData.GetRawPixels1Byte);
img = reshape(hbytes(), [250,250]);

input = readmemory(FPGA,16400,1);

if (input == 0) %all leds off
    ZeroCal = hbytes;
elseif (input == 1) %red on
    RedOn = hybtes;
elseif (input == 2) %red off
    RedOff = hbytes;
elseif (input == 3) %green on
    GreenOn = hbytes;
elseif (input == 4) %green off
    GreenOff = hbytes;
elseif (input == 5) %blue on
    BlueOn = hbytes;
elseif (input == 6) %blue off
    BlueOff = hbytes;
elseif (input == 10) %error in FPGA code
    disp("Error in FPGA code");
else
    disp("Not in calibration mode");
end
    

pause(0.01);
set(handles.image,'CData',img); 
fullimage=img;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end