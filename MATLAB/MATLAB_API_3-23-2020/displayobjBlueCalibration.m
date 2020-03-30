function displayobjBlueCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global keeprunBlue fullimage lock BlueOn BlueOff BlueZero next Blue1 Blue2 Blue3 Blue4 Blue1_img Blue2_img Blue3_img Blue4_img

%img=uint8(inbytes.GetImageData.GetRawPixels1Byte);
keeprunBlue = true;
while keeprunBlue
switch next
    case 'First'
        Blue1 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Blue1_img = reshape(Blue1(), [250,250]);
        pause(0.005);
        next = 'Second';
        keeprunBlue = false;
    case 'Second'
        Blue2 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Blue2_img = reshape(Blue2(), [250,250]);
        pause(0.005);
        next = 'Third';
        keeprunBlue = false;
    case 'Third'
        Blue3 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Blue3_img = reshape(Blue3(), [250,250]);
        pause(0.005);
        next = 'Fourth';
        keeprunBlue = false;
    case 'Fourth'
        Blue4 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Blue4_img = reshape(Blue4(), [250,250]);
%         save('Blue1_2mm.mat','Blue1');
%         save('Blue2_2mm.mat','Blue2');
%         save('Blue3_2mm.mat','Blue3');
        tiledlayout(1,4)
        nexttile
        image(Blue1_img); title('1');
        nexttile
        image(Blue2_img); title('2');
        nexttile
        image(Blue3_img); title('3');
        nexttile
        image(Blue4_img); title('4');
        
        oninput = input('Which figure represents blue turning on?  ');
        switch oninput
            case 1
                BlueOn = Blue1;
            case 2
                BlueOn = Blue2;
            case 3
                BlueOn = Blue3;
            case 4
                BlueOn = Blue4;
        end
        offinput = input('Which figure represents blue turning off?  ');
        switch offinput
            case 1
                BlueOff = Blue1;
            case 2
                BlueOff = Blue2;
            case 3
                BlueOff = Blue3;
            case 4
                BlueOff = Blue4;
        end
        zeroinput = input('Which figure represents blue completely off?  ');
        switch zeroinput
            case 1
                BlueZero = Blue1;
            case 2
                BlueZero = Blue2;
            case 3
                BlueZero = Blue3;
            case 4
                BlueZero = Blue4;
        end
        
        next = 'Done';
        keeprunBlue = false;
        
    case 'Done'
%         img = uint8(inbytes.GetImageData.GetRawPixels1Byte);
%         imgh = reshape(img(), [250,250]);
%         pause(0.01);
%         set(handles.image,'CData',imgh); 
%         fullimage=imgh;
        keeprunBlue = false;
end
end

% if (img(20) < 50) && (img(62480) > 200)
%     BlueOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     BlueOff = img;
% elseif any(img > 50)
%     BlueZero = img;
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