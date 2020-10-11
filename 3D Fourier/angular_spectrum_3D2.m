function [img]=angular_spectrum_3D2(obj,du,dx,r,z,phi,theta);
[nx,ny,nz]=size(obj);
R=du/dx;
if R>1 || R==1
    b=1 
    a=b/R
end
if R<1
    a=1
    b=a*R
end
dfx=a/dx/nx;
dfy=dfx;dfz=dfx;

tmp=fft_3D(obj,du,dfx);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%下面建立三维谱空间的坐标
%for ii=1:nx
%    for jj=1:ny
%        for kk=1:nz
%            u(ii,jj,kk)=du*(jj-ny/2-0.5); 
%            v(ii,jj,kk)=dv*(ii-nx/2-0.5);
%            w(ii,jj,kk)=dw*(kk-nz/2-0.5);
%        end
%    end
%end
%u=du*((1:ny)-ny/2-0.5);
%v=dv*((1:nx)-nx/2-0.5);
%w=dw*((1:nz)-nz/2-0.5);
[u,v,w]=meshgrid(dfx*((1:ny)-ny/2-0.5),dfy*((1:nx)-nx/2-0.5),dfz*((1:nz)-nz/2-0.5));

for ii=1:nx
    for jj=1:ny
        u_hemi_sph(ii,jj)=dfx*(jj-ny/2-0.5);
        v_hemi_sph(ii,jj)=dfy*(ii-nx/2-0.5);
        w_hemi_sph(ii,jj)=sqrt((1/(r^2))-(u_hemi_sph(ii,jj))^2-(v_hemi_sph(ii,jj))^2);
    end
end

w_hemi_sph=mod(w_hemi_sph,1/du);
for ii=1:nx
    for jj=1:ny
        if w_hemi_sph(ii,jj)>1/du/2;
            w_hemi_sph(ii,jj)=w_hemi_sph(ii,jj)-1/du;
        end
    end
end
%坐标旋转
Tx=[1,0,0;0,cos(phi),sin(phi);0,-sin(phi),cos(phi)];
Ty=[cos(theta),0,-sin(theta);0,1,0;sin(theta),0,cos(theta)];
T=Tx*Ty;
for ii=1:nx
    for jj=1:ny
        trans_temp=T*[ u_hemi_sph(ii,jj);v_hemi_sph(ii,jj);w_hemi_sph(ii,jj)];
        fu0(ii,jj)=trans_temp(1,1);
        fv0(ii,jj)=trans_temp(2,1);
        fw0(ii,jj)=trans_temp(3,1);
    end
end

T0=1/du/nx*(nx-1);
fu0=mod(fu0,T0);fv0=mod(fv0,T0);fw0=mod(fw0,T0);
for ii=1:nx
    for jj=1:ny
        if fu0(ii,jj)>T0/2;
            fu0(ii,jj)=fu0(ii,jj)-T0;
        end
        if fv0(ii,jj)>T0/2;
            fv0(ii,jj)=fv0(ii,jj)-T0;
        end
        if fw0(ii,jj)>T0/2;
            fw0(ii,jj)=fw0(ii,jj)-T0;
        end
    end
end

tmp2=interp3(u,v,w,tmp,fu0,fv0,fw0,'linear');
    
chrp=(1./w_hemi_sph).*exp(1i*2*pi*z.*w_hemi_sph);

m=1/r/dfx/sqrt(1+(2*z*dfx)^2);
chrpf=zeros(nx,ny);
if m<nx
    chrpf((nx-ceil(m))/2:(nx+ceil(m))/2,(ny-ceil(m))/2:(ny+ceil(m))/2)=chrp((nx-ceil(m))/2:(nx+ceil(m))/2,(ny-ceil(m))/2:(ny+ceil(m))/2);
else
    chrpf=chrp;
end
tmp2=tmp2.*chrpf;
%插值法扩大
tmp3=expanding1024(tmp2,dfx)
img=inv_fft_2D(tmp3,dfx/4,dx);


save img.mat;