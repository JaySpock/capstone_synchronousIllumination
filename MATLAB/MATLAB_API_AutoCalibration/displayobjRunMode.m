function displayobjRunMode(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector.
global fullimage lock w h FPGA caliRed caliGreen caliBlue A B C frameOrder record v r g b

hbytes = double(inbytes.GetImageData.GetRawPixels1Byte);
input = readmemory(FPGA,16400,1);

if (input == 10) %Blue off, red on
        A = hbytes;
        ABC = cat(2,A',B',C'); 
        Red = sum(ABC.*caliRed,2);
            r = reshape(Red(), [w,h]);
        Green = sum(ABC.*caliGreen,2);
            g = reshape(Green(), [w,h]);
        Blue = sum(ABC.*caliBlue,2);
            b = reshape(Blue(), [w,h]);
        
elseif (input == 11) %red off, green on
        B = hbytes;
        ABC = cat(2,A',B',C'); 
        Red = sum(ABC.*caliRed,2);
            r = reshape(Red(), [w,h]);
        Green = sum(ABC.*caliGreen,2);
            g = reshape(Green(), [w,h]);
        Blue = sum(ABC.*caliBlue,2);
            b = reshape(Blue(), [w,h]);
        
elseif (input == 12) %green off, blue on
        C = hbytes;
        ABC = cat(2,A',B',C');
        Red = sum(ABC.*caliRed,2);
            r = reshape(Red(), [w,h]);
        Green = sum(ABC.*caliGreen,2);
            g = reshape(Green(), [w,h]);
        Blue = sum(ABC.*caliBlue,2);
            b = reshape(Blue(), [w,h]);
elseif (input == 13)
    disp("Error in FPGA code");
else
    disp("Something's wrong");
end

if frameOrder == 1
    imgh = cat(3, r,g,b);
    idmax = find(imgh > 1);
    idmin = find(imgh < 0);
    imgh(idmax) = 1;
    imgh(idmin) = 0;
elseif frameOrder == 2
    imgh = cat(3, g,b,r);
    idmax = find(imgh > 1);
    idmin = find(imgh < 0);
    imgh(idmax) = 1;
    imgh(idmin) = 0;
elseif frameOrder == 3
    imgh = cat(3, b,r,g);
    idmax = find(imgh > 1);
    idmin = find(imgh < 0);
    imgh(idmax) = 1;
    imgh(idmin) = 0;
end

if record == 1
    writeVideo(v,imgh);
else
end

set(handles.image,'CData',imgh);
fullimage=imgh;

if lock == 3
    setgraph(handles,handles.axes2);
else  
end

end
