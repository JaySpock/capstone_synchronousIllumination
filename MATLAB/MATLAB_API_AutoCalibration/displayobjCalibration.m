function displayobjCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock FPGA ZeroCal RedOn RedOff RedZero GreenOn GreenOff GreenZero BlueOn BlueOff BlueZero RedOnimg RedOffimg RedZeroimg GreenOnimg GreenOffimg GreenZeroimg BlueOnimg BlueOffimg BlueZeroimg

hbytes=double(inbytes.GetImageData.GetRawPixels1Byte);
img = reshape(hbytes(), [250,250]);

input = readmemory(FPGA,16400,1);

if (input == 0) %all leds off
    ZeroCal = hbytes;
elseif (input == 1) %red on
    RedOn = hbytes;
    RedOnimg = reshape(RedOn(), [250,250]);
    %save('RedOn.mat','RedOnimg');
elseif (input == 2) %red off
    RedOff = hbytes;
    RedOffimg = reshape(RedOff(), [250,250]);
    %save('RedOff.mat','RedOffimg');
elseif (input == 3) %red staying off
    RedZero = hbytes;
    RedZeroimg = reshape(RedZero(), [250,250]);
    %save('RedZero.mat','RedZeroimg');
elseif (input == 4) %green on
    GreenOn = hbytes;
    GreenOnimg = reshape(GreenOn(), [250,250]);
    %save('GreenOn.mat','GreenOnimg');
elseif (input == 5) %green off
    GreenOff = hbytes;
    GreenOffimg = reshape(GreenOff(), [250,250]);
    %save('GreenOff.mat','GreenOffimg');
elseif (input == 6) %green staying off
    GreenZero = hbytes;
    GreenZeroimg = reshape(GreenZero(), [250,250]);
    %save('GreenZero.mat','GreenZeroimg');
elseif (input == 7) %blue on
    BlueOn = hbytes;
    BlueOnimg = reshape(BlueOn(), [250,250]);
    %save('BlueOn.mat','BlueOnimg');
elseif (input == 8) %blue off
    BlueOff = hbytes;
    BlueOffimg = reshape(BlueOff(), [250,250]);
    %save('BlueOff.mat','BlueOffimg');
elseif (input == 9) %blue staying off
    BlueZero = hbytes;
    BlueZeroimg = reshape(BlueZero(), [250,250]);
    %save('BlueZero.mat','BlueZeroimg');
elseif (input == 13) %error in FPGA code
    disp("Error in FPGA code");
else
    disp("Not in calibration mode");
end
    

%pause(0.01);
set(handles.image,'CData',img); 
fullimage=img;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end