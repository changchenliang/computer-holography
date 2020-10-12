%直接读取彩色图片人鸟图作为projection images

d=100;
r=5.32e-7;
dx=1.5e-5;
dy=dx;
k=0;
u=1;
h=zeros(380,576);
holo=zeros(380,576);
phi_x=-pi/18;
phi_y=pi/18;

for i=1:11;
    for j=1:11;
namein=['pic\sub_img\' num2str(i) '_' num2str(j) '.bmp']; 
imread(namein);
pro_img=imread(namein);
pro_img=double(rgb2gray(pro_img));

%{
for i=1:380;
    for j=1:576;
        jj=j-2*tan(phi_x)*d;
        ii=i-2*tan(phi_y)*d;
        n=floor(jj);
        if n==0||n<0;
            n=1;
            pro_img(:,n)=0;
        end
        if n>576;
            n=576;
            pro_img(:,n)=0;
        end
        m=floor(ii);
        if m==0||m<0;
            m=1;
            pro_img(m,:)=0;
        end
        if m>380;
            m=380;
            pro_img(m,:)=0;
        end
        h(i,j)=pro_img(m,n);
    end
end
%nameout=['pic\pro_shift\proshift_' num2str(k) '.bmp'];
%imwrite(h,nameout);
%}

b=2*d/r;
chrp=exp(1i*2*pi*b*((tan(phi_x))^2+(tan(phi_y))^2));
holo=holo+pro_img.*chrp;

phi_x=phi_x+(pi/180);
    end
    phi_y=phi_y+(-pi/180);
end                                    %相位图holo生成完毕

phi=angle(holo);
phi=255-uint8((phi+pi)*255/(2*pi));
imwrite(phi,'pic\exp\color_holo.bmp');   %保存相位图

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