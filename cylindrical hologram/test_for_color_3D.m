% test_for_3D color

clear; clc;
%img0=double((imread('pic\parrots1024512(2).jpg')));
img01=double((imread('pic\mix1.jpg')));
img02=double((imread('pic\mix2.jpg')));
img03=double((imread('pic\mix3.jpg')));
img04=double((imread('pic\mix4.jpg')));
img01R=img01(:,:,1);
img01G=img01(:,:,2);
img01B=img01(:,:,3);
com1G=sum(sum(abs(img01R)))/sum(sum(abs(img01G)))
com1B=sum(sum(abs(img01R)))/sum(sum(abs(img01B)))
img01R=img01R/max(max(abs(img01R)));
img01G=com1G*img01G/max(max(abs(img01G)));
img01B=com1B*img01B/max(max(abs(img01B)));
img02R=img02(:,:,1);
img02G=img02(:,:,2);
img02B=img02(:,:,3);
com2G=sum(sum(abs(img02R)))/sum(sum(abs(img02G)))
com2B=sum(sum(abs(img02R)))/sum(sum(abs(img02B)))
img02R=img02R/max(max(abs(img02R)));
img02G=com2G*img02G/max(max(abs(img02G)));
img02B=com2B*img02B/max(max(abs(img02B)));
img03R=img03(:,:,1);
img03G=img03(:,:,2);
img03B=img03(:,:,3);
com3G=sum(sum(abs(img03R)))/sum(sum(abs(img03G)))
com3B=sum(sum(abs(img03R)))/sum(sum(abs(img03B)))
img03R=img03R/max(max(abs(img03R)));
img03G=com3G*img03G/max(max(abs(img03G)));
img03B=com3B*img03B/max(max(abs(img03B)));
img04R=img04(:,:,1);
img04G=img04(:,:,2);
img04B=img04(:,:,3);
com4G=sum(sum(abs(img04R)))/sum(sum(abs(img04G)))
com4B=sum(sum(abs(img04R)))/sum(sum(abs(img04B)))
img04R=img04R/max(max(abs(img04R)));
img04G=com4G*img04G/max(max(abs(img04G)));
img04B=com4B*img04B/max(max(abs(img04B)));
%img0R=sqrt(img0R); img0G=sqrt(img0G); img0B=sqrt(img0B);

[mm,nn]=size(img01R);

lamdaR=6.30e-7;
lamdaG=5.70e-7;
lamdaB=4.90e-7;
dh=0.01/mm;
r1=0.2;
R=0.5;
r1B=r1
r1G=R-lamdaG*(R-r1)/lamdaB
r1R=R-lamdaR*(R-r1)/lamdaB

r2=0.21;
R=0.5;
r2B=r2
r2G=R-lamdaG*(R-r2)/lamdaB
r2R=R-lamdaR*(R-r2)/lamdaB

r3=0.22;
R=0.5;
r3B=r3
r3G=R-lamdaG*(R-r3)/lamdaB
r3R=R-lamdaR*(R-r3)/lamdaB

r4=0.23;
R=0.5;
r4B=r4
r4G=R-lamdaG*(R-r4)/lamdaB
r4R=R-lamdaR*(R-r4)/lamdaB

%img_sum=zeros(mm,mm,3);
%for jj=1:10
    obj_phi=2*pi*rand(size(img01R));
for ii=1:16
    obj=exp(1i.*obj_phi);
    
    %%%%%%1111111111111111111111111111111111111111111111111111111111111
    [du,img1B]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,r1B);
    tempB=img1B/max(max(abs(img1B)));
    RMS1B(ii)=RMS(abs(tempB),img01B);
    img1B_phi=angle(img1B);
    img1B=img01B.*exp(1i.*img1B_phi);
    
    [du,img1G]=cylindrical_helical_spectrum(dh,lamdaB,img1B,r1B,r1G);
    tempG=img1G/max(max(abs(img1G)));
    RMS1G(ii)=RMS(abs(tempG),img01G);
    img1G_phi=angle(img1G);
    img1G=img01G.*exp(1i.*img1G_phi);
    
    [du,img1R]=cylindrical_helical_spectrum(dh,lamdaB,img1G,r1G,r1R);
    tempR=img1R/max(max(abs(img1R)));
    RMS1R(ii)=RMS(abs(tempR),img01R);
    img1R_phi=angle(img1R);
    img1R=img01R.*exp(1i.*img1R_phi);
    
    [du,obj1]=cylindrical_helical_spectrum(dh,lamdaB,img1R,r1R,R);
    
    %%%%%%2222222222222222222222222222222222222222222222222222222222222
    [du,img2B]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,r2B);
    tempB=img2B/max(max(abs(img2B)));
    RMS2B(ii)=RMS(abs(tempB),img02B);
    img2B_phi=angle(img2B);
    img2B=img02B.*exp(1i.*img2B_phi);
    
    [du,img2G]=cylindrical_helical_spectrum(dh,lamdaB,img2B,r2B,r2G);
    tempG=img2G/max(max(abs(img2G)));
    RMS2G(ii)=RMS(abs(tempG),img02G);
    img2G_phi=angle(img2G);
    img2G=img02G.*exp(1i.*img2G_phi);
    
    [du,img2R]=cylindrical_helical_spectrum(dh,lamdaB,img2G,r2G,r2R);
    tempR=img2R/max(max(abs(img2R)));
    RMS2R(ii)=RMS(abs(tempR),img02R);
    img2R_phi=angle(img2R);
    img2R=img02R.*exp(1i.*img2R_phi);
   
    [du,obj2]=cylindrical_helical_spectrum(dh,lamdaB,img2R,r2R,R);
    
    %%%%%33333333333333333333333333333333333333333333333333333333333
    [du,img3B]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,r3B);
    tempB=img3B/max(max(abs(img3B)));
    RMS3B(ii)=RMS(abs(tempB),img03B);
    img3B_phi=angle(img3B);
    img3B=img03B.*exp(1i.*img3B_phi);
    
    [du,img3G]=cylindrical_helical_spectrum(dh,lamdaB,img3B,r3B,r3G);
    tempG=img3G/max(max(abs(img3G)));
    RMS3G(ii)=RMS(abs(tempG),img03G);
    img3G_phi=angle(img3G);
    img3G=img03G.*exp(1i.*img3G_phi);
    
    [du,img3R]=cylindrical_helical_spectrum(dh,lamdaB,img3G,r3G,r3R);
    tempR=img3R/max(max(abs(img3R)));
    RMS3R(ii)=RMS(abs(tempR),img03R);
    img3R_phi=angle(img3R);
    img3R=img03R.*exp(1i.*img3R_phi);
    
    [du,obj3]=cylindrical_helical_spectrum(dh,lamdaB,img3R,r3R,R);
    
    %%%%44444444444444444444444444444444444444444444444444444444444
    [du,img4B]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,r4B);
    tempB=img4B/max(max(abs(img4B)));
    RMS4B(ii)=RMS(abs(tempB),img04B);
    img4B_phi=angle(img4B);
    img4B=img04B.*exp(1i.*img4B_phi);
    
    [du,img4G]=cylindrical_helical_spectrum(dh,lamdaB,img4B,r4B,r4G);
    tempG=img4G/max(max(abs(img4G)));
    RMS4G(ii)=RMS(abs(tempG),img04G);
    img4G_phi=angle(img4G);
    img4G=img04G.*exp(1i.*img4G_phi);
    
    [du,img4R]=cylindrical_helical_spectrum(dh,lamdaB,img4G,r4G,r4R);
    tempR=img4R/max(max(abs(img4R)));
    RMS4R(ii)=RMS(abs(tempR),img04R);
    img4R_phi=angle(img4R);
    img4R=img04R.*exp(1i.*img4R_phi);
    
    [du,obj4]=cylindrical_helical_spectrum(dh,lamdaB,img4R,r4R,R);
    
    obj=obj1+obj2+obj3+obj4;
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
[du,imgR]=cylindrical_helical_spectrum(dh,lamdaR,obj,R,r1);
[du,imgG]=cylindrical_helical_spectrum(dh,lamdaG,obj,R,r1);
[du,imgB]=cylindrical_helical_spectrum(dh,lamdaB,obj,R,r1);
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
figure; imshow(1.8*abs(img));
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