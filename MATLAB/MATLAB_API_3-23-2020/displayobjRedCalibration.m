function displayobjRedCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global keeprunred fullimage lock RedOn RedOff RedZero next Red1 Red2 Red3 Red4 Red1_img Red2_img Red3_img Red4_img

%img=uint8(inbytes.GetImageData.GetRawPixels1Byte);
keeprunred = true;
while keeprunred
switch next
    case 'First'
        Red1 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red1_img = reshape(Red1(), [250,250]);
        pause(0.006);
        next = 'First';
        keeprunred = false;
    case 'Second'
        Red2 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red2_img = reshape(Red2(), [250,250]);
        pause(0.006);
        next = 'Second';
        keeprunred = false;
    case 'Third'
        Red3 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red3_img = reshape(Red3(), [250,250]);
        pause(0.006);
        next = 'Third';
        keeprunred = false;
    case 'Fourth'
        Red4 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red4_img = reshape(Red4(), [250,250]);
%         save('Red1_2mm.mat','Red1');
%         save('Red2_2mm.mat','Red2');
%         save('Red3_2mm.mat','Red3');
        tiledlayout(1,4)
        nexttile
        image(Red1_img); title('1');
        nexttile
        image(Red2_img); title('2');
        nexttile
        image(Red3_img); title('3');
        nexttile
        image(Red4_img); title('4');
        
        oninput = input('Which figure represents red turning on?  ');
        switch oninput
            case 1
                RedOn = Red1;
            case 2
                RedOn = Red2;
            case 3
                RedOn = Red3;
            case 4
                RedOn = Red4;
        end
        offinput = input('Which figure represents red turning off?  ');
        switch offinput
            case 1
                RedOff = Red1;
            case 2
                RedOff = Red2;
            case 3
                RedOff = Red3;
            case 4
                RedOff = Red4;
        end
        zeroinput = input('Which figure represents red completely off?  ');
        switch zeroinput
            case 1
                RedZero = Red1;
            case 2
                RedZero = Red2;
            case 3
                RedZero = Red3;
            case 4
                RedZero = Red4;
        end
        
        next = 'Done';
        keeprunred = false;
        
    case 'Done'
%         img = uint8(inbytes.GetImageData.GetRawPixels1Byte);
%         imgh = reshape(img(), [250,250]);
%         pause(0.01);
%         set(handles.image,'CData',imgh); 
%         fullimage=imgh;
        keeprunred = false;
end
end

% if (img(20) < 50) && (img(62480) > 200)
%     RedOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     RedOff = img;
% elseif any(img > 50)
%     RedZero = img;
% end


% imgh = reshape(img(), [250,250]);
% pause(0.01);
% set(handles.image,'CData',imgh); 
% fullimage=imgh;
% 
% 
% if lock == 3
%     setgraph(handles,handles.axes2);
% else
% end

% figure;
% exported_fig=gca;
% copyobj(allchild(handles.axes1), exported_fig);
% axis(exported_fig,'tight','square');
% axis off;

end