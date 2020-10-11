% test for arbitrary surface

img0=double(rgb2gray(imread('pic\seu1024.jpg')));
%img0=double(rgb2gray(imread('pic\bar.jpg')));
%img0=double(rgb2gray(imread('pic\triangle3.jpg')));

[mm,nn]=size(img0);
r=5.32e-7;
dx=8e-6;
dy=dx;
dfx=1e-5;

for ii=1:mm
    for jj=1:nn
        z(ii,jj)=0.3+(jj-1)*dfx*tan(8*pi/18);
    end
end

z0=min(min(abs(z)));
for ii=1:mm
    for jj=1:nn
        A(ii,jj)=1/sqrt(z(ii,jj)/z0);
    end
end

for ii=1:mm
    for jj=1:nn
        xobj(ii,jj)=dx*(jj-nn/2-1);
        yobj(ii,jj)=dy*(ii-mm/2-1);
    end
end
xobj=xobj.*A;
yobj=yobj.*A;

%[obj,dfx]=ar_sf_fre(img0,dx,r,z);
iflag = -1;eps=1e-12;
obj=nufresneld2(img0,xobj,yobj,mm,nn,-iflag,eps,r,-z0,dfx);

%obj_phi=angle(obj);
%obj=exp(1i.*obj_phi);

%[ du, img ] = angular_spectrum( dx, r, obj, z0 );
[dfx img ] = fresnel_cov(dx, r, obj, z0 );

img=img/max(max(abs(img)));
figure; imshow(abs(img));