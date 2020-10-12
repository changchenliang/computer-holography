%用FFT算法计算彩色全息图并重建，观察色差现象
%图像采用2048×1024
img0=double((imread('pic\lena20481024.jpg')));
imgR=img0(:,:,1);
imgG=img0(:,:,2);
imgB=img0(:,:,3);
obj_phi=2*pi*rand(size(imgR));
a=1.25;
f1=0.5;
dx=8e-6;
dy=dx;
fe=f1*sin(a*pi/2);
holo=zeros(1080,1920);
holoR=zeros(1080,1920);
holoG=zeros(1080,1920);
holoB=zeros(1080,1920);
rR=6.71e-7;rG=5.32e-7;rB=4.73e-7;
%[obj_phi] = GS_Forier(imgB,obj_phi);

[obj_phiR] = GS_frft_mn(imgR,obj_phi,a,rR,f1);
[obj_phiG] = GS_frft_mn(imgG,obj_phi,a,rG,f1);
[obj_phiB] = GS_frft_mn(imgB,obj_phi,a,rB,f1);

obj_phiR_t=obj_phiR(1:1024,65:704);
obj_phiB_t=obj_phiB(1:1024,705:1344);
obj_phiG_t=obj_phiG(1:1024,1345:1984);

holoR(29:1052,1:640)=obj_phiR_t;
holoB(29:1052,641:1280)=obj_phiB_t;
holoG(29:1052,1281:1920)=obj_phiG_t;

objR=exp(1i.*holoR);
[dfxR,dfyR,img_R]=frft_mn(objR,a,dx,dy,rR,fe);
img_R=abs(img_R).^2; 
img_R=50*img_R/max(max(abs(img_R)));                   %Fourier为5000000，frft为50
figure; imshow((abs(img_R)));

objG=exp(1i.*holoG);
[dfxG,dfyG,img_G]=frft_mn(objG,a,dx,dy,rG,fe);
img_G=abs(img_G).^2; 
img_G=50*img_G/max(max(abs(img_G)));                   %Fourier为5000000，frft为50
figure; imshow((abs(img_G)));

objB=exp(1i.*holoB);
[dfxB,dfyB,img_B]=frft_mn(objB,a,dx,dy,rB,fe);
img_B=abs(img_B).^2; 
img_B=50*img_B/max(max(abs(img_B)));                   %Fourier为5000000，frft为50
figure; imshow((abs(img_B)));

img_rec(:,:,1)=img_R;
img_rec(:,:,2)=img_G;
img_rec(:,:,3)=img_B;
figure; imshow(abs(img_rec));
