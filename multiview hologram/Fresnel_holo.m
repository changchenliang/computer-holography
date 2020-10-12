%生成初始3Dobject图片

img=zeros(128,128);
z=zeros(128,128);
for i=15:20;
    for j=15:48;
        img(i,j)=255;
        z(i,j)=-90;                              %深度坐标信息 (z轴)
    end
end

for i=30:35;
    for j=15:38;
        img(i,j)=255;
        z(i,j)=-90;                              %深度坐标信息 (z轴)
    end
end

for i=45:50;
    for j=15:48;
        img(i,j)=255;
        z(i,j)=-90;
    end
end

for i=15:50;
    for j=15:20;
        img(i,j)=255;
        z(i,j)=-90;
    end
end                                           %生成E图

for i=80:112;
    for j=80:85;
        img(i,j)=255;
        z(i,j)=-30;
    end
end

for i=80:112;
    for j=110:115;
        img(i,j)=255;
        z(i,j)=-30;
    end
end

for i=95:100;
    for j=80:115;
        img(i,j)=255;
        z(i,j)=-30;
    end
end                                           %H生成图

%imshow(img);
imwrite(img,'pic\object(128).jpg')                                  

%
%
%
%
%计算多角度projection

pro_img=zeros(128,128);
phi_max=0.72*pi/18;
c=2;
d=0.35;
r=10.64e-7;
dx=1.22e-5;
dy=dx;
k=0;
u=1;
[m1,n1]=size(img);
[mm,nn]=enlarge(m1,n1,c,d,phi_max);
h=zeros(mm,nn);
holo=zeros(mm,nn);

for phi_y=(-0.72*pi/18):(0.2*pi/180):(0.72*pi/18);
    v=1;
    for phi_x=(0.72*pi/18):(-0.2*pi/180):(-0.72*pi/18);

for i=1:128;
    for j=1:128;
        if z(i,j)>0||z(i,j)<0;
        xs=j-64;
        ys=64-i;
        xp=xs+z(i,j)*tan(phi_x);
        yp=ys+z(i,j)*tan(phi_y);
        n=floor(xp+64);
        if n==0||n<0;
            n=1;
        end
        if n>128;
            n=128;
        end
        m=floor(64-yp);
        if m==0||m<0;
            m=1;
        end
        if m>128;
            m=128;
        end
        pro_img(m,n)=img(i,j);
        end
    end
end
k=k+1
nameout=['pic\orthpro_img\pro_' num2str(k) '.bmp'];
imwrite(pro_img,nameout);
%img_temp(:,:,k)=pro_img;


%
for i=1:128;
    for j=1:128;
        u=j-64;
        u=u-c*tan(phi_x)*d*1000;
        n=floor(u+nn/2);
        v=64-i;
        v=v-c*tan(phi_y)*d*1000;
        m=floor(mm/2-v);
        h(m,n)=pro_img(i,j);
    end
end
nameout=['pic\pro_shift\proshift_' num2str(k) '.bmp'];
imwrite(h,nameout);
%}

b=2*d/r;
chrp=exp(1i*2*pi*b*((tan(phi_x))^2+(tan(phi_y))^2));
holo=holo+h.*chrp;
pro_img=zeros(128,128);
h=zeros(mm,nn);
    end
end                                    %相位图holo生成完毕

phi=angle(holo);
phi=255-uint8((phi+pi)*255/(2*pi));
imwrite(phi,'pic\exp\fresnel_holo.bmp');   %保存相位图

%{
holomax=max(max(abs(holo)))
[mm,nn]=size(holo)
for i=1:mm;
    for j=1:nn;
        holo(i,j)=holo(i,j)/holomax;
    end
end
holo=holo.*255;

imshow(uint8(abs(holo)));
%}