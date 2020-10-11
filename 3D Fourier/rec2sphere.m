clc;
close all;
clear all;

%��ά��Ϣ
obj=double(rgb2gray(imread('pic\earth256.jpg')));
[m,n]=size(obj);
r=linspace(0,0.0018,n);
phi=linspace(-pi/2,pi/2,n);
theta=linspace(-pi,pi,n);
%[phi,theta]=meshgrid(phi,theta);

%������άֱ������ϵ
N=256;
xa=linspace(-0.001,0.001,N);
ya=linspace(-0.001,0.001,N);
za=linspace(-0.001,0.001,N);
[xa,ya,za]=meshgrid(xa,ya,za);

%ֱ������ת��Ϊ������
[THETA,PHI,R] = cart2sph(xa,ya,za) ;

obj2=zeros(n,n,n);
obj2(:,:,200)=obj;
[theta,phi,r]=meshgrid(theta,phi,r);
earth=interp3(theta,phi,r,obj2,THETA,PHI,R);
