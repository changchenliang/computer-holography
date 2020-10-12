%img0=double((imread('pic\lena512.jpg')));
clc;clear

rR=6.71e-7;
rG=5.32e-7;
rB=4.73e-7;
%r=1.0e-7;
dx=8e-6;
dfx=8e-6;
zA=0.5
zB=0.5*rG/rR
zC=0.5*rB/rR
f1=0.5;
%[b,obj_phi] = GS_frft_multiplane(rG,dx,f1);
[b,obj_phi] = GS_ANG_multiplane(rB,dx,zA,zB,zC);
%[b,obj_phi] = GS_fresnel_conv_multiplane(rB,dx,dfx,zA,zB,zC);

obj=exp(1i.*obj_phi);
[ du, img_A ] = angular_spectrum( dx, rR, obj, zC );
[ du, img_B ] = angular_spectrum( dx, rG, obj, zC );
[ du, img_C ] = angular_spectrum( dx, rB, obj, zC );

img_A=abs(img_A)/max(max(abs(img_A)));
figure; imshow((abs(img_A)));
img_B=abs(img_B)/max(max(abs(img_B)));
figure; imshow((abs(img_B)));
img_C=abs(img_C)/max(max(abs(img_C)));
figure; imshow((abs(img_C)));

img_rec(:,:,1)=abs(img_A);
img_rec(:,:,2)=abs(img_B);
img_rec(:,:,3)=abs(img_C);
figure; imshow((img_rec));
imwrite((img_rec),'pic\colorlena512_rec2.jpg');
%{
%obj_phi=half_img(obj_phi);
obj=b.*exp(1i.*obj_phi);
a=1.4;
fe=f1*sin(a*pi/2);
[dfxA,img_A]=frft_2(obj,a,dx,rR,fe);
[dfxB,img_B]=frft_2(obj,a,dx,rG,fe);
[dfxC,img_C]=frft_2(obj,a,dx,rB,fe);

img_A=abs(img_A).^2;
img_A=img_A/max(max(img_A));
figure; imshow((abs(img_A)));
img_B=abs(img_B).^2;
img_B=img_B/max(max(img_B));
figure; imshow((abs(img_B)));
img_C=abs(img_C).^2;
img_C=img_C/max(max(img_C));
figure; imshow((abs(img_C)));

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(abs(img_rec));
imwrite(abs(img_rec),'pic\colorlena1024_rec2.jpg');

phi=255-uint8((obj_phi+pi)*255/(2*pi));
%imwrite(phi,'pic\colorlena1024.bmp');          % ‰≥ˆœ‡ŒªÕº
%}


%{
obj2=2*b.*exp(1i.*obj_phi);
a=1.4;
fe=f1*sin(a*pi/2);
[dfxA,img_A]=frft_2(obj2,a,dx,rR,fe);
[dfxB,img_B]=frft_2(obj2,a,dx,rG,fe);
[dfxC,img_C]=frft_2(obj2,a,dx,rB,fe);

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(uint8(img_rec));
imwrite(uint8(img_rec),'pic\colorlena1024_rec2.jpg');

obj3=2.5*b.*exp(1i.*obj_phi);
a=1.4;
fe=f1*sin(a*pi/2);
[dfxA,img_A]=frft_2(obj3,a,dx,rR,fe);
[dfxB,img_B]=frft_2(obj3,a,dx,rG,fe);
[dfxC,img_C]=frft_2(obj3,a,dx,rB,fe);

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(uint8(img_rec));
imwrite(uint8(img_rec),'pic\colorlena1024_rec3.jpg');
%}
