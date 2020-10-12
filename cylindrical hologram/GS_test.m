% GS_text

clear; clc;
img0=double(rgb2gray(imread('pic\abcde1024512.jpg')));
%img0=double_img(img0);
[mm,nn]=size(img0);
for ii=1:mm
    for jj=1:nn
        %if img0(ii,jj)<50;
        %    img0(ii,jj)=10;
        %end
    end
end
img0_phi=0*pi*rand(size(img0));
img=img0.*exp(1i.*img0_phi);

%img=[img,zeros(size(img))];
lamda=5.32e-7;
L=0.0006;
dh=L/mm;
r=0.2;
R=0.5;
p=lamda/dh/2

eps=1e-12;
iflag=-1;
%for ii=1:10
%[du,obj]=cylindrical_convolution(dh,lamda,img,R,r);
tic
[du,obj]=cylindrical_helical_spectrum(dh,lamda,img,r,R);
%t=toc
%t=mm*t
%obj_phi=angle(obj);
%obj=exp(1i.*obj_phi);
%[ du, obj ] = angular_spectrum( dh, lamda, img, 0.1);
toc
%[du,img]=inv_cylindrical_convolution(dh,lamda,obj,r,R);
%[du,img]=cylindrical_helical_spectrum(dh,lamda,obj,R,r);
%img_phi=angle(img);
%img=img0.*exp(1i.*img_phi);
%ii
%end

%figure; imshow(mat2gray(abs(obj)));
%[du,img]=inv_cylindrical_convolution(dh,lamda,obj,r,R);
%[du,img]=cylindrical_convolution(dh,lamda,obj,r,R);
%for a=0.1:0.1:2
%obj2=obj(:,1:300);
%[mm,nn]=size(obj2);
%obj2=imresize(obj2,[mm,mm]);
[du,img]=cylindrical_helical_spectrum(dh,6.71e-7,obj,R,(R-(532/671)*(R-r)));

theta=linspace(-pi,pi,nn);
h=linspace(-L/2,L/2,mm);
[theta1,h1]=meshgrid(theta,h);
[theta2,h2]=meshgrid(theta,h);
%[img]=dir_int((obj),lamda,R,r,theta1,h1,theta2,h2);

figure; imshow(mat2gray(abs(img)));
%end