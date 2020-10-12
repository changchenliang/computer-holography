% beam shaping by conjugated gradient minimisation (intensity)

clear;clc;
img0=double(rgb2gray(imread('pic\lena256.jpg')));
%img0=enlarge_anysize(img0,512,512);
img0=img0/max(max(img0));
[mm,nn]=size(img0);

R=1/1.4;
alpha=0.29;
x=linspace(-nn/2,nn/2,nn);
y=linspace(-mm/2,mm/2,mm);
[x,y]=meshgrid(x,y);
obj_phi=2*pi*rand(size(img0));
%obj_phi=0.1.*(alpha.*x.^2+(1-alpha).*y.^2);
N=70;
t=1:N;
img_tmp=fft2(exp(1i.*obj_phi));
A0=1/max(max(abs(img_tmp)));
%A = @(I)  sum(sum(img0-(A0.*fft2(exp(1i.*I))).^2)); 
A=@(I) sum(sum(I.^2-1));
obj_phi = fminunc(A,obj_phi);
% for kk=1:N
%     obj=exp(1i.*obj_phi);
%     obj_c=conj(obj);
%     img=fftshift(fft2(fftshift(obj)));
%     img=img/max(max(abs(img)));
%     img_c=conj(img);
%     Xrs=fftshift(ifft2(fftshift(((img0-(A0.*abs(img)).^2).*img_c))));
%     Xrs=Xrs/max(max(abs(Xrs)));
%     gk=-4*A0^2*real(1i.*obj_c.*Xrs);    %当前迭代中更新后的gk
%     if kk==1
%         dk=gk;
%     else
%     %gama=gk.*gk./gkp./gkp;
%     gama=sum(sum(gk.*gk))/sum(sum(gkp.*gkp));
%     dk=gk+dkp.*gama;
%     end
% %     ek=abs(img)-img0;
% %     Q=fftshift(fft2(fftshift(dk)));
% %     Q=Q/max(max(abs(Q)));
% %     tau=gk'.*gk./(dk'.*abs(Q).*dk);
%     tau=0.4/kk;
%     obj_phi=obj_phi+tau.*dk;
%     obj_phi=mod(obj_phi,2*pi);
%     
%     gkp=gk;
%     dkp=dk;
%     
%     r(kk)=RMS(img,img0);
%     kk
% end

obj=exp(1i.*obj_phi);
img=fftshift(fft2(fftshift(obj)));
figure; imshow(1*abs(img)/max(max(abs(img))));

figure; plot(t,r,'-r');