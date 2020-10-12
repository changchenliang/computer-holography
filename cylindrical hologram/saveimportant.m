%saveimportant

img0=double((imread('pic\fruit1024512.jpg')));
img0R=img0(:,:,1);
img0G=img0(:,:,2);
img0B=img0(:,:,3);
imgR=zeros(size(img0R));
imgR(:,237:1024)=img0R(:,1:788);
imgR(:,1:236)=img0R(:,789:1024);
figure; imshow(uint8(imgR));
imgG=zeros(size(img0G));
imgG(:,237:1024)=img0G(:,1:788);
imgG(:,1:236)=img0G(:,789:1024);
figure; imshow(uint8(imgG));
imgB=zeros(size(img0B));
imgB(:,237:1024)=img0B(:,1:788);
imgB(:,1:236)=img0B(:,789:1024);
figure; imshow(uint8(imgB));
img(:,:,1)=imgR;
img(:,:,2)=imgG;
img(:,:,3)=imgB;
figure; imshow(uint8(img));
imwrite(uint8(img),'pic\fruit1024512(2).jpg');