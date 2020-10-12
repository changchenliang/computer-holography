%衍射重建

dx=2.24e-5;
r=5.32e-7;
%z=0.3;       %相位全息图大概在0.03-0.04左右  振幅全息图大概在0.2以上。

for z=0.2:0.005:0.4;
load fresnel_holo64.mat;
%
holomax=max(max(abs(holo)));
[mm,nn]=size(holo)
for i=1:mm;
    for j=1:nn;
        holo(i,j)=holo(i,j)/holomax;
    end
end
holo=holo;
%}
%imshow(uint8(abs(holo)));
%phi=angle(holo);
obj=0.8.*holo;
%img=fft2(obj);
%[du, img ] = angular_spectrum( dx, r, obj, z );
[dfx img ] = fresnel_cov(dx, r, obj, z );
img=uint8(abs(img));
figure(1)
imshow(img);
title(['z = ',num2str(z)]);
imwrite(img,'pic\exp\recon_fresnel.jpg');
pause(1);
end