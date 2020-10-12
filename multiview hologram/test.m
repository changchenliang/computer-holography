clc; clear;

img0=double(rgb2gray(imread('pic\EI7200.jpg')));
[M,N]=size(img0);
D=60e-3;%ֱ��
F=180e-3;%����  f-num=4
lens_d=1e-3;%΢͸��ֱ��
lens_f=lens_d*F/D;%΢͸������
micr_N=ceil(D/lens_d);%΢͸������
m=ceil(M/micr_N);n=ceil(N/micr_N);%��m,n��Ϊÿ��С����ͼ�������
z0=0.3;
z=0.4;
r=0.001;
dx=lens_d;
dy=lens_d;
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
fi0=deltafi*n;%ˮƽ�Ƕȴ�-Fi/2��Fi/2
theta0=deltathelta*m;%ˮƽ�Ƕȴ�-Thelta/2��Thelta/2
theta=linspace(-theta0,theta0,m);
fi=linspace(-fi0,fi0,n);
obj=zeros(micr_N,micr_N);
mm=200;
nn=200;
obj=enlarge_anysize(obj,mm,nn);

for ii=ceil(m/3)+1:ceil(m*2/3)
    for jj=ceil(n/3)+1:ceil(n*2/3)
        oi=EI2oi(img0,micr_N,micr_N,m,n,ii,jj);
        oi=enlarge_anysize(oi,mm,nn);
        xshift=floor((z)*fi(jj)/dx);
        yshift=floor((z)*theta(ii)/dy);
        se=translate(strel(1),[-yshift xshift]);
        shiftimg=imdilate(oi,se);
        for kk=1:mm
            for ll=1:nn
                if shiftimg(kk,ll)==-Inf;
                    shiftimg(kk,ll)=0;
                end
            end
        end
        %figure; imshow(uint8(shiftimg));
        phi=2*pi*z/r*(theta(ii)^2+fi(jj)^2);
        obj_tmp=shiftimg*exp(1i*phi);
        obj=obj+obj_tmp;
    end
end

%[ du, obj ] = angular_spectrum( dx, r, img0, -z );
figure; imshow(mat2gray(abs(obj)));
obj_phi=mod(angle(obj),2*pi);
obj_phi=(obj_phi)/2/pi;
figure; imshow(obj_phi);

a=1;
%for z=0.05:0.05:0.5
[dfx img ] = fresnel_cov(a*dx, a*a*r, obj, -0.2 );
%[ du, img ] = angular_spectrum( dx, r, obj, -z0 );
figure; imshow(mat2gray(abs(fftshift(img))));
%end


