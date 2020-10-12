function H=frenelholo(m,n,lens_d,lens_f,micr_N,r)
%每张小oi图建立一个（xp,yp）坐标系,仿照fresnel全息图的计算方式（乘以常数倾斜相位因子）得到fourier全息图
%CCD阵列直接获得OI图

H=zeros(micr_N,micr_N);
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%水平角度从-Fi/2到Fi/2
Thelta=deltathelta*m;%垂直角度从-Thelta/2到Thelta/2
M=micr_N*m;
N=micr_N*n;%OI图的总像素
num=0;
D=1;
for u=1:m
    for v=1:n
        num=num+1;
        oi=double(rgb2gray(imread(strcat('E:\研究僧\课题\集成成像\正交子图\正交子图(',num2str(num),').bmp'))));
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;    
        Htemp=zeros(micr_N,micr_N);
        for ii=1:micr_N
            for jj=1:micr_N
                Htemp(ii,jj)=oi(ii,jj)*exp(1i*2*pi*2*D/r*(fi^2+thelta^2));%乘以倾斜相位因子
            end
        end
 %       Htemp= fftshift(fft2(fftshift(Htemp)));
        H=H+Htemp;
    end
end                