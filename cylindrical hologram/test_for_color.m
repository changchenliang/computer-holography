% test_for_color

clear; clc;
%img0=double((imread('pic\parrots1024512(2).jpg')));
img0=double((imread('pic\parrots20481024(2).jpg')));
img0R=img0(:,:,1);
img0G=img0(:,:,2);
img0B=img0(:,:,3);
comG=sum(sum(abs(img0R)))/sum(sum(abs(img0G)))
comB=sum(sum(abs(img0R)))/sum(sum(abs(img0B)))
img0R=img0R/max(max(abs(img0R)));
img0G=comG*img0G/max(max(abs(img0G)));
img0B=comB*img0B/max(max(abs(img0B)));
%img0R=sqrt(img0R); img0G=sqrt(img0G); img0B=sqrt(img0B);

[mm,nn]=size(img0R);

lamdaR=6.30e-7;
lamdaG=5.70e-7;
lamdaB=4.90e-7;
dh=0.01/mm;
r=0.2;
R=0.5;
rB=r
rG=R-lamdaG*(R-r)/lamdaB
rR=R-lamdaR*(R-r)/lamdaB

%img_sum=zeros(mm,mm,3);
%for jj=1:10
    obj_phi=2*pi*rand(size(img0R));
for ii=1:10
    obj=exp(1i.*obj_phi);
    [du,imgB]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,rB);
    tempB=imgB/max(max(abs(imgB)));
    RMSB(ii)=RMS(abs(tempB),img0B);
    imgB_phi=angle(imgB);
    imgB=img0B.*exp(1i.*imgB_phi);
    
    [du,imgG]=cylindrical_helical_spectrum(dh,lamdaB,imgB,rB,rG);
    tempG=imgG/max(max(abs(imgG)));
    RMSG(ii)=RMS(abs(tempG),img0G);
    imgG_phi=angle(imgG);
    imgG=img0G.*exp(1i.*imgG_phi);
    
    [du,imgR]=cylindrical_helical_spectrum(dh,lamdaB,imgG,rG,rR);
    tempR=imgR/max(max(abs(imgR)));
    RMSR(ii)=RMS(abs(tempR),img0R);
    imgR_phi=angle(imgR);
    imgR=img0R.*exp(1i.*imgR_phi);
    
    %[du,imgG]=cylindrical_helical_spectrum(dh,lamdaB,imgR,rR,rG);
    %tempG=imgG/max(max(abs(imgG)));
    %RMSG(ii)=RMS(abs(tempG),img0G);
    %imgG_phi=angle(imgG);
    %imgG=img0G.*exp(1i.*imgG_phi);
    
    %[du,imgB]=cylindrical_helical_spectrum(dh,lamdaB,imgG,rG,rB);
    %tempB=imgB/max(max(abs(imgB)));
    %RMSB(ii)=RMS(abs(tempB),img0B);
    %imgB_phi=angle(imgB);
    %imgB=img0B.*exp(1i.*imgB_phi);
    
    [du,obj]=cylindrical_helical_spectrum(dh,lamdaB,imgR,rR,R);
    obj_phi=angle(obj);
    
    k(ii)=ii;
    ii
end
%figure; plot(k,RMSR,'r-',k,RMSG,'b-',k,RMSB,'o-'); 
%axis([0 21 0 0.4]);

obj=exp(1i.*obj_phi);
%obj2=obj(:,769:1024);
%obj2=imresize(obj2,[mm,mm]);
%[du,imgR]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,rR);
%[du,imgG]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,rG);
%[du,imgB]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,rB);
[du,imgR]=cylindrical_helical_spectrum(dh,lamdaR,obj,R,r);
[du,imgG]=cylindrical_helical_spectrum(dh,lamdaG,obj,R,r);
[du,imgB]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,r);
imgR=imgR/max(max(abs(imgR)));
imgG=imgG/max(max(abs(imgG)));
imgB=imgB/max(max(abs(imgB)));

%figure; imshow(mat2gray(abs(imgR)));
%figure; imshow(mat2gray(abs(imgG)));
%figure; imshow(mat2gray(abs(imgB)));

img(:,:,1)=abs(imgR);
img(:,:,2)=abs(imgG);
img(:,:,3)=abs(imgB);
%figure; imshow(abs(img));
%img_sum=img_sum+img;
%end
%img=img_sum/jj;
figure; imshow(1.5*abs(img));
%imwrite(1.8*abs(img),'pic\parrotsrec.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
img(:,:,1)=abs(imgR);
img(:,:,2)=zeros(size(imgR));
img(:,:,3)=zeros(size(imgR));
figure; imshow(abs(img));
imwrite(1.8*abs(img),'pic\parrotsrecR.jpg');

img(:,:,1)=zeros(size(imgG));
img(:,:,2)=abs(imgG);
img(:,:,3)=zeros(size(imgG));
figure; imshow(abs(img));
imwrite(1.8*abs(img),'pic\parrotsrecG.jpg');

img(:,:,1)=zeros(size(imgB));
img(:,:,2)=zeros(size(imgB));
img(:,:,3)=abs(imgB);
figure; imshow(abs(img));
imwrite(1.8*abs(img),'pic\parrotsrecB.jpg');
%}