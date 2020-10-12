clc;clear;
EI=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI7200.bmp')));
[M,N]=size(EI);
%M=7200;N=7200;
D=60e-3;%直径
F=180e-3;%焦距  f-num=4
lens_d=1e-3;%微透镜直径
lens_f=lens_d*F/D;%微透镜焦距
micr_N=ceil(D/lens_d);%微透镜个数
m=ceil(M/micr_N);n=ceil(N/micr_N);%（m,n）为每张小基本图像的像素
%micr_M=59;micr_N=67;
%m=40;n=40;
r=1064e-6;%波长

dx=8e-6;
dfx=30e-6;
dy=dx;

%*********生成全息图***********%
%EI=EIfour2one(M,N,m,n,micr_Nto
%EI=EIfour2one2(M,N);
%oi=EI2oi(EI,micr_N,micr_N,m,n,20,20);
%figure; imshow(oi);
% OItemp=oi2OI(EI,micr_N,micr_N,m,n);
% OI=OItemp;
% OI=zeros(ceil(M/3),ceil(N/3));
% OI(:,:)=OItemp(ceil(M/3)+1:ceil(M*2/3),ceil(N/3)+1:ceil(N*2/3));
% %OI=zeros(M,N);
%num=0;
%for i=1:m
    %for j=1:n
        %num=num+1;
        %OI(60*(i-1)+1:60*i,60*(j-1)+1:60*j)=double(rgb2gray(imread(strcat('E:\研究僧\课题\集成成像\正交子图\正交子图 (',num2str(num),').bmp'))));
    %end
%end
% figure; imshow(OI);
%imwrite(OI,'E:\研究僧\课题\集成成像\傅里叶全息图\OI7200to2400(2).jpg')
%H=fourierholo(m,n,lens_d,lens_f,micr_N,OI,r);
%H=fourierholo2(m,n,lens_d,lens_f,micr_N,r,EI);
%H=fourierholo3(m,n,lens_d,lens_f,micr_N,r);
%H=fourierholo4(m,n,lens_d,lens_f,micr_N,r,EI);
%H=fourierholo5(m,n,lens_d/2,lens_f,2*micr_N,r,EI);
H=frenelholo2(m,n,lens_d,lens_f,micr_N,r);
%H=frenelholo1(m,n,lens_d,lens_f,micr_N,r,EI);
%H=enlarge(H,1024,1024);
h=H/max(max(abs(H))); 
figure; imshow(abs(h));
imwrite(abs(h),'E:\研究僧\课题\集成成像\傅里叶全息图\fresnelholo3振幅全息.jpg');
H_phi=angle(H);
phi=255-uint8((H_phi+pi)*255/(2*pi)); 
figure; imshow(uint8(phi));
imwrite(uint8(phi),'E:\研究僧\课题\集成成像\傅里叶全息图\fresnelholo3相位全息.jpg');


%*********重建全息图***********%
% img = fftshift(ifft2(fftshift(H)));
% figure; imshow(abs(img/max(max(abs(img)))));
%r=5.32e-7;
z=0.001;    
% f1=lens_f*dx/2/(lens_d/n);
% a=1;
% fe=f1*sin(a*pi/2);
% [dfx,img]=frft_2(H,a,dx,r,fe);
% [du,img]=angular_spectrum(dfx,r,img,z);
  [dfx img ] = fresnel_cov(dx, r, H, z );
  figure; imshow(abs(img/max(max(abs(img)))));
 imwrite(abs(img/max(max(abs(img)))),'E:\研究僧\课题\集成成像\傅里叶全息图\fresnelholo3重建图.jpg');