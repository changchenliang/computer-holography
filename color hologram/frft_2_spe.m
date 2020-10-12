function [chrp2,dfx,img]=frft_2(obj,a,dx,r,fe,chrp)
% The fast Fractional Fourier Transform
% input: f = samples of the signal
%        a = fractional power
% output: Faf = fast Fractional Fourier transform

f=obj;
[m,n] = size(f);

% do special cases
if (a==0), img = f; return; end;
if (a==2), img = flipud(f); return; end;
if (a==1), img = fft2(f); return; end 
% reduce to interval 0.5 < a < 1.5
obj = fftshift(ifft2(fftshift(f.*chrp)));
% the general case for 0.5 < a < 1.5
alpha = a*pi/2;
tana2 = tan(alpha);
sina = sin(alpha);
[m,n]=size(obj);
dy=dx;
dfx = 1/(dx*n)*r*fe*sina;
dfy = 1/(dy*m)*r*fe*sina;

chrp1=zeros(m,n);
for ii=1:m
    for jj=1:n
        chrp1(ii,jj)=exp(i*pi/r/fe/tana2*(dx^2*(ii-1-ceil(m/2))^2+dy^2*(jj-1-ceil(n/2))^2));
    end
end
obj=obj.*chrp1;
%multiplication by chirp!

img=fftshift(fft2(fftshift(obj)));
% convolution with chirp

chrp2=zeros(m,n);
for ii=1:m
    for jj=1:n
        chrp2(ii,jj)=exp(i*pi/r/fe/tana2*(dfx^2*(ii-1-ceil(m/2))^2+dfy^2*(jj-1-ceil(n/2))^2));
    end
end
img=img.*chrp2;
%multiplication by chirp!