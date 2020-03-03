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
A = randi([0,255],1,62500);
B = randi([0,255],1,62500);
C = randi([0,255],1,62500);

c1 = rand(3,3);
c2 = rand(3,3);
c3 = rand(3,3);
c4 = rand(3,3);
c5 = rand(3,3);
c6 = rand(3,3);
c7 = rand(3,3);
c8 = rand(3,3);
c9 = rand(3,3);
c10 = rand(3,3);
c11 = rand(3,3);
c12 = rand(3,3);
c13 = rand(3,3);
c14 = rand(3,3);
c15 = rand(3,3);
c16 = rand(3,3);
c17 = rand(3,3);
c18 = rand(3,3);
c19 = rand(3,3);
c20 = rand(3,3);
c21 = rand(3,3);
c22 = rand(3,3);
c23 = rand(3,3);
c24 = rand(3,3);
c25 = rand(3,3);

c = rand(187500,3); %all calibration matrices for a 250x250 sensor

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
CALI = rand(187500,3);

caliRed   = CALI(1:3:end,:);
caliGreen = CALI(2:3:end,:);
caliBlue  = CALI(3:3:end,:);

tic %could do everything above in calibration sequence
ABC = cat(2,A',B',C');

R = sum(ABC.*caliRed,2);
G = sum(ABC.*caliGreen,2);
B = sum(ABC.*caliBlue,2);
toc


%More methods?