% test for 3D angular spectrum
clear;clc;
load earth256.mat;
img0=earth;
%img0=ones(256,256,256);
img_phi=2*pi*rand(size(img0));
img0=img0.*exp(1i*img_phi);
r=5.32e-7;
z=0.10;
dx=8e-6;
du=20e-6;
phi=-pi/2;

for theta=0:pi/50:2*pi 
%dfx=1/dx/256;

% tic
[obj]=angular_spectrum_3D2(img0,du,dx,r,-z,phi,theta); 
obj_phi=angle(obj);
obj_phi=enlarge_19201080(obj_phi);
obj_phi=255-uint8((obj_phi+pi)*255/(2*pi));
imwrite(obj_phi,['expanding_map\holo20\theta=' num2str(theta) '.bmp']);
% [obj]=angular_spectrum_3Dor(img0,dx,r,-z);
% toc

%obj_phi=angle(obj);
%obj=exp(1i.*obj_phi);
zr=z-127*du;
% % for kk=1:16
% %      [ du, img ] = angular_spectrum( dx, r, obj, z );
%      %[img]=shifted_fresnel_conv(obj,dx,2*dx,r,z,[0,0],[0,0]);  
   [duu,dvv, img ] = fresnel_cov(dx,dx, r,obj, zr);
img=img/max(max(abs(img)));
% figure; imshow(abs(img));
    imwrite(abs(img),['expanding_map\du=20\theta=' num2str(theta) '.jpg']);
% end

%     z=z+0.00024
end