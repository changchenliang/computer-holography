%用卷积法计算衍射
  
rR=6.71e-7;
rG=5.32e-7;
rB=4.73e-7;
r=1.0e-7;
dx=8e-6;
dfx=8e-6;
dy=dx;
f1=0.3;
%[b,obj_phi] = GS_frft_conv_multiplane(rR,dx,dfx,f1);
[b,obj_phi] = GS_fresnel_conv_multiplane(rR,dx,dfx);
%[b,obj_phi] = GS_ANG_multiplane(r,dx);
%obj_phi=(flipud(obj_phi));                  %把图片翻一下，仅在SLM上实验时用


%obj_phi=half_img(obj_phi);
%{
obj=b.*exp(1i.*obj_phi);
a=1.3;
fe=f1*sin(a*pi/2);
[img_A]=frft_conv(obj,dx,dfx,rR,a,fe);
[img_B]=frft_conv(obj,dx,dfx,rG,a,fe);
[img_C]=frft_conv(obj,dx,dfx,rB,a,fe);

img_A=abs(img_A).^2;
img_A=img_A/max(max(img_A));
figure; imshow((abs(img_A)));
img_B=abs(img_B).^2;
img_B=img_B/max(max(img_B));
figure; imshow((abs(img_B)));
img_C=abs(img_C).^2;
img_C=img_C/max(max(img_C));
figure; imshow((abs(img_C)));

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(abs(img_rec));
%imwrite(abs(img_rec),'pic\lena1024_rec.jpg');

phi=255-uint8((obj_phi+pi)*255/(2*pi));
%imwrite(phi,'pic\lena1024(dx=8e-6,f=0.1).bmp');          %输出相位图
%}



%{
obj2=2*b.*exp(1i.*obj_phi);
a=1.4;
fe=f1*sin(a*pi/2);
[dfxA,img_A]=frft_2(obj2,a,dx,rR,fe);
[dfxB,img_B]=frft_2(obj2,a,dx,rG,fe);
[dfxC,img_C]=frft_2(obj2,a,dx,rB,fe);

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(uint8(img_rec));
imwrite(uint8(img_rec),'pic\colorlena1024_rec2.jpg');

obj3=2.5*b.*exp(1i.*obj_phi);
a=1.4;
fe=f1*sin(a*pi/2);
[dfxA,img_A]=frft_2(obj3,a,dx,rR,fe);
[dfxB,img_B]=frft_2(obj3,a,dx,rG,fe);
[dfxC,img_C]=frft_2(obj3,a,dx,rB,fe);

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(uint8(img_rec));
imwrite(uint8(img_rec),'pic\colorlena1024_rec3.jpg');
%}