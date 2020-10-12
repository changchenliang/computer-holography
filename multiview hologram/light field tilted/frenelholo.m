function H=frenelholo(m,n,lens_d,lens_f,micr_N,r)
%ÿ��Сoiͼ����һ����xp,yp������ϵ,����fresnelȫϢͼ�ļ��㷽ʽ�����Գ�����б��λ���ӣ��õ�fourierȫϢͼ
%CCD����ֱ�ӻ��OIͼ

H=zeros(micr_N,micr_N);
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%ˮƽ�Ƕȴ�-Fi/2��Fi/2
Thelta=deltathelta*m;%��ֱ�Ƕȴ�-Thelta/2��Thelta/2
M=micr_N*m;
N=micr_N*n;%OIͼ��������
num=0;
D=1;
for u=1:m
    for v=1:n
        num=num+1;
        oi=double(rgb2gray(imread(strcat('E:\�о�ɮ\����\���ɳ���\������ͼ\������ͼ(',num2str(num),').bmp'))));
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;    
        Htemp=zeros(micr_N,micr_N);
        for ii=1:micr_N
            for jj=1:micr_N
                Htemp(ii,jj)=oi(ii,jj)*exp(1i*2*pi*2*D/r*(fi^2+thelta^2));%������б��λ����
            end
        end
 %       Htemp= fftshift(fft2(fftshift(Htemp)));
        H=H+Htemp;
    end
end                