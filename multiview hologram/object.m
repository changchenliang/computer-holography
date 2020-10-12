%生成初始3Dobject图片

img=zeros(128,128);
for i=15:20;
    for j=15:48;
        img(i,j)=255;
    end
end

for i=30:32;
    for j=15:38;
        img(i,j)=255;
    end
end

for i=45:50;
    for j=15:48;
        img(i,j)=255;
    end
end

for i=15:50;
    for j=15:20;
        img(i,j)=255;
    end
end                                           %生成E图

for i=80:112;
    for j=80:85;
        img(i,j)=255;
    end
end

for i=80:112;
    for j=110:115;
        img(i,j)=255;
    end
end

for i=94:99;
    for j=80:115;
        img(i,j)=255;
    end
end                                           %H生成图

%imshow(img);
%imwrite(img,'pic\object.jpg')

for i=1:64;
    for j=1:128;
        z(i,j)=-50;
    end
end

for i=65:128;
    for j=1:128;
        z(i,j)=50;
    end
end                                              %深度坐标信息 (z轴)

%
%
%
%
%计算多角度projection

pro_img=zeros(128,128);
dx=1.5e-5;
dy=dx;
k=0;
u=1;
img_temp=zeros(128,128);

for phi_y=(pi/18):(-2*pi/1800):(-pi/18);
    v=1;
    for phi_x=(-pi/18):(2*pi/1800):(pi/18);

for i=1:128;
    for j=1:128;
        xs=j-64;
        ys=64-i;
        xp=xs*cos(phi_x)-z(i,j)*sin(phi_x);
        yp=ys*cos(phi_y)-z(i,j)*sin(phi_y)*cos(phi_x)-xs*sin(phi_x)*sin(phi_y);
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
k=k+1
%nameout=['pic\pro_img(128)\pro_' num2str(k) '.bmp'];
%imwrite(pro_img,nameout);
img_temp(:,:,k)=pro_img;

    end
end

size(img_temp)
        

