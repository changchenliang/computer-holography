function [dx,dy,obj]=inv_frft_22(img,a,dfx,dfy,r,fe)
% The fast Fractional Fourier Transform
% input: f = samples of the signal
%        a = fractional power
% output: Faf = fast Fractional Fourier transform

f=img;
[m,n] = size(f);

alpha = a*pi/2;
tana2 = tan(alpha);
sina = sin(alpha);
[m,n]=size(img);
%dfy=dfx;
dx = 1/(dfx*n)*r*fe*sina;
dy = 1/(dfy*m)*r*fe*sina;

chrp1=zeros(m,n);
for ii=1:m
    for jj=1:n
        chrp1(ii,jj)=exp(-i*pi/r/fe/tana2*(dfx^2*(ii-1-ceil(m/2))^2+dfy^2*(jj-1-ceil(n/2))^2));
    end
end
%img=img.*chrp1;
%multiplication by chirp!

obj=fftshift(ifft2(fftshift(img)));
% convolution with chirp

chrp2=zeros(m,n);
for ii=1:m
    for jj=1:n
        chrp2(ii,jj)=exp(-i*pi/r/fe/tana2*(dx^2*(ii-1-ceil(m/2))^2+dy^2*(jj-1-ceil(n/2))^2));
    end
end
obj=obj.*chrp2;
%multiplication by chirp!