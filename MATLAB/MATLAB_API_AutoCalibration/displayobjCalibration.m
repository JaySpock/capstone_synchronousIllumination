function displayobjCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock FPGA ZeroCal RedOn RedOff RedZero GreenOn GreenOff GreenZero BlueOn BlueOff BlueZero

hbytes=double(inbytes.GetImageData.GetRawPixels1Byte);
img = reshape(hbytes(), [250,250]);

input = readmemory(FPGA,16400,1);

if (input == 0) %all leds off
    ZeroCal = hbytes;
elseif (input == 1) %red on
    RedOn = hbytes;
elseif (input == 2) %red off
    RedOff = hbytes;
elseif (input == 3) %red staying off
    RedZero = hbytes;
elseif (input == 4) %green on
    GreenOn = hbytes;
elseif (input == 5) %green off
    GreenOff = hbytes;
elseif (input == 6) %green staying off
    GreenZero = hbytes;
elseif (input == 7) %blue on
    BlueOn = hbytes;
elseif (input == 8) %blue off
    BlueOff = hbytes;
elseif (input == 9) %blue staying off
    BlueZero = hbytes;
elseif (input == 13) %error in FPGA code
    disp("Error in FPGA code");
elseif ((input < 13) && (input > 9))
    disp("Uh oh! We're in normal run mode");
else
    disp("Unknown value being read in");
end
    

pause(0.01);
set(handles.image,'CData',img); 
fullimage=img;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end