function H=fourierholo4(m,n,lens_d,lens_f,micr_N,r,EI)
%ÿ��Сoiͼ����һ����xp,yp������ϵ%

H=zeros(ceil(2*m/3),ceil(2*n/3));
deltau=lens_d/n/2;
deltav=lens_d/m/2;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n*2;%ˮƽ�Ƕȴ�-Fi/2��Fi/2
Thelta=deltathelta*m*2;%ˮƽ�Ƕȴ�-Thelta/2��Thelta/2
M=micr_N*m;
N=micr_N*n;%OIͼ��������
%for u=1:m
    %for v=1:n
for u=ceil(m*2/3)+1:ceil(m*4/3)
    for v=ceil(n*2/3)+1:ceil(n*4/3)
        oi=EI2oi(EI,micr_N,micr_N,m,n,ceil(u/2),ceil(v/2));
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;
        %�����ĵ����ص�λ��
        deltai=ceil(u/2-m/2);
        deltaj=ceil(v/2-n/2);
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
        H(u-ceil(m*2/3),v-ceil(n*2/3))=Htemp;
    end
end                