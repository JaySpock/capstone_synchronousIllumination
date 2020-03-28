function displayobjGreenCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global keeprungreen fullimage lock GreenOn GreenOff GreenZero next Green0 Green1 Green2 Green3 Green0_img Green1_img Green2_img Green3_img

%img=uint8(inbytes.GetImageData.GetRawPixels1Byte);
keeprungreen = true;
while keeprungreen
switch next
    case 'Zeroth'
        Green0 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green0_img = reshape(Green0(), [250,250]);
        pause(0.005);
        next = 'First';
        keeprungreen = false;
    case 'First'
        Green1 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green1_img = reshape(Green1(), [250,250]);
        pause(0.005);
        next = 'Second';
        keeprungreen = false;
    case 'Second'
        Green2 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green2_img = reshape(Green2(), [250,250]);
        pause(0.005);
        next = 'Third';
        keeprungreen = false;
    case 'Third'
        Green3 = double(inbytes.GetImageData.GetRawPixels1Byte);
        Green3_img = reshape(Green3(), [250,250]);
%         save('Green1_2mm.mat','Green1');
%         save('Green2_2mm.mat','Green2');
%         save('Green3_2mm.mat','Green3');
        tiledlayout(1,4)
        nexttile
        image(Green0_img);
        nexttile
        image(Green1_img);
        nexttile
        image(Green2_img);
        nexttile
        image(Green3_img);
        
        order1 = input('Enter (1) if the first image is green turning on, (2) if green turning off, or (3) if completely off:  ');
        order2 = input('Enter (1) if the second image is green turning on, (2) if green turning off, or (3) if completely off:  ');
        
        if order1 == 1
            GreenOn = Green1;
                if order2 == 2
                    GreenOff = Green2;
                    GreenZero = Green3;
                elseif order2 == 3
                    GreenZero = Green2;
                    GreenOff = Green3;
                end
        elseif order1 == 2
            GreenOff = Green1;
                if order2 == 1
                    GreenOn = Green2;
                    GreenZero = Green3;
                elseif order2 == 3
                    GreenZero = Green2;
                    GreenOn = Green3;
                end
        elseif order1 == 3
            GreenZero = Green1;
                if order2 == 1
                    GreenOn = Green2;
                    GreenOff = Green3;
                elseif order2 == 2
                    GreenOff = Green2;
                    GreenOn = Green3;
                end   
        end
        next = 'Done';
        keeprungreen = false;
    case 'Done'
%         img = unit8(inbytes.GetImageData.GetRawPixels1Byte);
%         imgh = reshape(img(), [250,250]);
%         pause(0.01);
%         set(handles.image,'CData',imgh); 
%         fullimage=imgh;
        keeprungreen = false;
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