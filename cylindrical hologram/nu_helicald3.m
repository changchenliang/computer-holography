function [output]=nu_helicald3(input,x_out,y_out,iflag,eps,dh,lamda,r,R)

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

xmax=max(max(x_out));
x_out_tmp=2*pi*(x_out+xmax)/(2*xmax)-pi;
ymax=max(max(y_out));
y_out_tmp=2*pi*(y_out+ymax)/(2*ymax)-pi;

%input = fftshift(fft2(fftshift(input)));
[input,ier]=nufft2d1(nj,y_out_tmp,x_out_tmp,input,iflag,eps,mm,nn);
input = input.*T;
y_out_tmp=fliplr(y_out_tmp);
 [output_tmp,ier]=nufft2d2(nj,y_out_tmp,x_out_tmp,iflag,eps,mm,nn,input);
 for jj=1:nn
     for ii=1:mm
         output(ii,jj)=output_tmp(mm*(jj-1)+ii,1);
     end
 end
%output = fftshift(ifft2(fftshift(input)));
output=rot90(output,2);