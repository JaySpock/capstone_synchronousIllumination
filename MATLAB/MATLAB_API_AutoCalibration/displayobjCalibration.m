function displayobjCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock FPGA previousin previousimg ZeroCal RedOn RedOff RedZero GreenOn GreenOff GreenZero BlueOn BlueOff BlueZero RedOnimg RedOffimg RedZeroimg GreenOnimg GreenOffimg GreenZeroimg BlueOnimg BlueOffimg BlueZeroimg

hbytes=double(inbytes.GetImageData.GetRawPixels1Byte);
img = reshape(hbytes(), [250,250]).';
different = find(img ~= previousimg);

if (size(different,1) > 40000)

    previousimg = img;
    
    while true
        input = readmemory(FPGA,16400,1);
        pause(0.0001);
        if (input ~= previousin)
            previousin = input;
            break;
        end       
    end

    switch input
        case 0 %all leds off
        ZeroCal = hbytes;
        case 1 %red on
        RedOn = hbytes;
        RedOnimg = img;
        case 2 %red off
        RedOff = hbytes;
        RedOffimg = img;
        case 3 %red staying off
        RedZero = hbytes;
        RedZeroimg = img;
        case 4 %green on
        GreenOn = hbytes;
        GreenOnimg = img;
        case 5 %green off
        GreenOff = hbytes;
        GreenOffimg = img;
        case 6 %green staying off
        GreenZero = hbytes;
        GreenZeroimg = img;
        case 7 %blue on
        BlueOn = hbytes;
        BlueOnimg = img;
        case 8 %blue off
        BlueOff = hbytes;
        BlueOffimg = img;
        case 9 %blue staying off
        BlueZero = hbytes;
        BlueZeroimg = img;
        case 13 %error in FPGA code
        disp("Error in FPGA code");
        otherwise
        disp("Not in calibration mode");
    end    
    
    
%     if (input == 0) %all leds off
%         ZeroCal = hbytes;
%     elseif (input == 1) %red on
%         RedOn = hbytes;
%         RedOnimg = img;
%     elseif (input == 2) %red off
%         RedOff = hbytes;
%         RedOffimg = img;
%     elseif (input == 3) %red staying off
%         RedZero = hbytes;
%         RedZeroimg = img;
%     elseif (input == 4) %green on
%         GreenOn = hbytes;
%         GreenOnimg = img;
%     elseif (input == 5) %green off
%         GreenOff = hbytes;
%         GreenOffimg = img;
%     elseif (input == 6) %green staying off
%         GreenZero = hbytes;
%         GreenZeroimg = img;
%     elseif (input == 7) %blue on
%         BlueOn = hbytes;
%         BlueOnimg = img;
%     elseif (input == 8) %blue off
%         BlueOff = hbytes;
%         BlueOffimg = img;
%     elseif (input == 9) %blue staying off
%         BlueZero = hbytes;
%         BlueZeroimg = img;
%     elseif (input == 13) %error in FPGA code
%         disp("Error in FPGA code");
%     else
%         disp("Not in calibration mode");
%     end

    set(handles.image,'CData',img); 
    fullimage=img;

    if lock == 3
        setgraph(handles,handles.axes2);
    else
    end
    
else
    pause(0.001);
end
end