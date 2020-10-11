function [img,dfx]=ar_sf_fre(obj,dx,r,z);
z0=min(min(abs(z)))
[mm,nn]=size(obj);
nj=mm*nn;
dy=dx;
dfx = 1/(dx*nn)*r*z0;
dfy = 1/(dy*mm)*r*z0;

for ii=1:mm
    for jj=1:nn
        pha(ii,jj)=exp(1i*2*pi/r*z(ii,jj));
    end
end

for ii=1:mm
    for jj=1:nn
        chrp1(ii,jj)=exp(1i*pi/r/z(ii,jj)*(dx^2*(jj-nn/2-0.5)^2 + dy^2*(ii-mm/2-0.5)^2));
    end
end

for ii=1:mm
    for jj=1:nn
        chrp2(ii,jj)=exp(1i*pi/r/z0*(dfx^2*(jj-nn/2-0.5)^2 + dfy^2*(ii-mm/2-0.5)^2));
    end
end
obj=obj.*pha.*chrp1;

for ii=1:mm
    for jj=1:nn
        xobj(ii,jj)=(dx*(jj-nn/2-0.5))/z(ii,jj);
        yobj(ii,jj)=(dy*(ii-mm/2-0.5))/z(ii,jj);
    end
end

xmax=max(max(abs(xobj)));
xobj=2*pi*(xobj+xmax)/(2*xmax)-pi;
ymax=max(max(abs(yobj)));
yobj=2*pi*(yobj+ymax)/(2*ymax)-pi;
iflag = -1;eps=1e-12;
[img,ier]=nufft2d1(nj,yobj,xobj,obj,iflag,eps,mm,nn);

img=img.*chrp2;

save img.mat;