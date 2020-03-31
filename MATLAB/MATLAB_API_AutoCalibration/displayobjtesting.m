function displayobjtesting(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector.
global fullimage lock w h caliRed caliGreen caliBlue A B C frameOrder nextFrame record v r g b imgh

%Normal operation, updates every frame
switch nextFrame
    case 'One' %signal for blue to red
        A = uint8(inbytes.GetImageData.GetRawPixels1Byte);
        r = reshape(A(), [250,250]);
    switch frameOrder
        case frameOrder == 1
            imgh = cat(3, r,g,b);
        case frameOrder == 2
            imgh = cat(3, g,b,r);
        case frameOrder == 3
            imgh = cat(3, b,r,g);
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
        B = uint8(inbytes.GetImageData.GetRawPixels1Byte);
        g = reshape(B(), [250,250]);
    switch frameOrder
        case frameOrder == 1
            imgh = cat(3, r,g,b);
        case frameOrder == 2
            imgh = cat(3, g,b,r);
        case frameOrder == 3
            imgh = cat(3, b,r,g);
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
        C = uint8(inbytes.GetImageData.GetRawPixels1Byte);
        b = reshape(C(), [250,250]);
    switch frameOrder
        case frameOrder == 1
            imgh = cat(3, r,g,b);
        case frameOrder == 2
            imgh = cat(3, g,b,r);
        case frameOrder == 3
            imgh = cat(3, b,r,g);
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
