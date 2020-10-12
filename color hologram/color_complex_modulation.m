% color complex modulation

clc;clear
img0=double((imread('pic\lena1024.jpg')));
imgA=img0(:,:,1);%imgA=enlarge_anysize(imgA,2048,2048);
%imgA=enlarge_19201080(imgA);
%imgA=double_img(imgA);
imgB=img0(:,:,2);%imgB=enlarge_anysize(imgB,2048,2048);
%imgB=enlarge_19201080(imgB);
%imgB=double_img(imgB);
imgC=img0(:,:,3);%imgC=enlarge_anysize(imgC,2048,2048);
%imgC=enlarge_19201080(imgC);
%imgC=double_img(imgC);
%imgA=double(rgb2gray(imread('pic\lena512.jpg')));imgA=double_img(imgA);
%imgB=double(rgb2gray(imread('pic\parrots1024.jpg')));
%imgB=imgB*pi/255-pi/2;
%imgB=pi*ones(size(imgA));
%img0=imgA.*exp(1i.*imgB);
[mm,nn]=size(imgA);
rR=6.71e-7;
rG=5.32e-7;
rB=4.73e-7;
dx=8e-6;
dy=dx;
dfx=8e-6;
z=0.5;
originR1=[0,0];originR2=[800,0];
originG1=[0,0];originG2=[-650,0];
originB1=[0,0];originB2=[0,0];
% for ii=1:mm
%     for jj=1:nn
%         phiRt(ii,jj)=2*pi/rR/z*(jj*dfx*originR2(1)*dfx+ii*dfx*originR2(2)*dfx);
%         phiGt(ii,jj)=2*pi/rG/z*(jj*dfx*originG2(1)*dfx+ii*dfx*originG2(2)*dfx);
%     end
% end
% imgA=imgA.*exp(1i.*phiRt);
% imgB=imgB.*exp(1i.*phiGt);

% [objA]=shifted_fresnel_conv(imgA,dfx,dx,rR,-z,originR2,originR1);
% [objB]=shifted_fresnel_conv(imgB,dfx,dx,rG,-z,originG2,originG1);
% [objC]=shifted_fresnel_conv(imgC,dfx,dx,rB,-z,originB2,originB1);
[ du, objA ] = angular_spectrum( dfx, rR, imgA, -z );
[ du, objB ] = angular_spectrum( dfx, rG, imgB, -z );
[ du, objC ] = angular_spectrum( dfx, rB, imgC, -z );

a=sum(sum(abs(objA))); b=sum(sum(abs(objB))); c=sum(sum(abs(objC)));
objA=objA/max(max(abs(objA))); objB=objB/max(max(abs(objB))); objC=objC/max(max(abs(objC)));
obj=objA;
%[imgA]=Fresnel_conv(obj,dx,dfx,rR,zB);
%[imgA]=shifted_fresnel_conv(objC,dx,dfx,rB,z,originB1,originB2);
%imgA=imgA/max(max(abs(imgA)));
%figure; imshow(abs(((imgA))));
%[obj]=Fresnel_conv(img0,dfx,dx,r,-z);
theta=1.2*pi/180;
phi_RMP = zeros(mm,nn);        
for ii = 1:mm
    for jj=1:nn
    phi_RMP(ii,jj)=(ii)*dy*tan(theta)*2*pi/rR;
    %phi_RMP(ii,jj)=-pi/r/zA*2*(dx^2*(jj-nn/2)^2 + dy^2*(ii-mm/2)^2);
    end
end
phi_RMP=angle(exp(1i.*phi_RMP));
obj_phi=angle(obj);
obj_amp=abs(obj)/max(max(abs(obj)));
phi_syn=obj_amp.*cos(obj_phi-phi_RMP);

obj=exp(1i.*phi_syn).*exp(-1i.*phi_RMP);
%obj(1:250,:)=0; obj(796:1080,:)=0;
obj_fft=fftshift(fft2(fftshift(obj)));
figure; imshow(1000*mat2gray(abs(obj_fft)));

%phi2=enlarge_19201080(phi_syn);
%phi_syn=255-uint8((angle(exp(1i.*phi2))+pi)*255/(2*pi));
%imwrite(phi_syn,['pic\complex\LCT\lena1024(0.3,0.6,1,10um).bmp']); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% reconstruction

mask=zeros(mm,nn);
mask(482:542,482:542)=1;
obj2=fftshift(ifft2(fftshift(obj_fft.*mask)));

% for ii=1:mm
%     for jj=1:nn
%         phiRt(ii,jj)=2*pi/rR/z*(jj*dx*originR2(1)*dfx+ii*dy*originR2(2)*dfx);
%         phiGt(ii,jj)=2*pi/rG/z*(jj*dx*originG2(1)*dfx+ii*dy*originG2(2)*dfx);
%     end
% end
obj_R=obj2;
obj_G=obj2;
obj_B=obj2;
%[ duu, img ] = angular_spectrum( du, r, obj, z );
%[dfx img ] = fresnel_cov(dx, r, obj, z );
%[imgA]=Fresnel_conv(obj,dx,dfx,rR,zB);
%[dfu imgR ] = fresnel_cov(dx, rR, obj_R, z );
%[dfu imgG ] = fresnel_cov(dx, rG, obj_G, z );
%[dfu imgB ] = fresnel_cov(dx, rB, obj_B, z );
dfu=8e-6;
% [imgR]=shifted_fresnel_conv(obj_R,dx,dfu,rR,z,originB1,originB2);
% [imgG]=shifted_fresnel_conv(obj_G,dx,dfu,rG,z,originB1,originB2);
% [imgB]=shifted_fresnel_conv(obj_B,dx,dfu,rB,z,originB1,originB2);
[ du, imgR ] = angular_spectrum( dx, rR, obj_R, z );
[ du, imgG ] = angular_spectrum( dx, rG, obj_G, z );
[ du, imgB ] = angular_spectrum( dx, rB, obj_B, z );
imgR=imgR/max(max(abs(imgR))); figure; imshow(abs(((imgR))));
imgG=imgG/max(max(abs(imgG))); figure; imshow(abs(((imgG))));
imgB=imgB/max(max(abs(imgB))); figure; imshow(abs(((imgB))));
%imwrite(abs(img),['pic\com_lena1024.jpg']); 

% phiR=angle(imgR); phiR=(phiR+pi)/2/pi; figure; imshow(((phiR)));
% phiG=angle(imgG); phiG=(phiG+pi)/2/pi; figure; imshow(((phiG)));
% phiB=angle(imgB); phiB=(phiB+pi)/2/pi; figure; imshow(((phiB)));

img_rec(:,:,1)=imgR;
img_rec(:,:,2)=imgG;
img_rec(:,:,3)=imgB;
% figure; imshow(abs(img_rec));
%imwrite(abs(img_rec),['pic\complex\colorABC512_com(' num2str(dfx) ').jpg']);
