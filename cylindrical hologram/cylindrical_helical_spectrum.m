%ÖùÐÎÈ«Ï¢Í¼ cylindrical_helical_spectrum

function [du,obj]=cylindrical_helical_spectrum(dh,lamda,img,r,R);

du=dh;
[mm,nn]=size(img);
dtheta=2*pi/nn;
k=2*pi/lamda;

dfh=1/dh/mm;
h=zeros(mm,nn);
theta=zeros(mm,nn);
for ii=1:mm
    for jj=1:nn
        kh(ii,jj)=2*pi*dfh*(ii-mm/2-0.5);
        kr(ii,jj)=sqrt(k^2-kh(ii,jj)^2);
    end
end

H1=besselh(1,1,(kr.*R));
H2=besselh(1,1,(kr.*r));
T=H1./H2;

%figure; imshow(mat2gray(abs(fftshift(fft2(fftshift(T))))));

tmp = fftshift(fft2(fftshift(img)));
tmp = tmp.*T;
obj = fftshift(ifft2(fftshift(tmp)));

%save obj.mat;
return;