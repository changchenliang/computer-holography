function H=fourierholo2(m,n,lens_d,lens_f,micr_N,r,EI)
%ÿ��Сoiͼ����һ����xp,yp������ϵ%

%H=zeros(m,n);
H=zeros(ceil(m/3),ceil(n/3));%ֻȡEIƴ��OIͼ��1/3
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%ˮƽ�Ƕȴ�-Fi/2��Fi/2
Thelta=deltathelta*m;%ˮƽ�Ƕȴ�-Thelta/2��Thelta/2
M=micr_N*m;
N=micr_N*n;%OIͼ��������
%for u=1:m
    %for v=1:n
for u=ceil(m/3)+1:ceil(m*2/3)
    for v=ceil(n/3)+1:ceil(n*2/3)
        oi=EI2oi(EI,micr_N,micr_N,m,n,u,v);
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;
        %�����ĵ����ص�λ��
        deltai=-ceil(u-m/2);
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
        %H(u,v)=Htemp;
        H(u-ceil(m/3),v-ceil(n/3))=Htemp;
    end
end                