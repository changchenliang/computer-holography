
%  Detailed explanation goes here
img=double((imread('pic\lena512.jpg')));
%imgA=double((imread('pic\A512.jpg')));
%imgB=double((imread('pic\B512.jpg')));
%imgC=double((imread('pic\C512.jpg')));


img_R=img(:,:,1);
img_G=img(:,:,2);
img_B=img(:,:,3);
img_R=abs(img_R)/max(max(img_R));
img_G=abs(img_G)/max(max(img_G));
img_B=abs(img_B)/max(max(img_B));


%rgb_img=cat(3,imgA,imgB,imgC);
%img0(:,:,1)=imgA;
%img0(:,:,2)=imgB;
%img0(:,:,3)=imgC;
%img0=uint8(img0);
figure;imshow(img_B);
figure;imshow(img_R);
figure;imshow(img_G);
