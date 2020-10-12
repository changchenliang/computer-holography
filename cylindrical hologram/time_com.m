% time_com

%{
clear; clc;
kk=1;
for N=1024
    img0=ones(N,N);
    [mm,nn]=size(img0);
    for ii=1:mm
        for jj=1:nn
            r(ii,jj)=0.3-0.15*jj/1024;
        end
    end
lamda=5.32e-7;
dh=0.01/mm;
dtheta=2*pi/(nn-1);
WRP=0.32;
R=1;
rmax=max(max(r));
a=1./sqrt((WRP-r)./(WRP-rmax));
for ii=1:mm
    for jj=1:nn
      robj(ii,jj)=dtheta*(jj-1-ceil(nn/2));
      hobj(ii,jj)=a(ii,jj)*dh*(ii-1-ceil(mm/2));
      img0(ii,jj)=img0(ii,jj)*a(ii,jj);
    end
end
img0_phi=0*pi*rand(size(img0));
img=img0.*exp(1i.*img0_phi);
eps=1e-12;
iflag=-1;

tic
[obj]=nu_helicald3(img,robj,hobj,iflag,eps,dh,lamda,rmax,WRP);
[du,obj2]=cylindrical_helical_spectrum(dh,lamda,obj,WRP,R);

    t(kk)=toc;
    k(kk)=N;
    kk=kk+1
end

figure; plot(k,t,'o');
axis([500,1500,0,20]);
%}

clear; clc;
N=256;
img0=ones(N,N);
mm=N; nn=N;
lamda=180e-6;
dh=0.1/mm;
dtheta=2*pi/(nn-1);
WRP=0.01;
r=0.005
R=0.1;
dCGCH=2*pi*R/N;
dwrp=2*pi*WRP/N;
M=2*(WRP-r)*tan(asin(lamda/2/dh))/dh
k=2*pi/lamda;

m=5;
n=5;
for ii=1:m
    for jj=1:n
        theta1(ii,jj)=dtheta*(jj-nn/2);
    end
end

for ii=1:m
    for jj=1:n
        h1(ii,jj)=dh*(ii-m/2-0.5);
    end
end

for ii=1:mm
    for jj=1:nn
        theta2(ii,jj)=dtheta*(jj-nn/2);
    end
end

for ii=1:mm
    for jj=1:nn
        h2(ii,jj)=dh*(ii-mm/2-0.5);
    end
end

tic
for ii=1:mm
    for jj=1:nn
        img_tmp=0;
        for mm=1:27
            for nn=1:27
                L=sqrt(R^2+r^2-2*R*r*cos(theta2(mm,nn)-theta2(ii,jj))+(h2(mm,nn)-h2(ii,jj))^2);
                img_tmp=img_tmp+img0(mm,nn)/L*exp(1i*k*L);
            end
        end
        img(ii,jj)=img_tmp;
        %n2*(ii-1)+jj
    end
    ii
end
toc




