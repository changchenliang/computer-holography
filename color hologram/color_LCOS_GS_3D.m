% color_LCOS

%temp 
clear; clc;
%for kk=1:1
img0A=double(rgb2gray(imread(['pic\A256.jpg'])));
img0B=double(rgb2gray(imread(['pic\B256.jpg'])));
img0C=double(rgb2gray(imread(['pic\C256.jpg'])));
%img0A=double((imread(['pic\frame_dice\dice1\' num2str(kk) '.jpg'])));
%img0B=double((imread(['pic\frame_dice\dice2\' num2str(kk) '.jpg'])));
%img0C=double((imread(['pic\frame_dice\dice3\' num2str(kk) '.jpg'])));
img0A=enlarge_anysize(img0A,960,2400);
img0B=enlarge_anysize(img0B,960,2400);
img0C=enlarge_anysize(img0C,960,2400);

lamda=5.32e-7;
dx=8e-6;
dy=8e-6;
%dfx=120e-6;
%dfy=dfx;
z=0.1;
f1=0.25;
[mm,nn]=size(img0A);

%% GS算法
for kk=1:50
aA=1+0.04*kk/50;
aB=1.02-0.04*kk/50;
aC=1.04-0.04*kk/50;
[phi_syn1] = GS_ABCthree(img0A,img0B,img0C,lamda,dx,dy,f1,aA,aB,aC);
%[phi_syn1] = GS_ABtwo(img0A,img0B,lamda,dx,dy,f1,aA,aB);
phi_t=zeros(mm,nn);
theta=0.5*pi/180;                 %0.4,dx=6.6um;  %0.1760,dx=15um; %0.3300,dx=8um;
for ii=1:mm
    for jj=1:nn
        phi_t(ii,jj)=(jj)*dx*tan(0.4*pi/180)*2*pi/lamda+(ii)*dy*tan(theta)*2*pi/lamda;
    end
end
phi_syn1=phi_syn1+phi_t;
%[dfx,obj_phi] = GS_Fresnel(img0,obj_phi,z);
%%  down sampling
%phi_syn1=angle(exp(1i.*phi_syn1));
phi_syn1=mod(phi_syn1,2*pi);
phi_syn=zeros(960,1200);
for ii=1:2:959
    for jj=1:1200
        phi_syn(ii,jj)=phi_syn1(ii,2*jj);
        phi_syn(ii+1,jj)=phi_syn1(ii+1,2*jj-1);
    end
end

%% LCOS像素合成

%phi_syn=(phi_syn)*255/2/pi;
% phi_syn=enlarge_anysize(phi_syn,600,800);
%phi_syn(phi_syn>=0&phi_syn<=pi/2)=90; phi_syn(phi_syn>pi/2&phi_syn<=3*pi/2)=250; phi_syn(phi_syn>3*pi/2&phi_syn<=2*pi)=90;
phi_syn=(255-40)*(phi_syn)/(2*pi*224/360)+40;   %归一化到[90-255]
phi_syn(phi_syn>255&phi_syn<=321)=255;  phi_syn(phi_syn>321)=40; 
phi_synR=zeros(480,800); phi_synG=zeros(480,800); phi_synB=zeros(480,800);
for ii=1:480
    for jj=1:2:799
        phi_synG(ii,jj)=phi_syn(2*ii-1,1+(jj-1)/2*3);
        phi_synG(ii,jj+1)=phi_syn(2*ii,3+(jj-1)/2*3);
        phi_synR(ii,jj)=phi_syn(2*ii,2+(jj-1)/2*3);
        phi_synR(ii,jj+1)=phi_syn(2*ii-1,3+(jj-1)/2*3);
        phi_synB(ii,jj)=phi_syn(2*ii,1+(jj-1)/2*3);
        phi_synB(ii,jj+1)=phi_syn(2*ii-1,2+(jj-1)/2*3);
    end
end
phi_synR2=enlarge_anysize(phi_synR,600,800); %phi_synR2=(phi_synR2+pi)*255/2/pi;
phi_synG2=enlarge_anysize(phi_synG,600,800); %phi_synG2=(phi_synG2+pi)*255/2/pi;
phi_synB2=enlarge_anysize(phi_synB,600,800); %phi_synB2=(phi_synB2+pi)*255/2/pi;
phi_syn2(:,:,1)=phi_synR2;
phi_syn2(:,:,2)=phi_synG2;
phi_syn2(:,:,3)=phi_synB2;

%imwrite(uint8(phi_syn2),['pic\color LCOS\ABC1200960_GS3D_FFT(binary).bmp']);
imwrite(uint8(phi_syn2),['pic\color LCOS\3DABC\' num2str(kk) '.png']);

kk
end

%% 仿真重建
phirec=(phi_syn-40)*2*pi/(255-40);
phib=zeros(size(phirec));
phib(phirec>pi&phirec<2*pi)=pi;
obj2=exp(1i.*phib);
img=fftshift(fft2(fftshift(obj2)));
figure; imshow(mat2gray(abs(img)));
figure; imshow((angle(img)+pi)/2/pi);