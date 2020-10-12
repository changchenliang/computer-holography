function H=fourierholo3(m,n,lens_d,lens_f,micr_N,r)
%ÿ��Сoiͼ����һ����xp,yp������ϵ%
%CCD����ֱ�ӻ��OIͼ

H=zeros(m,n);
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%ˮƽ�Ƕȴ�-Fi/2��Fi/2
Thelta=deltathelta*m;%ˮƽ�Ƕȴ�-Thelta/2��Thelta/2
M=micr_N*m;
N=micr_N*n;%OIͼ��������
num=0;
for u=1:m
    for v=1:n
        num=num+1;
        oi=double(rgb2gray(imread(strcat('E:\�о�ɮ\����\���ɳ���\������ͼ\������ͼ(',num2str(num),').bmp'))));
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;
        %�����ĵ����ص�λ��
        deltai=ceil(u-m/2);
        deltaj=ceil(v-n/2);
        Htemp=0;
        j=1;
        for xp=-ceil(micr_N/2):ceil(micr_N/2)-1
            i=1;
            for yp=-ceil(micr_N/2):ceil(micr_N/2)-1
                Htemp=Htemp+oi(i,j)*exp(-1i*2*pi*2/r*((xp*lens_d+deltaj*deltav)*fi+(yp*lens_d+deltai*deltau)*thelta));
                i=i+1;
            end
            j=j+1;
        end
        H(u,v)=Htemp;
    end
end                