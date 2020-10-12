% Fresnel holography using orth

clear;clc;

D=60e-3;%直径
F=180e-3;%焦距  f-num=4
lens_d=1e-3;%微透镜直径
lens_f=3e-3;%微透镜焦距
micr_N=60;%微透镜个数
m=40;n=40;%（m,n）为每张小EI图像的像素
M=m*micr_N; N=n*micr_N; %总EI图像的像素个数
r=1064e-6;%波长
dx=8e-6; dy=dx;

obj1=double(rgb2gray(imread('pic\C.jpg')));
obj2=double(rgb2gray(imread('pic\D.jpg')));
d1=0.03;
d2=0.05;
obj1=imresize(obj1,[M,N]); obj2=imresize(obj2,[M,N]);

EI_total=zeros(M,N);
for ii=1:micr_N
    for jj=1:micr_N
% ii=10
% jj=11
        cx=m/2+(ii-1)*m;
        cy=n/2+(jj-1)*n;  %每张子EI图的中心像素
        Npx1=floor(m*d1/lens_f);
        Npy1=floor(n*d1/lens_f);  %对应需要裁剪的原图部分的像素
        Npx2=floor(m*d2/lens_f);
        Npy2=floor(n*d2/lens_f);  %对应需要裁剪的原图部分的像素
        obj1_tmp=enlarge_anysize(obj1,M+Npx1,N+Npy1);
        obj2_tmp=enlarge_anysize(obj2,M+Npx2,N+Npy2);
        cx_shift1=cx+floor(Npx1/2);
        cy_shift1=cy+floor(Npy1/2); %移位后的中心像素
        cx_shift2=cx+floor(Npx2/2);
        cy_shift2=cy+floor(Npy2/2); %移位后的中心像素
        EI1=obj1_tmp(cx_shift1-floor(Npx1/2):cx_shift1+floor(Npx1/2),cy_shift1-floor(Npy1/2):cy_shift1+floor(Npy1/2));
        EI1=imresize(EI1,[m,n]);
        EI2=obj2_tmp(cx_shift2-floor(Npx2/2):cx_shift2+floor(Npx2/2),cy_shift2-floor(Npy2/2):cy_shift2+floor(Npy2/2));
        EI2=imresize(EI2,[m,n]);
        EI_total((1+(ii-1)*m):ii*m,(1+(jj-1)*n):jj*n)=EI1+EI2;
    end
    ii
end
        
        
        
   