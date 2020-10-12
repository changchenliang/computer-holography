function H=fourierholo5(m,n,lens_d,lens_f,micr_N,r,EI)
%每张小oi图建立一个（xp,yp）坐标系%

H=zeros(m,n);
%H=zeros(ceil(m/3),ceil(n/3));
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%水平角度从-Fi/2到Fi/2
Thelta=deltathelta*m;%水平角度从-Thelta/2到Thelta/2
M=micr_N*m;
N=micr_N*n;%OI图的总像素
EIx=zeros(M,N);
EIy=zeros(M,N);
for i=1:M
    for j=1:N
        deltai=-ceil(i-M/2);
        deltaj=ceil(j-N/2);
        EIx(i,j)=deltaj*deltav;
        EIy(i,j)=deltai*deltau;
    end
end
for u=1:m
    for v=1:n
%for u=ceil(m/3)+1:ceil(m*2/3)
    %for v=ceil(n/3)+1:ceil(n*2/3)
        oi=EI2oi(EI,micr_N,micr_N,m,n,u,v);
        fi=-Fi/2+(v-1)*deltafi;
        thelta=Thelta/2-(u-1)*deltathelta;
        Htemp=0;
        EIxtemp=EIx(u:m:u+(micr_N-1)*m,v:n:v+(micr_N-1)*n);
        EIytemp=EIy(u:m:u+(micr_N-1)*m,v:n:v+(micr_N-1)*n);
        for i=1:micr_N
            for j=1:micr_N
                Htemp=Htemp+oi(i,j)*exp(-1i*2*pi*2/r*(EIxtemp(i,j)*fi+EIytemp(i,j)*thelta));
            end
        end
        H(u,v)=Htemp;
        %H(u-ceil(m/3),v-ceil(n/3))=Htemp;
    end
    u
end                