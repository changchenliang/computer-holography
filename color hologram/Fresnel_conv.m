function [img]=Fresnel_conv(obj,dx,dfx,r,z);   %用卷积法来算傅里叶变换传播  正传播

[mm,nn]=size(obj);
dy=dx;
dfy=dfx;
alpha1=dx*dfx/(r*z);
alpha2=dy*dfy/(r*z);
%alpha=alpha1+alpha2

for ii = 1:mm
    for jj = 1:nn
    pha_obj(ii,jj) = exp(1i*pi/r/z*(dx^2*(jj-1-ceil(nn/2))^2 + dy^2*(ii-1-ceil(mm/2))^2)); % x^2 + y^2
    end
end
obj=obj.*pha_obj;

for ii=1:mm
    for jj=1:nn
        chrp1(ii,jj)=exp(-1i*pi*(alpha1*(jj-1-ceil(nn/2))^2+alpha2*(ii-1-ceil(mm/2))^2));
    end
end
obj=obj.*chrp1;

for ii=1:mm
    for jj=1:nn
        chrp2_temp(ii,jj)=exp(1i*pi*(alpha1*(jj-1-ceil(nn/2))^2+alpha2*(ii-1-ceil(mm/2))^2));
    end
end
%mh=abs(floor(r*z*dx/(2*dfx^3)))
%chrp2=zeros(mm,nn);
%if mh<min(mm/2,nn/2)
%    chrp2(-mh+ceil(mm/2)+1:mh+ceil(mm/2)+1,-mh+ceil(nn/2)+1:mh+ceil(nn/2)+1)=chrp2_temp(-mh+ceil(mm/2)+1:mh+ceil(mm/2)+1,-mh+ceil(nn/2)+1:mh+ceil(nn/2)+1);
%else
    chrp2=chrp2_temp;
%end
%save chrp2.mat;

chrp3=chrp1;

L1=mm+mm-1; L2=nn+nn-1;
obj_conv=zeros(L1,L2);
chrp2_conv=zeros(L1,L2);
obj_conv(ceil(L1/4)+1:(ceil(L1/4)+ceil(L1/2)),ceil(L2/4)+1:(ceil(L2/4)+ceil(L2/2)))=obj(1:mm,1:nn);
chrp2_conv(ceil(L1/4)+1:(ceil(L1/4)+ceil(L1/2)),ceil(L2/4)+1:(ceil(L2/4)+ceil(L2/2)))=chrp2(1:mm,1:nn);

g=fft2(fftshift(obj_conv)).*fft2(fftshift(chrp2_conv));
conv_img=fftshift(ifft2(g));

%for ii=1:mm
%    for jj=1:nn
%        img(ii,jj)=conv_img(ii,jj);
%    end
%end
img=half_img(conv_img);
img=img/(4*mm*nn);
img=img.*chrp3;

for ii = 1:mm
    for jj = 1:nn
    pha_img(ii,jj) = exp(1i*pi/r/z*(dfx^2*(jj-1-ceil(nn/2))^2 + dfy^2*(ii-1-ceil(mm/2))^2)); % x^2 + y^2
    end
end
img=img.*pha_img;