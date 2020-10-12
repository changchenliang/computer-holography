function [obj_phi] = GS_frft_color(img0,r,dx);

img_amp0 = double(img0)+0.00000001; %读取图像

%彩色图像分解成RGB三个分量
img0_R=img0(:,:,1);
img0_G=img0(:,:,2);
img0_B=img0(:,:,3);
img0_R=abs(img0_R)/max(max(img0_R));
img0_G=abs(img0_G)/max(max(img0_G));
img0_B=abs(img0_B)/max(max(img0_B));


[mm,nn] = size(img0_R);                %取分辨率

aR=1.25;
aG=1.2710;
aB=1.3027;
f1=0.5;
obj_phi=rand(size(img0_R));
feR=f1*sin(aR*pi/2);
feG=f1*sin(aG*pi/2);
%feB=f1*sin(aB*pi/2);

b=1;
p=0;
t=[];
k=[];
for ii = 0:16                %迭代次数
    obj=b.*exp(1i.*obj_phi);                  
    %[dfxR,img_R]=frft_2(obj,aR,dx,r,feR);
    [dfxG,img_G]=frft_2(obj,aG,dx,r,feG);
    %[dfxG img_G ] = fresnel_cov(dx, r, obj, 0.5 );
    %[dfxB,img_B]=frft_2(obj,aB,dx,r,feB);
    
    %img_phi_R=angle(img_R);
    img_phi_G=angle(img_G);
    %img_phi_B=angle(img_B);
    %img_R = img0_R.*exp(1i.*img_phi_R);       
    img_G = img0_G.*exp(1i.*img_phi_G);
    %img_B = img0_B.*exp(1i.*img_phi_B);
    
   
    [dx,obj_G] = inv_frft_2(img_G,aG,dfxG,r,feG);
    %[dx obj_G ] = inv_fresnel_cov( dfxG, r, img_G, 0.5 );
    %[dx,obj_B] = inv_frft_2(img_B,aB,dfxB,r,feB);
    %obj_RGB=obj_R+obj_G+obj_B; 
    obj_phi=angle(obj_G);
    %b=avesqrt(abs(obj));
    k(ii+1)=ii;
    ii

end

return;
