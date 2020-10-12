img0=double((imread('pic\lena512.jpg')));
  
rR=6.33e-7;
dx=1.5e-5;
%dxG=1.390758975e-5;
%dxR=1.319737156e-5;

[obj_phi] = GS_frft_color(img0,rR,dx);

obj_color=exp(1i.*obj_phi);
rB=4.90e-7;
rG=5.70e-7;
a=1.25;
f1=0.5;
fe=f1*sin(a*pi/2);
z=f1*sin(a*pi/2)*tan(a*pi/4)

%下面是重建验证
[dfx,img_R]=frft_2(obj_color,a,dx,rG,fe);

%img_B=abs(img_B)/max(max(abs(img_B)));
%img_G=abs(img_G)/max(max(abs(img_G)));
img_R=abs(img_R)/max(max(abs(img_R)));
%figure; imshow(img_B);
%figure; imshow(img_G);
%figure; imshow(img_R);
%img_rec(:,:,1)=img_R;
%img_rec(:,:,2)=img_G;
%img_rec(:,:,3)=img_B;
figure; imshow(img_R);
