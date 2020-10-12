function H=fourierholo(m,n,lens_d,lens_f,micr_N,OI,r)
%整张OI图建立一个（xp,yp）坐标系%

%r=;%波长,写到主程序中去
H=zeros(m,n);
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%水平角度从-Fi/2到Fi/2
Thelta=deltathelta*m;%垂直角度从-Thelta/2到Thelta/2
M=micr_N*m;
N=micr_N*n;%OI图的总像素
for u=1:m
    for v=1:n
        Htemp=0;
        %将横竖坐标平移N/2,M/2，即将原点取在OI图像中心
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