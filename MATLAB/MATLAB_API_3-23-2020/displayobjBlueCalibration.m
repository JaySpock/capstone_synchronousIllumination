function displayobjBlueCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock BlueOn BlueOff BlueZero next Blue1 Blue2 Blue3

img=uint8(inbytes.GetImageData.GetRawPixels1Byte);

switch next
    case 'First'
        Blue1 = reshape(img(), [250,250]);
        next = 'Second';
    case 'Second'
        Blue2 = reshape(img(), [250,250]);
        next = 'Third';
    case 'Third'
        Blue3 = reshape(img(), [250,250]);
%         save('Blue1_2mm.mat','Blue1');
%         save('Blue2_2mm.mat','Blue2');
%         save('Blue3_2mm.mat','Blue3');
        tiledlayout(1,3)
        nexttile
        image(Blue1);
        nexttile
        image(Blue2);
        nexttile
        image(Blue3);
        
        order1 = input('Enter (1) if the first image is blue turning on, (2) if blue turning off, or (3) if completely off:  ');
        order2 = input('Enter (1) if the second image is blue turning on, (2) if blue turning off, or (3) if completely off:  ');
        
        if order1 == 1
            BlueOn = Blue1;
                if order2 == 2
                    BlueOff = Blue2;
                    BlueZero = Blue3;
                elseif order2 == 3
                    BlueZero = Blue2;
                    BlueOff = Blue3;
                end
        elseif order1 == 2
            BlueOff = Blue1;
                if order2 == 1
                    BlueOn = Blue2;
                    BlueZero = Blue3;
                elseif order2 == 3
                    BlueZero = Blue2;
                    BlueOn = Blue3;
                end
        elseif order1 == 3
            BlueZero = Blue1;
                if order2 == 1
                    BlueOn = Blue2;
                    BlueOff = Blue3;
                elseif order2 == 2
                    BlueOff = Blue2;
                    BlueOn = Blue3;
                end   
        end
        next = 'Done';
    case 'Done'
end


% if (img(20) < 50) && (img(62480) > 200)
%     BlueOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     BlueOff = img;
% elseif any(img > 50)
%     BlueZero = img;
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