%test

clc; clear;
imgA=double(rgb2gray(imread('pic\A256.jpg')));
imgB=double(rgb2gray(imread('pic\B256.jpg')));
imgC=double(rgb2gray(imread('pic\C256.jpg')));
imgD=double(rgb2gray(imread('pic\D256.jpg')));

%imgA=imgA/max(max(imgA));
[mm,nn]=size(imgA);
img=zeros(mm,nn,nn);
img(:,1,:)=imgA;
img(1,:,:)=imgB;
img(:,nn,:)=imgC;
img(nn,:,:)=imgD;
[x,y,z]=meshgrid(1:mm,1:nn,1:nn);
figure;
view(3);
%hold on;
%for i = 1 : mm
%    for j = 1 : nn
%        for k = 1 : nn
%            plot3(x(i, j, k), y(i, j, k), z(i, j, k), '.');
%        end
%    end
%end
slice(x,y,z,img,[1,mm],[1,nn],[]);