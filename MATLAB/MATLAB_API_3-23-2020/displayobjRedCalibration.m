function displayobjRedCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global keeprunred fullimage lock RedOn RedOff RedZero next Red0 Red1 Red2 Red3 Red0_img Red1_img Red2_img Red3_img

%img=uint8(inbytes.GetImageData.GetRawPixels1Byte);
keeprunred = true;
while keeprunred
switch next
    case 'Zeroth'
        Red0 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red0_img = reshape(Red0(), [250,250]);
        pause(0.005);
        next = 'First';
        keeprunred = false;
    case 'First'
        Red1 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red1_img = reshape(Red1(), [250,250]);
        pause(0.005);
        next = 'Second';
        keeprunred = false;
    case 'Second'
        Red2 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red2_img = reshape(Red2(), [250,250]);
        pause(0.005);
        next = 'Third';
        keeprunred = false;
    case 'Third'
        Red3 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Red3_img = reshape(Red3(), [250,250]);
%         save('Red1_2mm.mat','Red1');
%         save('Red2_2mm.mat','Red2');
%         save('Red3_2mm.mat','Red3');
        tiledlayout(1,4)
        nexttile
        image(Red0_img);
        nexttile
        image(Red1_img);
        nexttile
        image(Red2_img);
        nexttile
        image(Red3_img);
        
        order1 = input('Enter (1) if the first image is red turning on, (2) if red turning off, or (3) if completely off:  ');
        order2 = input('Enter (1) if the second image is red turning on, (2) if red turning off, or (3) if completely off:  ');
        
        if order1 == 1
            RedOn = Red1;
                if order2 == 2
                    RedOff = Red2;
                    RedZero = Red3;
                elseif order2 == 3
                    RedZero = Red2;
                    RedOff = Red3;
                end
        elseif order1 == 2
            RedOff = Red1;
                if order2 == 1
                    RedOn = Red2;
                    RedZero = Red3;
                elseif order2 == 3
                    RedZero = Red2;
                    RedOn = Red3;
                end
        elseif order1 == 3
            RedZero = Red1;
                if order2 == 1
                    RedOn = Red2;
                    RedOff = Red3;
                elseif order2 == 2
                    RedOff = Red2;
                    RedOn = Red3;
                end   
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