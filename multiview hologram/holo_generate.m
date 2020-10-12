dx=1.5e-5;
dy=dx;
r=5.32e-7;
f=0.5;
u=1;
b=-2*f;
load img_temp.mat
load z.mat

for phi_y=(pi/18):(-2*pi/1800):(-pi/18);
    v=1;
    for phi_x=(-pi/18):(2*pi/1800):(pi/18);
        w=(u-1)*101+v
        %namein=['pic\pro_img\pro_' num2str(w) '.bmp']; 
        %imread(namein);
        pro_img=img_temp(:,:,w);
        %pro_img=double(pro_img);

chirp=zeros(128,128);
for m=1:128;
    for n=1:128;
        xs=m-64;
        ys=64-n;
        xp=xs*cos(phi_x)-z(m,n)*sin(phi_x);
        yp=ys*cos(phi_y)-z(m,n)*sin(phi_y)*cos(phi_x)-xs*sin(phi_x)*sin(phi_y);
        nn=floor(xp+64);
        %if n==0||n<0;
         %   n=1;
        %end
        %if n>128;
         %   n=128;
        %end
        mm=floor(64-yp);
        %if m==0||m<0;
         %   m=1;
        %end
        %if m>128;
         %   m=128;
        %end
        chirp(m,n)=exp(-1i*2*pi*b*(nn*sin(phi_x)+mm*sin(phi_y)));
    end
end

pro_img=pro_img.*chirp;

sum=0;
for m=1:128;
    for n=1:128;
      sum=sum+pro_img(m,n);
    end
end
holo(u,v)=sum;
v=v+1;
    end
    u=u+1;
end

holomax=max(max(abs(holo)))
[mm,nn]=size(holo)
for i=1:mm;
    for j=1:nn;
        holo(i,j)=holo(i,j)/holomax;
    end
end
holo=holo.*255;
