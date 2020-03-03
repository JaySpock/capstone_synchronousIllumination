function displayobjtesting(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock w h s

%Arduino testing code
% write(s,1,"uint8");
% %fprintf(s,'%i\n',1); %writeDigitalPin(a, 'D5', 1); %turn on red
% hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
% r = reshape(hbytes(), [w,h]);
% 
% write(s,2,"uint8");
% %fprintf(s,'%i\n',2);%writeDigitalPin(a, 'D7', 1); %turn on green
% hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
% g = reshape(hbytes(), [w,h]);
% 
% write(s,3,"uint8");
% %fprintf(s,'%i\n',3);%writeDigitalPin(a, 'D4', 1); %turn on blue
% hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
% b = reshape(hbytes(), [w,h]);
% 
% %fprintf(s,'%i\n',4); %turn off all LEDs
% write(s,4,"uint8");


% Normal operation switching statement option A, case and if else
% statements seem to be the same according to online sources for MATLAB
% switch serialIn
%     case 001
%         A = reshape(hbytes(), [w,h]);
%     case 010
%         B = reshape(hbytes(), [w,h]);
%     case 100
%         C = reshape(hbytes(), [w,h]);
% end


% Calibration sequence detection option 1
% if serialIn == 110 % "red" signal from FPGA, the serialIn will need to be made whatever process Elijah finds
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     Ron = reshape(hbytes(), [w,h]);
%     Ronnorm = (1/255)*Ron; % There should be enough time for these to compute while waiting for the next frame from the camera
%     Roninv = inv(Ronnorm);
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     Roff = reshape(hbytes(), [w,h]);
%     Roffnorm = (1/255)*Roff;
%     Roffinv = inv(Roffnorm);
% elseif serialIn == 101 % "green" signal
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     Gon = reshape(hbytes(), [w,h]);
%     Gonnorm = (1/255)*Gon;
%     Goninv = inv(Gonnorm);
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     Goff = reshape(hbytes(), [w,h]);
%     Goffnorm = (1/255)*Goff;
%     Goffinv = inv(Goffnorm);
% elseif serialIn == 011 % "blue" signal
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     Bon = reshape(hbytes(), [w,h]);
%     Bonnorm = (1/255)*Bon;
%     Boninv = inv(Bonnorm);
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     Boff = reshape(hbytes(), [w,h]);
%     Boffnorm = (1/255)*Boff;
%     Boffinv = inv(Boffnorm);
% end


%Calibration sequence option 2
if serialIn == 110 % "red" signal from FPGA, the serialIn will need to be made whatever process Elijah finds
    Ron = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    caliRedOn = %maybe need to do all this calculations at the end of calibration
    Roff = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    caliRedOff = 
elseif serialIn == 101 % "green" signal
    Gon = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    caliGreenOn = 
    Goff = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    caliGreenOff = 
elseif serialIn == 011 % "blue" signal
    Bon = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    caliBlueOn = 
    Boff = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    caliBlueOff = 
end


% Normal operation switching statement option 1, updates every 3 frames
% if serialIn == 001 %signal for blue to red
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     A = reshape(hbytes(), [w,h]);
%     Ared = Roninv*A; %check out this warning about the speed of inv*
%     Ablue = Boffinv*A;
%     % Agreen should always be zero so just don't include it in anything? -
%     % but read it in for the FPGA code right now?
% elseif serialIn == 010 %signal for red to green
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     B = reshape(hbytes(), [w,h]);
%     Bred = Roffinv*B;
%     Bgreen = Goninv*B;
% elseif serialIn == 100 %signal for green to blue
%     hbytes=uint8(inbytes.GetImageData.GetRawPixels1Byte);
%     C = reshape(hbytes(), [w,h]);
%     Cblue = Boninv*C;
%     Cgreen = Goffinv*C; % need to add in a dark mode as well
% end

%Normal operation option 2, updates every frame
if serialIn == 001 %signal for blue to red
    A = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    ABC = cat(2,A',B',C'); %need to define A,B,and C on startup sometime, make global?
    R = sum(ABC.*caliRedOn,2);
        r = reshape(R(), [w,h]);
    G = sum(ABC.*caliGreenZero,2);
        g = reshape(G(), [w,h]);
    B = sum(ABC.*caliBlueOff,2);
        b = reshape(B(), [w,h]);
    img = cat(3, r,g,b); %take these three lines out at the end of the code, just call at the end of every if statement
    set(handles.image,'CData',img); 
    fullimage=img;
elseif serialIn == 010 %signal for red to green
    B = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    ABC = cat(2,A',B',C'); %need to define A,B,and C on startup sometime
    R = sum(ABC.*caliRedOff,2);
        r = reshape(R(), [w,h]);
    G = sum(ABC.*caliGreenOn,2);
        g = reshape(G(), [w,h]);
    B = sum(ABC.*caliBlueZero,2);
        b = reshape(B(), [w,h]);
    img = cat(3, r,g,b); %take these three lines out at the end of the code, just call at the end of every if statement
    set(handles.image,'CData',img); 
    fullimage=img;
elseif serialIn == 100 %signal for green to blue
    C = uint8(inbytes.GetImageData.GetRawPixels2Byte);
    ABC = cat(2,A',B',C'); %need to define A,B,and C on startup sometime
    R = sum(ABC.*caliRedZero,2);
        r = reshape(R(), [w,h]);
    G = sum(ABC.*caliGreenOff,2);
        g = reshape(G(), [w,h]);
    B = sum(ABC.*caliBlueOn,2);
        b = reshape(B(), [w,h]);
    img = cat(3, r,g,b); %take these three lines out at the end of the code, just call at the end of every if statement
    set(handles.image,'CData',img); 
    fullimage=img;
end

%Required for switching option 1, updates every 3 frames
% r = Ared + Bred; % assuming the other terms are zero
% g = Bgreen + Cgreen;
% b = Ablue + Cblue;
% 
% imgh = cat(3, r,g,b);
% %pause(0.01); 
% 
% set(handles.image,'CData',imgh); 
% fullimage=imgh;

if lock == 3
    setgraph(handles,handles.axes2);
else
end

end