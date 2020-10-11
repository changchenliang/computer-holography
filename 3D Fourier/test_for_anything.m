%≤‚ ‘

clc; clear
img0=double(rgb2gray(imread('pic\lena512.jpg')));
[mm,nn]=size(img0);
r=5.32e-7;
dx=8e-6;
dy=dx;
f=0.1;
dfx=1/dx/mm;
obj=inv_fft_2D(img0,dfx,dx);

img=fftshift(fft2(fftshift(obj)));
figure; imshow(mat2gray(abs(img)));


