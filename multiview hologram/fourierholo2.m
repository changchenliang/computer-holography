function H=fourierholo2(m,n,lens_d,lens_f,micr_N,r,EI)
%每张小oi图建立一个（xp,yp）坐标系%

%H=zeros(m,n);
H=zeros(ceil(m/3),ceil(n/3));%只取EI拼成OI图的1/3
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%水平角度从-Fi/2到Fi/2
Thelta=deltathelta*m;%水平角度从-Thelta/2到Thelta/2
M=micr_N*m;
N=micr_N*n;%OI图的总像素
%for u=1:m
    %for v=1:n
for u=ceil(m/3)+1:ceil(m*2/3)
    for v=ceil(n/3)+1:ceil(n*2/3)
        oi=EI2oi(EI,micr_N,micr_N,m,n,u,v);
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;
        %与中心点像素的位移
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