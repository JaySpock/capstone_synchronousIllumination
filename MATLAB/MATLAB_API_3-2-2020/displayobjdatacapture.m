function displayobjdatacapture(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock w h DataCaptureObj data_last data_out i

% 
    hbytes=uint8(inbytes.GetImageData.GetProcessedDataARGBByte);
    b = reshape(hbytes(1:4:end), [w,h])';
    g = reshape(hbytes(2:4:end), [w,h])';
    r = reshape(hbytes(3:4:end), [w,h])';
    imgh = cat(3, r,g,b);
    
    evalc('data_out(1:128) = step(DataCaptureObj)');
    if (data_out(1) == 7 && data_last == 9)
        data_last = 7;
%         imwrite(imgh,'redimage.jpeg');
%         toc
        disp('red');
    elseif (data_out(1) == 8 && data_last == 7)
        data_last = 8;
%         toc
%         imwrite(imgh,'greenimage.jpeg');
        disp('green');
    elseif (data_out(1) == 9 && data_last == 8)
%         imwrite(imgh,'blueimage.jpeg');
        data_last = 9;
%         toc
        disp('blue');
    else 
%         disp('missed frame');
%         disp(i);
    end;
    disp(i);
    i = i+1;
    
% hbytes=uint8(inbytes.GetImageData.GetProcessedDataARGBByte);
% b = reshape(hbytes(1:4:end), [w,h])';
% g = reshape(hbytes(2:4:end), [w,h])';
% r = reshape(hbytes(3:4:end), [w,h])';

% imgh = cat(3, r,g,b);
% pause(0.001); 
% 
% set(handles.image,'CData',imgh);
 
fullimage=imgh;

if lock == 3
    setgraph(handles,handles.axes2);
else
end
    
end