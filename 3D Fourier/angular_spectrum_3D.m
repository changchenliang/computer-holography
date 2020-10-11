function [img]=angular_spectrum_3D(obj,dx,r,z);

[nx,ny,nz]=size(obj);
dy=dx; dz=3e-5;

du = 1/(dx*ny);
dv = 1/(dy*nx);
dw = 1/(dz*nz);

tmp=fftshift(fftn(fftshift(obj)));

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
[u,v,w]=meshgrid(du*((1:ny)-ny/2-0.5),dv*((1:nx)-nx/2-0.5),dw*((1:nz)-nz/2-0.5));

for ii=1:nx
    for jj=1:ny
        u_hemi_sph(ii,jj)=du*(jj-ny/2-0.5);
        v_hemi_sph(ii,jj)=dv*(ii-nx/2-0.5);
        w_hemi_sph(ii,jj)=sqrt((1/(r^2))-(u_hemi_sph(ii,jj))^2-(v_hemi_sph(ii,jj))^2);
    end
end

w_hemi_sph2=mod(w_hemi_sph,1/dx);
tmp2=interp3(u,v,w,tmp,u_hemi_sph,v_hemi_sph,w_hemi_sph2,'linear');

chrp=(1./w_hemi_sph).*exp(1i*2*pi*z.*w_hemi_sph);

img=fftshift(ifft2(fftshift(tmp2.*chrp)));

save img.mat;





