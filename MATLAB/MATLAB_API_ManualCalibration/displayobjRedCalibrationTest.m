function displayobjRedCalibrationTest(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector. 
global fullimage lock RedOn RedOff RedZero next Red1 Red2 Red3 Red4 Red5 Red6

img=uint8(inbytes.GetImageData.GetRawPixels1Byte);

switch next
    case 'First'
        Red1 = reshape(img(), [250,250]);
        pause(0.005);
        next = 'Second';
    case 'Second'
        Red2 = reshape(img(), [250,250]);
        pause(0.005);
        next = 'Third';
    case 'Third'
        Red3 = reshape(img(), [250,250]);
        pause(0.005);
        next = 'Fourth';
    case 'Fourth'
        Red4 = reshape(img(), [250,250]);
        pause(0.005);
        next = 'Fifth';
    case 'Fifth'
        Red5 = reshape(img(), [250,250]);
        pause(0.005);
        next = 'Sixth'
    case 'Sixth'
        Red6 = reshape(img(), [250,250]);
%         save('Red1_2mm.mat','Red1');
%         save('Red2_2mm.mat','Red2');
%         save('Red3_2mm.mat','Red3');
%         save('Red4_2mm.mat','Red4');
%         save('Red5_2mm.mat','Red5');
%         save('Red6_2mm.mat','Red6');
        pause(0.005);
        tiledlayout(2,3)
        nexttile
        image(Red1);
        nexttile
        image(Red2);
        nexttile
        image(Red3);
        nexttile
        image(Red4);
        nexttile
        image(Red5);
        nexttile
        image(Red6);
        next = 'First';
end


% if (img(20) < 50) && (img(62480) > 200)
%     RedOn = img;
% elseif (img(20) > 50) && (img(62480) < 200)
%     RedOff = img;
% elseif any(img > 50)
%     RedZero = img;
% end


% imgh = reshape(img(), [250,250]);
% set(handles.image,'CData',imgh); 
% fullimage=imgh;
% 

% if lock == 3
%     setgraph(handles,handles.axes2);
% else
% end
% 

% figure;
% exported_fig=gca;
% copyobj(allchild(handles.axes1), exported_fig);
% axis(exported_fig,'tight','square');
% axis off;

end