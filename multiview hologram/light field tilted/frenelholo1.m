function H=frenelholo1(m,n,lens_d,lens_f,micr_N,r,EI,z)
%ÿ��Сoiͼ����һ����xp,yp������ϵ��,����fresnelȫϢͼ�ļ��㷽ʽ�����Գ�����б��λ���ӣ��õ�fourierȫϢͼ
%ͨ��EIͼת���ķ�ʽ���OIͼ

deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%ˮƽ�Ƕȴ�-Fi/2��Fi/2
Thelta=deltathelta*m;%��ֱ�Ƕȴ�-Thelta/2��Thelta/2
M=micr_N*m;
N=micr_N*n;%OIͼ��������
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