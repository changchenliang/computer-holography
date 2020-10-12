function [b,obj_phi] = GS_frft_mn_multiplane(r,dx,f1);

img0=double((imread('pic\lena1024.jpg')));
%img0=double((imread('pic\colorSEU512.jpg')));
imgA=img0(:,:,1);%imgA=abs(imgA)/max(max(imgA)); figure;imshow((imgA));
imgB=img0(:,:,2);%imgB=abs(imgB)/max(max(imgB)); figure;imshow((imgB));
imgC=img0(:,:,3);%imgC=abs(imgC)/max(max(imgC)); figure;imshow((imgC));

%imgA=double((imread('pic\A1024.jpg')));
%imgB=double((imread('pic\B1024.jpg')));
%imgC=double((imread('pic\C1024.jpg')));

dy=dx;
[mm,nn] = size(imgA)                %取分辨率

for ii=1:mm;
    for jj=1:nn;
        if imgA(ii,jj)<50;
            imgA(ii,jj)=50;
        end
        if imgB(ii,jj)<50;
            imgB(ii,jj)=50;
        end
        if imgC(ii,jj)<50;
            imgC(ii,jj)=50;
        end
    end
end

fienup=0;
aA=1.3; %1.3219807809;%1.342594962;
aB=1.35079939465; %1.3735569697389;%1.365997344;
aC=1.37712; %1.4;
obj_phi=rand(size(imgA));
feA=f1*sin(aA*pi/2);
feB=f1*sin(aB*pi/2);
feC=f1*sin(aC*pi/2);
zA=f1*sin(aA*pi/2)*tan(aA*pi/4)
zB=f1*sin(aB*pi/2)*tan(aB*pi/4)
zC=f1*sin(aC*pi/2)*tan(aC*pi/4)

b=1;
p=0;
t=[];
k=[];
for ii = 0:16                                         %迭代次数
    obj=b.*exp(1i.*obj_phi);      
    [dfxA,dfyA,img_A]=frft_mn(obj,aA,dx,dy,r,feA);
    errorA(ii+1)=RMS(imgA,img_A);
    img_phi_A=angle(img_A);   
    %if ii==0;
    %    GA=imgA;
    %else
    %    GA=imgA+(imgA-abs(img_A))*fienup;
    %end
    img_A = imgA.*exp(1i.*img_phi_A);
    
    [dx,dy,obj_mid] = inv_frft_mn(img_A,aA,dfxA,dfyA,r,feA);
    [dfxB,dfyB,img_B]=frft_mn(obj_mid,aB,dx,dy,r,feB);
    errorB(ii+1)=RMS(imgB,img_B);
    img_phi_B=angle(img_B);      
    %if ii==0;
    %    GB=imgB;
    %else
    %    GB=imgB+(imgB-abs(img_B))*fienup;
    %end
    img_B = imgB.*exp(1i.*img_phi_B);
    
    [dx,dy,obj_mid] = inv_frft_mn(img_B,aB,dfxB,dfyB,r,feB);
    [dfxC,dfyC,img_C]=frft_mn(obj_mid,aC,dx,dy,r,feC);
    errorC(ii+1)=RMS(imgC,img_C);
    img_phi_C=angle(img_C);  
    %if ii==0;
    %    GC=imgC;
    %else
    %    GC=imgC+(imgC-abs(img_C))*fienup;
    %end
    img_C = imgC.*exp(1i.*img_phi_C);
    
    [dx,dy,obj_mid] = inv_frft_mn(img_C,aC,dfxC,dfyC,r,feC);
    [dfxB,dfyB,img_B]=frft_mn(obj_mid,aB,dx,dy,r,feB);
    img_phi_B=angle(img_B);      
    img_B = imgB.*exp(1i.*img_phi_B);
    
    [dx,dy,obj_mid] = inv_frft_mn(img_B,aB,dfxB,dfyB,r,feB);
    [dfxA,dfyA,img_A]=frft_mn(obj_mid,aA,dx,dy,r,feA);
    img_phi_A=angle(img_A);      
    img_A = imgA.*exp(1i.*img_phi_A);
    
    [dx,dy,obj] = inv_frft_mn(img_A,aA,dfxA,dfyA,r,feA);
    obj_phi=angle(obj);
    b=avesqrt(abs(obj));
    k(ii+1)=ii;
    ii

end

errorA(1)=errorB(1);
save errorA.mat;
save errorB.mat;
save errorC.mat;
figure; plot(k,errorA,'b-',k,errorB,'o-',k,errorC,'x-');


obj=b.*exp(1i.*obj_phi);

[dfxA,dfyA,img_A]=frft_mn(obj,aA,dx,dy,r,feA);
errorAa=RMS(imgA,abs(img_A))
[dfxB,dfyB,img_B]=frft_mn(obj,aB,dx,dy,r,feB);
errorBb=RMS(imgB,abs(img_B))
[dfxC,dfyC,img_C]=frft_mn(obj,aC,dx,dy,r,feC);
errorCc=RMS(imgC,abs(img_C))

img_A=abs(img_A).^2;
img_A=img_A/max(max(img_A));
figure; imshow((abs(img_A)));
img_B=abs(img_B).^2;
img_B=img_B/max(max(img_B));
figure; imshow((abs(img_B)));
img_C=abs(img_C).^2;
img_C=img_C/max(max(img_C));
figure; imshow((abs(img_C)));

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(abs(img_rec));

%{
%imwrite(uint8(abs(img_A)),'pic\A512_rec(a=1.25).jpg');
%imwrite(uint8(abs(img_B)),'pic\B512_rec(a=1.27).jpg');
%imwrite(uint8(abs(img_C)),'pic\C512_rec(a=1.30).jpg');

img_rec(:,:,1)=img_A;
img_rec(:,:,2)=img_B;
img_rec(:,:,3)=img_C;
figure; imshow(uint8(img_rec));
%imwrite(uint8(img_rec),'pic\colorABC512_rec2.jpg');
%}