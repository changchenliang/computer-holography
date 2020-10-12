% this code is for making frame
clc; clear

%% 3DAB
% imgA=double(rgb2gray(imread('pic\A256.jpg')));
% imgB=double(rgb2gray(imread('pic\B256.jpg')));
% %[mm,nn]=size(img0);
% 
% for kk=1:125
%     se=translate(strel(1),[0 kk]);
%     img1=imdilate(imgA,se); img2=imdilate(imgB,se);
%     img1(img1==-inf)=0;     img2(img2==-inf)=0;
%     imwrite(mat2gray(abs(img1)), ['pic\frame_AB\A256\' num2str(kk) '.jpg']);
%     imwrite(mat2gray(abs(img2)), ['pic\frame_AB\B256\' num2str(kk) '.jpg']);
%     
%     kk
% end


%%  3D dice
for kk=1:101
object=double((imread(['pic\dice2\intensity\dice (' num2str(kk) ').jpg'])));
depth=double((imread(['pic\dice2\depth\dicedepth (' num2str(kk) ').jpg'])));
N=3;
lamda=5.32e-7;
f=0.25;
dx=8e-6;  dy=dx;
[mm,nn]=size(object);
depth=(1*(depth/max(max(128))).^1.5*lamda*f/dx);   %ABCD1次方，car和dice都是1.2次方

d=linspace(min(min(depth)),max(max(depth)),(N+1));

    mask1=zeros(size(object)); mask2=zeros(size(object)); mask3=zeros(size(object));  
    mask1(depth>=d(1)&depth<d(2))=1;   object1=object.*mask1;
    mask2(depth>=d(2)&depth<d(3))=1;   object2=object.*mask2;
    mask3(depth>=d(3))=1;              object3=object.*mask3;
    
     imwrite(mat2gray(abs(object1)), ['pic\frame_dice512\dice1\' num2str(kk) '.jpg']);
     imwrite(mat2gray(abs(object2)), ['pic\frame_dice512\dice2\' num2str(kk) '.jpg']);
     imwrite(mat2gray(abs(object3)), ['pic\frame_dice512\dice3\' num2str(kk) '.jpg']);
kk
end

