function displayobjfinal(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector.
global fullimage lock w h caliRed caliGreen caliBlue A B C frameOrder nextFrame

%Normal operation, updates every frame
switch nextFrame
    case 'One' %signal for blue to red
        A = double(inbytes.GetImageData.GetRawPixels1Byte);
        ABC = cat(2,A',B',C'); 
        Red = sum(ABC.*caliRed,2);
            r = reshape(Red(), [w,h]);
        Green = sum(ABC.*caliGreen,2);
            g = reshape(Green(), [w,h]);
        Blue = sum(ABC.*caliBlue,2);
            b = reshape(Blue(), [w,h]);
        if frameOrder == 1
            img = cat(3, r,g,b); 
        elseif frameOrder == 2
            img = cat(3, g,b,r);
        elseif frameOrder == 3
            img = cat(3, b,r,g);
        end
        set(handles.image,'CData',img); 
        if lock == 3 %just for histogram?
            setgraph(handles,handles.axes2);
        else  
        end
        fullimage=img;
        nextFrame = 'Two';
        
    case 'Two' %signal for red to green
        B = double(inbytes.GetImageData.GetRawPixels1Byte);
        ABC = cat(2,A',B',C'); 
        Red = sum(ABC.*caliRed,2);
            r = reshape(Red(), [w,h]);
        Green = sum(ABC.*caliGreen,2);
            g = reshape(Green(), [w,h]);
        Blue = sum(ABC.*caliBlue,2);
            b = reshape(Blue(), [w,h]);
        if frameOrder == 1
            img = cat(3, r,g,b);
        elseif frameOrder == 2
            img = cat(3, g,b,r);
        elseif frameOrder == 3
            img = cat(3, b,r,g);
        end
        set(handles.image,'CData',img);
        if lock == 3
            setgraph(handles,handles.axes2);
        else  
        end
        fullimage=img;
        nextFrame = 'Three';
        
    case 'Three' %signal for green to blue
        C = double(inbytes.GetImageData.GetRawPixels1Byte);
        ABC = cat(2,A',B',C');
        Red = sum(ABC.*caliRed,2);
            r = reshape(Red(), [w,h]);
        Green = sum(ABC.*caliGreen,2);
            g = reshape(Green(), [w,h]);
        Blue = sum(ABC.*caliBlue,2);
            b = reshape(Blue(), [w,h]);
        if frameOrder == 1
            img = cat(3, r,g,b);
        elseif frameOrder == 2
            img = cat(3, g,b,r);
        elseif frameOrder == 3
            img = cat(3, b,r,g);
        end
        set(handles.image,'CData',img);
        fullimage=img;
        if lock == 3
            setgraph(handles,handles.axes2);
        else  
        end
        nextFrame = 'One';
end
end
