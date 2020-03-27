function displayobjRedCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock RedOn RedOff RedZero next Red1 Red2 Red3

img=uint8(inbytes.GetImageData.GetRawPixels1Byte);

switch next
    case 'First'
        Red1 = reshape(img(), [250,250]);
        next = 'Second';
    case 'Second'
        Red2 = reshape(img(), [250,250]);
        next = 'Third';
    case 'Third'
        Red3 = reshape(img(), [250,250]);
%         save('Red1_2mm.mat','Red1');
%         save('Red2_2mm.mat','Red2');
%         save('Red3_2mm.mat','Red3');
        tiledlayout(1,3)
        nexttile
        image(Red1);
        nexttile
        image(Red2);
        nexttile
        image(Red3);
        
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
    case 'Done'
end


% if (img(20) < 50) && (img(62480) > 200)
%     RedOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     RedOff = img;
% elseif any(img > 50)
%     RedZero = img;
% end


imgh = reshape(img(), [250,250]);
pause(0.012);
set(handles.image,'CData',imgh); 
fullimage=imgh;


if lock == 3
    setgraph(handles,handles.axes2);
else
end

% figure;
% exported_fig=gca;
% copyobj(allchild(handles.axes1), exported_fig);
% axis(exported_fig,'tight','square');
% axis off;

end