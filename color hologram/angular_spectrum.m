function [ du, img ] = angular_spectrum( dx, r, obj, z );
%ANGULAR_SPECTRUM Summary of this function goes here
%   Detailed explanation goes here

%!!!!!!!!
%ע�⣺r=r0/n���������ǹ��ڽ����еĲ�������������еĲ�����
% disp('���״������������򴫲�zΪ�������򴫲�zΪ��');
% disp(strcat('z = ',num2str(z)));
% disp('ע�⣺r=r0/n���������ǹ��ڽ����еĲ�������������еĲ�����');
% disp('');

dy = dx;
du = dx;
[mm,nn] = size(abs(obj));

dfx = 1/(dx*nn);
dfy = 1/(dy*mm);



% % Q operator with dfx, dfy at frequency plane
pha = zeros(mm,nn);
for ii = 1:mm
    for jj = 1:nn
        pha(ii,jj) = dfx^2*(ii-nn/2-0.5)^2 + dfy^2*(jj-mm/2-0.5)^2; % fx^2 + fy^2
    end
end

% pha = e_pha_dfx;
e_pha = exp(1i*2*pi*z/r.*sqrt(1-r^2.*pha));

tmp = fftshift(fft2(fftshift(obj)));
tmp = tmp.*e_pha;
img = fftshift(ifft2(fftshift(tmp)));

return