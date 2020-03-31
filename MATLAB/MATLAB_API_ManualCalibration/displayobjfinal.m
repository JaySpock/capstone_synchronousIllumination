function displayobjfinal(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector.
global fullimage lock w h caliRed caliGreen caliBlue A B C frameOrder nextFrame record v

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
        if lock == 3 %just for histogram?
            setgraph(handles,handles.axes2);
        else  
        end
        fullimage=imgh;
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
        end
        set(handles.image,'CData',imgh);
        if lock == 3
            setgraph(handles,handles.axes2);
        else  
        end
        fullimage=imgh;
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
        end
        set(handles.image,'CData',imgh);
        fullimage=imgh;
        if lock == 3
            setgraph(handles,handles.axes2);
        else  
        end
        nextFrame = 'One';
end
end
