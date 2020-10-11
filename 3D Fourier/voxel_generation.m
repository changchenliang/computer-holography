%3D voxel generation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 生成每个面的图
%{
img=double(rgb2gray(imread('pic\D128.jpg')));
[mm,nn]=size(img);
%for ii=1:mm
%    for jj=1:nn
%        if img(ii,jj)<50;
%            img(ii,jj)=0;
%        else
%            img(ii,jj)=255;
%        end
%    end
%end

img2=zeros(256,256);
img2(129:256,129:256)=img;
imwrite(uint8(img2),'pic\D128_256.jpg');
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imgA=double((imread('pic\A64_256.jpg')));
imgB=double((imread('pic\B64_256.jpg')));
imgC=double((imread('pic\C64_256.jpg')));
imgD=double((imread('pic\D64_256.jpg')));
imgE=double((imread('pic\E64_256.jpg')));
imgF=double((imread('pic\F64_256.jpg')));
imgG=double((imread('pic\G64_256.jpg')));
imgH=double((imread('pic\H64_256.jpg')));
imgI=double((imread('pic\I64_256.jpg')));
imgJ=double((imread('pic\J64_256.jpg')));
imgK=double((imread('pic\K64_256.jpg')));
imgL=double((imread('pic\L64_256.jpg')));
imgM=double((imread('pic\M64_256.jpg')));
imgN=double((imread('pic\N64_256.jpg')));
imgO=double((imread('pic\O64_256.jpg')));
imgP=double((imread('pic\P64_256.jpg')));

img=zeros(256,256,256);
img(:,:,1)=imgA;
img(:,:,72)=imgB;
img(:,:,80)=imgC;
img(:,:,88)=imgD;
img(:,:,96)=imgE;
img(:,:,104)=imgF;
img(:,:,112)=imgG;
img(:,:,120)=imgH;
img(:,:,128)=imgI;
img(:,:,136)=imgJ;
img(:,:,144)=imgK;
img(:,:,152)=imgL;
img(:,:,160)=imgM;
img(:,:,168)=imgN;
img(:,:,176)=imgO;
img(:,:,256)=imgP;

letter16_256=img;
clear img imgA imgB imgC imgD imgE imgF imgG imgH imgI imgJ imgK imgL imgM imgN imgO imgP

