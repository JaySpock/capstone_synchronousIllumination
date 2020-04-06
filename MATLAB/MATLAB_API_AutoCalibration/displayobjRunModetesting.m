function displayobjRunModetesting(inbytes,handles)
% Function that displays the sensor's image. First grabs the values from
% the sensor and reshapes them in a 3 dimensions vector.
global fullimage lock w h FPGA caliRed caliGreen caliBlue A B C frameOrder record v r g b Aimg Bimg Cimg nextFrame keeprun count imgh oldput

hbytes = double(inbytes.GetImageData.GetRawPixels1Byte);
img = reshape(hbytes(), [250,250]).';

% while true
%     input = readmemory(FPGA,16400,1);
%     pause(0.002);
%     if (input ~= oldput)
%         oldput = input;
%         break;
%     end       
% end
% 
% %pause(0.0038);
% if (input == 10) %Blue off, red on
%         A = hbytes;
%         Aimg = img;
%         
% elseif (input == 11) %red off, green on
%         B = hbytes;
%         Bimg = img;
%         
% elseif (input == 12) %green off, blue on
%         C = hbytes;
%         Cimg = img;
% 
% elseif (input == 13)
%     disp("Error in FPGA code");
% else
%     disp("Something's wrong");
% end
% 
% ABC = cat(2,A.',B.',C.');
% Red = sum(ABC.*caliRed,2);
%     r = reshape(Red(), [w,h]);
% Green = sum(ABC.*caliGreen,2);
%     g = reshape(Green(), [w,h]);
% Blue = sum(ABC.*caliBlue,2);
%     b = reshape(Blue(), [w,h]);
% 
% if frameOrder == 1
%     imgh = cat(3, r,g,b);
% 
% elseif frameOrder == 2
%     imgh = cat(3, g,b,r);
% 
% elseif frameOrder == 3
%     imgh = cat(3, b,r,g);
% end
% 
% idmax = find(imgh > 1);
% idmin = find(imgh < 0);
% imgh(idmax) = 1;
% imgh(idmin) = 0;
% 
% if record == 1
%     writeVideo(v,imgh);
% else
% end
% 
% %pause(0.008);
% 
% set(handles.image,'CData',imgh);
% fullimage=imgh;
% 
% if lock == 3
%     setgraph(handles,handles.axes2);
% else  
% end
% 
% oldput = input;



% pause(0.0087);
% input = readmemory(FPGA,16400,1);
% %pause(0.0038);
% if (input == 10) %Blue off, red on
%         A = hbytes;
%         Aimg = img;
%       
% elseif (input == 11) %red off, green on
%         B = hbytes;
%         Bimg = img;
%         
% elseif (input == 12) %green off, blue on
%         C = hbytes;
%         Cimg = img;
%         ABC = cat(2,A.',B.',C.');
%         Red = sum(ABC.*caliRed,2);
%             r = reshape(Red(), [w,h]);
%         Green = sum(ABC.*caliGreen,2);
%             g = reshape(Green(), [w,h]);
%         Blue = sum(ABC.*caliBlue,2);
%             b = reshape(Blue(), [w,h]);
%         if frameOrder == 1
%             imgh = cat(3, r,g,b);
%             idmax = find(imgh > 1);
%             idmin = find(imgh < 0);
%             imgh(idmax) = 1;
%             imgh(idmin) = 0;
%         elseif frameOrder == 2
%             imgh = cat(3, g,b,r);
%             idmax = find(imgh > 1);
%             idmin = find(imgh < 0);
%             imgh(idmax) = 1;
%             imgh(idmin) = 0;
%         elseif frameOrder == 3
%             imgh = cat(3, b,r,g);
%             idmax = find(imgh > 1);
%             idmin = find(imgh < 0);
%             imgh(idmax) = 1;
%             imgh(idmin) = 0;
%         end
% elseif (input == 13)
%     disp("Error in FPGA code");
% else
%     disp("Something's wrong");
% end
% 
% if record == 1
%     writeVideo(v,imgh);
% else
% end
% 
% %pause(0.008);
% 
% set(handles.image,'CData',imgh);
% fullimage=imgh;
% 
% if lock == 3
%     setgraph(handles,handles.axes2);
% else  
% end


switch count
    case 'A'
        A = hbytes;
        Aimg = img;
        count = 'B';

    case 'B'
        B = hbytes;
        Bimg = img;
        count = 'C';
       
    case 'C'
        C = hbytes;
        Cimg = img;
        count = 'A';
end

ABC = cat(2,A.',B.',C.');
Red = sum(ABC.*caliRed,2);
    r = reshape(Red(), [w,h]);
Green = sum(ABC.*caliGreen,2);
    g = reshape(Green(), [w,h]);
Blue = sum(ABC.*caliBlue,2);
    b = reshape(Blue(), [w,h]);

if frameOrder == 1
    imgh = cat(3, r,g,b);
elseif frameOrder == 2
    imgh = cat(3, g,b,r);
elseif frameOrder == 3
    imgh = cat(3, b,r,g);
end

idmax = find(imgh > 1);
idmin = find(imgh < 0);
imgh(idmax) = 1;
imgh(idmin) = 0;

if record == 1
    writeVideo(v,imgh);
else
end

set(handles.image,'CData',imgh);
fullimage=imgh;

if lock == 3
    setgraph(handles,handles.axes2);
else  
end


% keeprun = true;
% while keeprun
% switch nextFrame
%     case 'One' %Blue off, red on
%         A = hbytes;
%         Aimg = img;
%         nextFrame = 'Two';
%         keeprun = false;
% 
%         
%     case 'Two' %red off, green on
%         B = hbytes;
%         Bimg = img;
%         nextFrame = 'Three';
%         keeprun = false;
%         
%     case 'Three' %green off, blue on
%         C = hbytes;
%         Cimg = img;
%         nextFrame = 'One';
%         keeprun = false;
% end
% end

% ABC = cat(2,A.',B.',C.');
% Red = sum(ABC.*caliRed,2);
%     r = reshape(Red(), [w,h]);
% Green = sum(ABC.*caliGreen,2);
%     g = reshape(Green(), [w,h]);
% Blue = sum(ABC.*caliBlue,2);
%     b = reshape(Blue(), [w,h]);
% 
% if frameOrder == 1
%     imgh = cat(3, r,g,b);
% elseif frameOrder == 2
%     imgh = cat(3, g,b,r);
% elseif frameOrder == 3
%     imgh = cat(3, b,r,g);
% end
% 
% idmax = find(imgh > 1);
% idmin = find(imgh < 0);
% imgh(idmax) = 1;
% imgh(idmin) = 0;
% 
% if record == 1
%     writeVideo(v,imgh);
% else
% end
% 
% pause(0.005);
% 
% set(handles.image,'CData',imgh);
% fullimage=imgh;
% 
% if lock == 3
%     setgraph(handles,handles.axes2);
% else  
% end

end
