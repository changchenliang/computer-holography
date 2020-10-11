function [img]=shifted_fresnel_conv(obj,dx,dfx,r,z,origin1,origin2);   %用卷积法来算傅里叶变换传播  正传播

[mm,nn]=size(obj);
dy=dx;
dfy=dfx;
origin1x=origin1(1)*dx;origin1y=origin1(2)*dy;
origin2x=origin2(1)*dfx;origin2y=origin2(2)*dfy;
alpha1=dx*dfx/(r*z);
alpha2=dy*dfy/(r*z);
%alpha=alpha1+alpha2

pha_obj=zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    pha_obj(ii,jj) = exp(1i*pi/r/z*((origin1x+dx*(jj-1-ceil(nn/2)))^2 + (origin1y+dy*(ii-1-ceil(mm/2)))^2)); % x^2 + y^2
    end
end

chrp_shift1=zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    chrp_shift1(ii,jj) = exp(-1i*2*pi/r/z*(origin2x*(dx*(jj-1-ceil(nn/2))+origin1x) + origin2y*(dy*(ii-1-ceil(mm/2))+origin1y))); % x^2 + y^2
    end
end

chrp1=zeros(mm,nn);
for ii=1:mm
    for jj=1:nn
        chrp1(ii,jj)=exp(-1i*pi*(alpha1*(jj-1-ceil(nn/2))^2+alpha2*(ii-1-ceil(mm/2))^2));
    end
end
obj=obj.*pha_obj.*chrp_shift1.*chrp1;

chrp2_temp=zeros(mm,nn);
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

chrp_shift2=zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    chrp_shift2(ii,jj) = exp(-1i*2*pi/r/z*(origin1x*dfx*(jj-1-ceil(nn/2)) + origin1y*dfy*(ii-1-ceil(mm/2)))); % x^2 + y^2
    end
end

pha_img=zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    pha_img(ii,jj) = exp(1i*pi/r/z*((origin2x+dfx*(jj-1-ceil(nn/2)))^2 + (origin2y+dfy*(ii-1-ceil(mm/2)))^2)); % x^2 + y^2
    end
end
img=img.*chrp_shift2.*pha_img;