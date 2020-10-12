% 柱形全息图  卷计算法

function [du,obj]=cylindrical_convolution(dh,lamda,img,R,r);

du=dh;
[mm,nn]=size(img);
dtheta=2*pi/nn;
k=2*pi/lamda;

h=zeros(mm,nn);
theta=zeros(mm,nn);
for ii=1:mm
    for jj=1:nn
        h(ii,jj)=dh*(ii-mm/2-0.5);
        theta(ii,jj)=dtheta*(jj-nn/2);
        temp=sqrt(R^2+r^2-2*R*r*cos(theta(ii,jj))+h(ii,jj)^2);
        p(ii,jj)=exp(1i*k*temp)/temp;
    end
end

%p=exp(1i*k.*sqrt(R^2+r^-2*R*r.*cos(theta)+h.^2))./sqrt(R^2+r^-2*R*r.*cos(theta)+h.^2);

figure; imshow(mat2gray(abs(fftshift(fft2(fftshift(p))))));

img1=img(:,1:nn/2); img2=img(:,nn/2+1:nn)
obj=fftshift(ifft2(fft2(fftshift(img)).*fft2(fftshift(p))));
