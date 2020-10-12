function [obj_phi] = GS_ABCthree(img0A,img0B,img0C,r,dx,dy,f1,aA,aB,aC);

img_ampA = double(img0A)+0.00000001;%读取图像
img_ampB = double(img0B)+0.00000001;
img_ampC = double(img0C)+0.00000001;
[mm,nn] = size(img_ampA); 
%for kk=1:20
img_phi=2*pi*rand(size(img0A));
img_phiA=img_phi; img_phiB=img_phi; img_phiC=img_phi;

b=1;                               
feA=f1*sin(aA*pi/2);
feB=f1*sin(aB*pi/2);
feC=f1*sin(aC*pi/2);
dfxA = 1/(dx*nn)*r*feA*sin(aA*pi/2);
dfyA = 1/(dy*mm)*r*feA*sin(aA*pi/2);
dfxB = 1/(dx*nn)*r*feB*sin(aB*pi/2);
dfyB = 1/(dy*mm)*r*feB*sin(aB*pi/2);
dfxC = 1/(dx*nn)*r*feC*sin(aC*pi/2);
dfyC = 1/(dy*mm)*r*feC*sin(aC*pi/2);
for ii = 1:1     
    imgA=img_ampA.*exp(1i.*img_phiA);
    imgB=img_ampB.*exp(1i.*img_phiB);
    imgC=img_ampC.*exp(1i.*img_phiC);
    [dx,dy,objA] = inv_frft_22(imgA,aA,dfxA,dfyA,r,feA);
    [dx,dy,objB] = inv_frft_22(imgB,aB,dfxB,dfyB,r,feB);
    [dx,dy,objC] = inv_frft_22(imgC,aC,dfxC,dfyC,r,feC);
    obj=objA+objB+objC;
    obj_phi=angle(obj);
    b=avesqrt(abs(obj));    
    obj=b.*exp(1i.*obj_phi);
    [dfxA,dfyA,imgA]=frft_22(obj,aA,dx,dy,r,feA);%从O平面分数阶传到A平面
    [dfxB,dfyB,imgB]=frft_22(obj,aB,dx,dy,r,feB);%
    [dfxC,dfyC,imgC]=frft_22(obj,aC,dx,dy,r,feC);%
    img_phiA=angle(imgA);
    img_phiB=angle(imgB);
    img_phiC=angle(imgC);
ii
end

obj2 = exp(1i.*obj_phi); 
 [dfxA,dfyA,zoutA]=frft_22(obj2,aA,dx,dy,r,feA);
 [dfxB,dfyB,zoutB]=frft_22(obj2,aB,dx,dy,r,feB);
 [dfxC,dfyC,zoutC]=frft_22(obj2,aC,dx,dy,r,feC);
 zoutA=zoutA/max(max(abs(zoutA)));
 zoutB=zoutB/max(max(abs(zoutB)));
 zoutC=zoutC/max(max(abs(zoutC)));
% figure; imshow(mat2gray(abs(zoutA)));
% figure; imshow(mat2gray(abs(zoutB)));
% figure; imshow(mat2gray(abs(zoutC)));

return;



