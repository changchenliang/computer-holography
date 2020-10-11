img1=double(rgb2gray(imread('pic\dice\1.bmp')));
img2=double(rgb2gray(imread('pic\dice\2.bmp')));
img3=double(rgb2gray(imread('pic\dice\3.bmp')));
img4=double(rgb2gray(imread('pic\dice\4.bmp')));
img5=double(rgb2gray(imread('pic\dice\5.bmp')));
img6=double(rgb2gray(imread('pic\dice\6.bmp')));

img1=turn_over(img1);
img2=turn_over(img2);
img3=turn_over(img3);
img4=turn_over(img4);
img5=turn_over(img5);
img6=turn_over(img6);

img=zeros(256,256,256);
img(:,:,16)=img1;
img(:,:,240)=img6;
img(16,:,:)=img2;
img(240,:,:)=img4;
img(:,16,:)=img3;
img(:,240,:)=img5;

dice=img;
clear img img1 img2 img3 img4 img5 img6
save dice;