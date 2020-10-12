% NUFFT based helical spectrum

function [output]=nu_helicald1(input,x_in,y_in,iflag,eps,dh,lamda,r,R)

[mm,nn]=size(input);
nj=mm*nn;
%dtheta=2*pi/nn;
k=2*pi/lamda;

dfh=1/dh/mm;
%h=zeros(mm,nn);
%theta=zeros(mm,nn);
for ii=1:mm
    for jj=1:nn
        kh(ii,jj)=2*pi*dfh*(ii-mm/2-0.5);
        kr(ii,jj)=sqrt(k^2-kh(ii,jj)^2);
    end
end

H1=besselh(1,1,(kr.*R));
H2=besselh(1,1,(kr.*r));
T=H1./H2;

xmax=max(max(x_in));
x_in_tmp=2*pi*(x_in+xmax)/(2*xmax)-pi;
ymax=max(max(y_in));
y_in_tmp=2*pi*(y_in+ymax)/(2*ymax)-pi;
[output,ier]=nufft2d1(nj,y_in_tmp,x_in_tmp,input,iflag,eps,mm,nn);
output = output.*T;
output = fftshift(ifft2(fftshift(output)));