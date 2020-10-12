clc;clear
img0=double((imread('pic\lena512.jpg')));
figure;imshow(uint8(abs(img0)),[]);
rR=6.33e-7;rG=5.32e-7;rB=4.50e-7;
%提取RGB分量
imgR=img0(:,:,1);
imgG=img0(:,:,2);
imgB=img0(:,:,3);
[m,n]=size(imgR);
% obj_phi=2*pi*rand(size(imgR));
%RGB to YCbCr
imgY=0.2989*imgR+0.5866*imgG+0.1145*imgB;
imgCb=-0.1687*imgR-0.3312*imgG+0.5*imgB;
imgCr=0.5*imgR-0.4183*imgG-0.0816*imgB;

% figure;imshow(imgY,[]);
% figure;imshow(imgCb,[]);
% figure;imshow(imgCr,[]);
dx=8e-6;z=0.3;

%down-sampling
downCb=sizechanging(imgCb,dx,m/2,n/2);
downCr=sizechanging(imgCr,dx,m/2,n/2);
%diffraction
LGR=exp(1i*2*pi*rR*z/rG^2)/exp(1i*2*pi*z/rR);
LBR=exp(1i*2*pi*rR*z/rB^2)/exp(1i*2*pi*z/rR);
 [ du, DRY ] = angular_spectrum( dx, rR, imgY, -z );
 [ du1, DRCb ] = angular_spectrum( 2*dx, rR, downCb, -z*rR/rG);
 [ du1, DRCr ] = angular_spectrum( 2*dx, rR, downCr, -z*rR/rB );
%  [ du, DRY ] = angular_spectrum( dx, rR, imgY, z );
%  [ du1, DRCb ] = angular_spectrum( dx, rR, imgCb, z );
%  [ du1, DRCr ] = angular_spectrum( dx, rR, imgCr, z );

%up-sampling
upCb=sizechanging(DRCb,2*dx,m,n);
upCr=sizechanging(DRCr,2*dx,m,n);
% YCbCr to RGB
DR=1*DRY+0*LGR.*upCb+1.4022*LBR.*upCr;
DG=1*DRY-0.3456*LGR.*upCb-0.7145*LBR.*upCr;
DB=1*DRY+1.7710*LGR.*upCb+0*LBR.*upCr;
% DR=1*DRY+0*upCb+1.4022*upCr;
% DG=1*DRY-0.3456*upCb-0.7145*upCr;
% DB=1*DRY+1.7710*upCb+0*upCr;


%reconstructed
%  [ dx, reR ] = angular_spectrum( du, rR, DR, -z );
%  [ dx, reG ] = angular_spectrum( du, rG, DG, -z );
%  [ dx, reB ] = angular_spectrum( du, rB, DB, -z );
 [ dx, reR ] = angular_spectrum( du, rR, DR, z );
 [ dx, reG ] = angular_spectrum( du, rG, DG, z );
 [ dx, reB ] = angular_spectrum( du, rB, DB, z );

recon=cat(3,reR,reG,reB);
figure;imshow(mat2gray(abs(recon)));
