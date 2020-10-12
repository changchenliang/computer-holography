% caustic by fft based poisson solver

clc; clear;
img0=double(rgb2gray(imread('pic\lena256.jpg'))); 
[mm,nn]=size(img0);
f=0.05;
dx=32e-6;
lamda=5.32e-7;
x=linspace(-dx*nn/2,dx*nn/2,nn);
y=linspace(-dx*mm/2,dx*mm/2,mm);
[x,y]=meshgrid(x,y);

L=1/dx;
dfx=1*L/nn;
fx=linspace(-L/2,L/2,nn);
fy=linspace(-L/2,L/2,mm);
[fx,fy]=meshgrid(fx,fy);

P=img0;

for kk=1:1
P1=P./max(max(abs(P)));
P2=P1-mean(mean(P1));
%figure; imshow(mat2gray(abs(P1)));

tmp=fftshift(fft2(fftshift(P1)));
tmp=tmp./(fx.^2+fy.^2+dfx^2);
phi=(fftshift(ifft2(fftshift(tmp))));

cao=abs(phi)-min(min(abs(phi)));
%cao=angle(phi)-min(min(angle(phi)));
cao2=cao*2*pi/lamda;

[px,py] = gradient(cao2,dx);
x1=x+f*lamda/2/pi.*px;
y1=y+f*lamda/2/pi.*py;
P=interp2(x,y,img0,x1,y1,'cubic');
P(isnan(P))=0;

kk
end
%[C] = Lap2_gra(abs(phi));
%figure; imshow(mat2gray(abs(C)));
obj=exp(1i.*cao2);
[ du, img ] = angular_spectrum( dx, lamda, obj, f );
figure; imshow(abs(img)/max(max(abs(img))));



