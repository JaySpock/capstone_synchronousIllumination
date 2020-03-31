% 
% A = rand(250,250);
% B = rand(250,250);
% C = rand(250,250);
% 
% Anorm=(1/250)*A;
% 
% Ainv = inv(Anorm);
% 
% img = Ainv.*B;
% 
% imgh = A+B+C;


% On = [1 2; 3 4];
% Off = [4 3; 2 1];
% Aa = [2.5 2.5; 2.5 2.5];
% Bb = [1 1; 1 1];
% Cc = [4 4; 4 4];
% 
% OnNorm = (1/4)*On;
% OffNorm = (1/4)*Off;
% AaNorm = (1/4)*Aa;
% BbNorm = (1/4)*Bb;
% OnInv = inv(On);
% OffInv = inv(Off);
% OnNormInv = inv(OnNorm);
% OffNormInv = inv(OffNorm);
% red = OnInv*Cc + OffInv*Cc;
% green = OnInv*Bb + OffInv*Cc;
% blue = OnInv*Cc + OffInv*Bb;



%Initialize matrices (for a 250x250 image sensor)
A = zeros(1,62500);
% B = zeros(1,62500);
C = zeros(1,62500);
% A = linspace(0,62499,62500); %represents a solid sheet of red
% B = linspace(62499,0,62500);

for i=1:31250 %represents a checkerboard pattern of red alternating with black
    A(1,2*i-1) = 0;
    A(1,2*i) = 2*i;
end

Bq = flip(A);
B = circshift(Bq,-1);

%A = randi([0,65535],1,62500);
%B = randi([0,65535],1,62500);
%C = randi([0,65535],1,62500);

ROn = linspace(0,62499,62500); %creates a row vector counting up to 62499 (real max value will be 65535, but this will do for now to have nice even numbers)
ROff = linspace(62499,0,62500); %same but counting down
GOn = linspace(0,62499,62500);
GOff = linspace(62499,0,62500);
BOn = linspace(0,62499,62500);
BOff = linspace(62499,0,62500);

c = zeros(187500,3);

%c0 = inv([ROn(1) 0 BOff(1); ROff(1) GOn(1) 0; 0 GOff(1) BOn(1)]);
tic
for n=1:62500
    c(3*n-2:3*n,:)=inv([ROn(n) 0 BOff(n); ROff(n) GOn(n) 0; 0 GOff(n) BOn(n)]);
end

caliRed   = c(1:3:end,:);
caliGreen = c(2:3:end,:);
caliBlue  = c(3:3:end,:);
toc

ABC = cat(2,A',B',C');

Red = round(62500*sum(ABC.*caliRed,2));
Green = round(62500*sum(ABC.*caliGreen,2));
Blue = round(62500*sum(ABC.*caliBlue,2));

% c1 = rand(3,3);
% c2 = rand(3,3);
% c3 = rand(3,3);
% c4 = rand(3,3);
% c5 = rand(3,3);
% c6 = rand(3,3);
% c7 = rand(3,3);
% c8 = rand(3,3);
% c9 = rand(3,3);
% c10 = rand(3,3);
% c11 = rand(3,3);
% c12 = rand(3,3);
% c13 = rand(3,3);
% c14 = rand(3,3);
% c15 = rand(3,3);
% c16 = rand(3,3);
% c17 = rand(3,3);
% c18 = rand(3,3);
% c19 = rand(3,3);
% c20 = rand(3,3);
% c21 = rand(3,3);
% c22 = rand(3,3);
% c23 = rand(3,3);
% c24 = rand(3,3);
% c25 = rand(3,3);

%c = rand(187500,3); %all calibration matrices for a 250x250 sensor

%Multiplication method 1
% ABC = zeros(187500,1);
% %cali =
% blkdiag(c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25);
% %this might be difficult to scale up, could use a for loop? - I also have
% a text file with the required list of c#'s, use online tools for this
% 
% %this for loop takes WAY too long
% for i=1:62500 %creates the block diagonal matrix
%     cali(3*i-2:3*i,3*i-2:3*i) = c(3*i-2:3*i,1:3);
% end
% 
% tic %could do previous steps in the calibration sequence?
% for m=1:62500
%     ABC(3*m-2,1) = A(1,m);
%     ABC(3*m-1,1) = B(1,m);
%     ABC(3*m,1)   = C(1,m);
% end
% 
% RGB = cali*ABC;
% 
% R = RGB(1:3:end,1);
% G = RGB(2:3:end,1);
% B = RGB(3:3:end,1);
% toc %end timing here


%Multiplication method 2
%CALI = cat(1,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25) %again, how to scale up?
% CALI = rand(187500,3);
% 
% caliRed   = CALI(1:3:end,:);
% caliGreen = CALI(2:3:end,:);
% caliBlue  = CALI(3:3:end,:);
% 
% tic %could do everything above in calibration sequence
% ABC = cat(2,A',B',C');
% 
% R = sum(ABC.*caliRed,2);
% G = sum(ABC.*caliGreen,2);
% B = sum(ABC.*caliBlue,2);
% toc


%Normal operation option 2, updates every frame - change to switch
%statement?
% if serialIn == 001 %signal for blue to red
%     A = uint8(inbytes.GetImageData.GetRawPixels2Byte);
%     ABC = cat(2,A',B',C'); %need to define A,B,and C on startup sometime, make global?
%     R = sum(ABC.*caliRedOn,2); %change each one of these to caliRed for example?
%         r = reshape(R(), [w,h]);
%     G = sum(ABC.*caliGreenZero,2);
%         g = reshape(G(), [w,h]);
%     B = sum(ABC.*caliBlueOff,2);
%         b = reshape(B(), [w,h]);
%     img = cat(3, r,g,b); %take these three lines out at the end of the code, just call at the end of every if statement
%     set(handles.image,'CData',img); 
%     fullimage=img;
% elseif serialIn == 010 %signal for red to green
%     B = uint8(inbytes.GetImageData.GetRawPixels2Byte);
%     ABC = cat(2,A',B',C'); %need to define A,B,and C on startup sometime
%     R = sum(ABC.*caliRedOff,2);
%         r = reshape(R(), [w,h]);
%     G = sum(ABC.*caliGreenOn,2);
%         g = reshape(G(), [w,h]);
%     B = sum(ABC.*caliBlueZero,2);
%         b = reshape(B(), [w,h]);
%     img = cat(3, r,g,b); %take these three lines out at the end of the code, just call at the end of every if statement
%     set(handles.image,'CData',img); 
%     fullimage=img;
% elseif serialIn == 100 %signal for green to blue
%     C = uint8(inbytes.GetImageData.GetRawPixels2Byte);
%     ABC = cat(2,A',B',C'); %need to define A,B,and C on startup sometime
%     R = sum(ABC.*caliRedZero,2);
%         r = reshape(R(), [w,h]);
%     G = sum(ABC.*caliGreenOff,2);
%         g = reshape(G(), [w,h]);
%     B = sum(ABC.*caliBlueOn,2);
%         b = reshape(B(), [w,h]);
%     img = cat(3, r,g,b); %take these three lines out at the end of the code, just call at the end of every if statement
%     set(handles.image,'CData',img); 
%     fullimage=img;
% end