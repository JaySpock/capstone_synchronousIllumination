function Oa = ImageRecontructRealTime(PicOriginal1, PicOriginal2, PicOriginal3)
% [PicOriginal1] = imread('1.jpeg');
RGBPicture1 = im2double(imread(PicOriginal1));

% [PicOriginal2] = imread('2.jpeg');
RGBPicture2 = im2double(imread(PicOriginal2));

% [PicOriginal3] = imread('3.jpeg');
RGBPicture3 = im2double(imread(PicOriginal3));
[M,N,R] = size(RGBPicture3);


%% Vector set up
Tr = zeros(M, N);
Tg = zeros(M, N);
Tb = zeros(M, N);


Qmin = 0;
Qmax = 1023;

Q1 = zeros(M,N);
Q2 = zeros(M,N);
Q3 = zeros(M,N);

Q = zeros(M,N,3);
O = zeros(M,N,3);
Qa = zeros(3,1);
Oa = zeros(M,N,3);

%% Generates integration time for 1 pixel and 1 frame
for m = 1:M
    for n = 1:N
        Tr(m,n) = m/M;
        Tg(m,n) = 0;
        Tb(m,n) = (M-m)/M;
    end
end

%% Generate Capcitance values for the image simulated

for m = 1:M
    for n = 1:N
        O = [RGBPicture1(m,n,1); RGBPicture2(m,n,1); RGBPicture3(m,n,1)];
        Q(m,n,:) = O;
    end
end

%% reconstruct image from Capacitance and integration time
tic
for m = 1:M
    for n = 1:N
        T = [Tr(m,n) Tg(m,n) Tb(m,n); Tb(m,n) Tr(m,n) Tg(m,n); Tg(m,n) Tb(m,n) Tr(m,n)];   
        L = [1 0 0; 0 1 0; 0 0 1];
        A = T*L;
        Qa = [Q(m,n,1); Q(m,n,2); Q(m,n,3)];
        Oa(m,n,:) = linsolve(A,Qa);
    end
end
toc


% subplot(1,5,1),imshow(Q);
% 
% subplot(1,5,2), imshow(Q(:,:,1));
% subplot(1,5,3), imshow(Q(:,:,2));
% subplot(1,5,4), imshow(Q(:,:,3));
% 
% 
% subplot(1,5,5), imshow(Oa);
% truesize([M N]);
