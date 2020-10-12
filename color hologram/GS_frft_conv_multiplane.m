function [b,obj_phi] = GS_frft_conv_multiplane(r,dx,dfx,f1);

%img0=double((imread('pic\lena1024.jpg')));
img0=double((imread('pic\colorSEU2048.jpg')));
imgA=img0(:,:,1);%imgA=abs(imgA)/max(max(imgA)); figure;imshow((imgA));
imgB=img0(:,:,2);%imgB=abs(imgB)/max(max(imgB)); figure;imshow((imgB));
imgC=img0(:,:,3);%imgC=abs(imgC)/max(max(imgC)); figure;imshow((imgC));

%imgA=double((imread('pic\A512.jpg')));
%imgA=double_img(imgA);
%imgA=double_img(imgA);
%imgB=double((imread('pic\B512.jpg')));
%imgB=double_img(imgB);
%imgB=double_img(imgB);
%imgC=double((imread('pic\C512.jpg')));
%imgC=double_img(imgC);
%imgC=double_img(imgC);

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
aA=1.7;%1.3; %1.3219807809;%1.342594962;
aB=1.731694938478;%1.35079939465; %1.3735569697389;%1.365997344;
aC=1.7465132;%1.37712; %1.4;
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
for ii = 0:5                                         %迭代次数
    obj=b.*exp(1i.*obj_phi);     
    [img_A]=frft_conv(obj,dx,dfx,r,aA,feA);
    errorA(ii+1)=RMS(imgA,img_A);
    img_phi_A=angle(img_A);   
    %if ii==0;
    %    GA=imgA;
    %else
    %    GA=imgA+(imgA-abs(img_A))*fienup;
    %end
    img_A = imgA.*exp(1i.*img_phi_A);
    
    [obj_mid]=frft_conv(img_A,dfx,dx,r,-aA,feA);
    [img_B]=frft_conv(obj_mid,dx,dfx,r,aB,feB);
    errorB(ii+1)=RMS(imgB,img_B);
    img_phi_B=angle(img_B);      
    %if ii==0;
    %    GB=imgB;
    %else
    %    GB=imgB+(imgB-abs(img_B))*fienup;
    %end
    img_B = imgB.*exp(1i.*img_phi_B);
    
    [obj_mid]=frft_conv(img_B,dfx,dx,r,-aB,feB);
    [img_C]=frft_conv(obj_mid,dx,dfx,r,aC,feC);
    errorC(ii+1)=RMS(imgC,img_C);
    img_phi_C=angle(img_C);  
    %if ii==0;
    %    GC=imgC;
    %else
    %    GC=imgC+(imgC-abs(img_C))*fienup;
    %end
    img_C = imgC.*exp(1i.*img_phi_C);
    
    %[obj_mid]=frft_conv(img_C,dfx,dx,r,-aC,feC);
    %[img_B]=frft_conv(obj_mid,dx,dfx,r,aB,feB);
    %img_phi_B=angle(img_B);      
    %img_B = imgB.*exp(1i.*img_phi_B);
    
    %[obj_mid]=frft_conv(img_B,dfx,dx,r,-aB,feB);
    %[img_A]=frft_conv(obj_mid,dx,dfx,r,aA,feA);
    %img_phi_A=angle(img_A);      
    %img_A = imgA.*exp(1i.*img_phi_A);
    
    [obj]=frft_conv(img_C,dfx,dx,r,-aC,feC);
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

[img_A]=frft_conv(obj,dx,dfx,r,aA,feA);
errorAa=RMS(imgA,abs(img_A))
[img_B]=frft_conv(obj,dx,dfx,r,aB,feB);
errorBb=RMS(imgB,abs(img_B))
[img_C]=frft_conv(obj,dx,dfx,r,aC,feC);
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