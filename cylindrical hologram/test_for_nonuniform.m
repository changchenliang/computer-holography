% test for nonuniform

clear; clc;
img0=double(rgb2gray(imread('pic\abcde1024512.jpg')));
%img0=double_img(img0);
[mm,nn]=size(img0);
for ii=1:mm
    for jj=1:nn
        %if img0(ii,jj)<50;
        %    img0(ii,jj)=10;
        %end
    end
end
r=zeros(size(img0));
% for ii=1:mm
%     for jj=1:nn
%         if jj<nn/4+1
%             r(ii,jj)=0.3;
%         else if jj<nn/2+1
%                 r(ii,jj)=0.25;
%             else if jj<nn*3/4+1
%                     r(ii,jj)=0.2;
%                 else
%                     r(ii,jj)=0.15;
%                 end
%             end
%         end
%     end
% end
for ii=1:mm
    for jj=1:nn
        r(ii,jj)=0.3-0.15*jj/1024;
    end
end

%img=[img,zeros(size(img))];
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
%img=fliplr(flipud(img));

eps=1e-12;
iflag=-1;
%for ii=1:10
%[du,obj]=cylindrical_convolution(dh,lamda,img,R,r);
%[du,obj]=cylindrical_helical_spectrum(dh,lamda,img,r,R);
%[obj]=nu_helicald2(img,robj,hobj,iflag,eps,dh,lamda,r,R);
tic 
[obj]=nu_helicald3(img,robj,hobj,iflag,eps,dh,lamda,rmax,WRP);
[du,obj2]=cylindrical_helical_spectrum(dh,lamda,obj,WRP,R);
toc
%obj_phi=angle(obj);
%obj=exp(1i.*obj_phi);
%[ du, img ] = angular_spectrum( dh, lamda, obj, 0.1);
%[du,img]=inv_cylindrical_convolution(dh,lamda,obj,r,R);
%[du,img]=cylindrical_helical_spectrum(dh,lamda,obj,R,r);
%img_phi=angle(img);
%img=img0.*exp(1i.*img_phi);
%ii
%end

%figure; imshow(mat2gray(abs(obj)));
%[du,img]=inv_cylindrical_convolution(dh,lamda,obj,r,R);
%[du,img]=cylindrical_convolution(dh,lamda,obj,r,R);
%for a=0.1:0.1:2
%obj2=obj(:,1:300);
%[mm,nn]=size(obj2);
%obj2=imresize(obj2,[mm,mm]);
%r=WRP-(1/0.3)^2*(WRP-r)
[du,img]=cylindrical_helical_spectrum(dh,lamda,obj2,R,0.225);
figure; imshow(mat2gray(abs(img)));
%end
