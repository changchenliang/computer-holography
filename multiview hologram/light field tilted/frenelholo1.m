function H=frenelholo1(m,n,lens_d,lens_f,micr_N,r,EI,z)
%每张小oi图建立一个（xp,yp）坐标系，,仿照fresnel全息图的计算方式（乘以常数倾斜相位因子）得到fourier全息图
%通过EI图转换的方式获得OI图

deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%水平角度从-Fi/2到Fi/2
Thelta=deltathelta*m;%垂直角度从-Thelta/2到Thelta/2
M=micr_N*m;
N=micr_N*n;%OI图的总像素
num=0;
%z=0.3;
%OI=oi2OI(EI,micr_N,micr_N,m,n);
%imwrite(mat2gray(OI),'CDOI.jpg');
H=zeros(2*micr_N,2*micr_N);
for u=1:m
    for v=1:n
        num=num+1;
        oi=EI2oi(EI,micr_N,micr_N,m,n,u,v);
        %imwrite(mat2gray(oi),['CD\' num2str((u-1)*n+v) '.jpg']);
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;   
        oitmp=enlarge_anysize(oi,2*micr_N,2*micr_N);
        se=translate(strel(1),[floor(2*z*tan(thelta)/lens_d) floor(-2*z*tan(fi)/lens_d)]);
        oi2=imdilate(oitmp,se);
        oi2(oi2==-inf)=0;
        Htemp=oi2.*exp(-1i*2*pi*2*z/r*(fi^2+thelta^2));
        %Htemp= fftshift(fft2(fftshift(Htemp)));
        H=H+Htemp;
    end 
    u
end                