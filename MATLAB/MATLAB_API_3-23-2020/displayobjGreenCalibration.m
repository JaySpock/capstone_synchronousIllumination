function displayobjGreenCalibration(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock GreenOn GreenOff GreenZero next Green1 Green2 Green3 Green1_img Green2_img Green3_img

img=uint8(inbytes.GetImageData.GetRawPixels1Byte);

switch next
    case 'First'
        Green1 = img;
        Green1_img = reshape(img(), [250,250]);
        pause(0.007);
        next = 'Second';
    case 'Second'
        Green2 = img;
        Green2_img = reshape(img(), [250,250]);
        pause(0.007);
        next = 'Third';
    case 'Third'
        Green3 = img;
        Green3_img = reshape(img(), [250,250]);
%         save('Green1_2mm.mat','Green1');
%         save('Green2_2mm.mat','Green2');
%         save('Green3_2mm.mat','Green3');
        tiledlayout(1,3)
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
    case 'Done'
end


% if (img(20) < 50) && (img(62480) > 200)
%     GreenOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     GreenOff = img;
% elseif any(img > 50)
%     GreenZero = img;
% end


imgh = reshape(img(), [250,250]);
pause(0.01);
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