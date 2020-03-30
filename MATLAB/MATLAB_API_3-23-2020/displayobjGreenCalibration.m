function displayobjGreenCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global keeprunGreen fullimage lock GreenOn GreenOff GreenZero next Green1 Green2 Green3 Green4 Green1_img Green2_img Green3_img Green4_img

%img=uint8(inbytes.GetImageData.GetRawPixels1Byte);
keeprunGreen = true;
while keeprunGreen
switch next
    case 'First'
        Green1 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green1_img = reshape(Green1(), [250,250]);
        pause(0.005);
        next = 'Second';
        keeprunGreen = false;
    case 'Second'
        Green2 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green2_img = reshape(Green2(), [250,250]);
        pause(0.005);
        next = 'Third';
        keeprunGreen = false;
    case 'Third'
        Green3 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green3_img = reshape(Green3(), [250,250]);
        pause(0.005);
        next = 'Fourth';
        keeprunGreen = false;
    case 'Fourth'
        Green4 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green4_img = reshape(Green4(), [250,250]);
%         save('Green1_2mm.mat','Green1');
%         save('Green2_2mm.mat','Green2');
%         save('Green3_2mm.mat','Green3');
        tiledlayout(1,4)
        nexttile
        image(Green1_img); title('1');
        nexttile
        image(Green2_img); title('2');
        nexttile
        image(Green3_img); title('3');
        nexttile
        image(Green4_img); title('4');
        
        oninput = input('Which figure represents green turning on?  ');
        switch oninput
            case 1
                GreenOn = Green1;
            case 2
                GreenOn = Green2;
            case 3
                GreenOn = Green3;
            case 4
                GreenOn = Green4;
        end
        offinput = input('Which figure represents green turning off?  ');
        switch offinput
            case 1
                GreenOff = Green1;
            case 2
                GreenOff = Green2;
            case 3
                GreenOff = Green3;
            case 4
                GreenOff = Green4;
        end
        zeroinput = input('Which figure represents green completely off?  ');
        switch zeroinput
            case 1
                GreenZero = Green1;
            case 2
                GreenZero = Green2;
            case 3
                GreenZero = Green3;
            case 4
                GreenZero = Green4;
        end
        
        next = 'Done';
        keeprunGreen = false;
        
    case 'Done'
%         img = uint8(inbytes.GetImageData.GetRawPixels1Byte);
%         imgh = reshape(img(), [250,250]);
%         pause(0.01);
%         set(handles.image,'CData',imgh); 
%         fullimage=imgh;
        keeprunGreen = false;
end
end

% if (img(20) < 50) && (img(62480) > 200)
%     GreenOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     GreenOff = img;
% elseif any(img > 50)
%     GreenZero = img;
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