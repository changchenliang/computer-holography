function [dfx, dfy, img]=fresnel_onedim(dx,dy,r,obj,z)
%������������� ����һάFFT���㣬��x�����y����ֱ����
%���ּ��㷽������dx��dy�����

[mm,nn] = size(abs(obj));
dfx = 1/(dx*nn)*r*z;
dfy = 1/(dy*mm)*r*z;

chrpx = zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    chrpx(ii,jj) = exp(1i*pi/r/z*dx^2*(jj)^2); % x^2
    end
end

obj=(obj.*chrpx)';
obj=(fft(obj))';

chrpu=zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    chrpu(ii,jj) = exp(1i*pi/r/z*dfx^2*(jj)^2); % u^2
    end
end

obj=obj.*chrpu;                                              %x����������

chrpy = zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    chrpy(ii,jj) = exp(1i*pi/r/z*dy^2*(ii)^2); % y^2
    end
end

obj=obj.*chrpy;
obj=fft(obj);

chrpv=zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
    chrpv(ii,jj) = exp(1i*pi/r/z*dfy^2*(ii)^2); % v^2
    end
end

img=obj.*chrpv;                                              %y����������

img=fftshift(fliplr(img));


