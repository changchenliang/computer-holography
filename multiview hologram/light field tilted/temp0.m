%temp

dx=8e-6; dy=dx;
%H=zeros(m,n);
%H=zeros(ceil(m/3),ceil(n/3));
deltau=lens_d/n;
deltav=lens_d/m;
deltafi=deltau/lens_f;
deltathelta=deltav/lens_f;
Fi=deltafi*n;%水平角度从-Fi/2到Fi/2
Thelta=deltathelta*m;%水平角度从-Thelta/2到Thelta/2
M=micr_N*m;
N=micr_N*n;%OI图的总像素
mm=micr_N;
nn=micr_N;
    
    H=0;
 u=42
  v=70
        oi=EI2oi(EI,micr_N,micr_N,m,n,u,v);
        phi_tx=-Fi/2+(v-1)*deltafi;
        phi_ty=Thelta/2-(u-1)*deltathelta;
        Tx=[1,0,0;0,cos(phi_tx),sin(phi_tx);0,-sin(phi_tx),cos(phi_tx)];
        Ty=[cos(phi_ty),0,-sin(phi_ty);0,1,0;sin(phi_ty),0,cos(phi_ty)];      %坐标旋转矩阵
        tmp = fftshift(fft2(fftshift(oi)));               %tmp为物光波的频谱，待插值  
        dfx = 1/(dx*nn);
        dfy = 1/(dy*mm);                  %参数选取（物面的频谱面的采样率）  
        fu=zeros(mm,nn);
        fv=zeros(mm,nn);
        fw=zeros(mm,nn);
for ii=1:mm
    for jj=1:nn
        fu(ii,jj)=dfx*(jj-nn/2-0.5);
        fv(ii,jj)=dfy*(ii-mm/2-0.5);
        fw(ii,jj)=sqrt((1/(r^2))-(fu(ii,jj))^2-(fv(ii,jj))^2);
    end
end                                                  %物面频谱空间的坐标
fux=zeros(mm,nn);
fvy=zeros(mm,nn);                                   %fux和fvy为通过fufv计算得到的参考面频谱空间的坐标
for ii=1:mm
    for jj=1:nn
        temp=Tx*Ty*[fu(ii,jj);fv(ii,jj);fw(ii,jj)];
        fux(ii,jj)=temp(1,1);
        fvy(ii,jj)=temp(2,1);
        fwz(ii,jj)=temp(3,1);
    end
end        
fuu=zeros(nn,mm);
fvv=zeros(nn,mm);                                  %待插值坐标
temp_xmax=min(fux(:,mm));
temp_xmin=max(fux(:,1));
temp_ymax=min(fvy(mm,:));
temp_ymin=max(fvy(1,:));
dtempx=(temp_xmax-temp_xmin)/(mm-1);
dtempy=(temp_ymax-temp_ymin)/(nn-1);
dtemp=min(dtempx,dtempy);
fww=zeros(mm,nn);
for ii=1:nn
    for jj=1:mm
        fuu(ii,jj)=temp_xmin+(jj-1)*dtemp;
        fvv(ii,jj)=temp_ymin+(ii-1)*dtemp;
        fww(ii,jj)=sqrt((1/(r^2))-(fuu(ii,jj))^2-(fvv(ii,jj))^2);
    end
end                                                %待插值坐标，把之前的不均匀坐标取成均匀的

zout=griddata(fux,fvy,tmp,fuu,fvv,'cubic');
%figure; plot3(fuu,fvv,abs(zout));
% for ii=1:nn
%     for jj=1:mm
%         J(ii,jj)=cos(phi_t)-sin(phi_t)*fuu(ii,jj)/fww(ii,jj);
%     end
% end
Htemp=fftshift(ifft2(fftshift(zout)));
%save Htemp.mat;
%du=1/(dtemp*mm)
        
  
        H=H+Htemp;
        %H(u-ceil(m/3),v-ceil(n/3))=Htemp;
        
  u
