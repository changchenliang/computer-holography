function H=fourierholo(m,n,lens_d,lens_f,micr_N,OI,r)
%����OIͼ����һ����xp,yp������ϵ%

%r=;%����,д����������ȥ
H=zeros(m,n);
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%ˮƽ�Ƕȴ�-Fi/2��Fi/2
Thelta=deltathelta*m;%��ֱ�Ƕȴ�-Thelta/2��Thelta/2
M=micr_N*m;
N=micr_N*n;%OIͼ��������
for u=1:m
    for v=1:n
        Htemp=0;
        %����������ƽ��N/2,M/2������ԭ��ȡ��OIͼ������
        for xp=-ceil(N/2)+(v-1)*micr_N+1:-ceil(N/2)+v*micr_N
            for yp=ceil(M/2)-(u-1)*micr_N-1:-1:ceil(M/2)-u*micr_N
                fi=-Fi/2+(v-1)*deltafi;
                thelta=Thelta/2-(u-1)*deltathelta;
                Htemp=Htemp+OI(abs(yp-ceil(M/2)),xp+ceil(N/2))*exp(-1i*2*pi*2/r*(xp*deltau*fi+yp*deltav*thelta));
            end
        end
        H(u,v)=Htemp;
    end
end                