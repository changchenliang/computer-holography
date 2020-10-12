function [dfx img ] = fresnel_cov(dx, r, obj, z )
%FRESNEL_COV Summary of this function goes here
%菲涅尔衍射
%   Detailed explanation goes here
% 注意，该公式不可以直接用于反向光线传播，由于在两个成像平面上采样率不同。

%dx是采样率
dy = dx;
[nn,mm] = size(abs(obj));
%obj=fftshift(obj);

dfx = 1/(dx*nn)*r*z;
dfy = 1/(dy*mm)*r*z;

% Q operator with dfx, dfy at frequency plane
q_pha_obj = zeros(nn,mm);
for ii = 1:nn
    for jj = 1:mm
    q_pha_obj(ii,jj) = dx^2*(ii)^2 + dy^2*(jj)^2; % x^2 + y^2
    end
end

q_pha_img = zeros(nn,mm);
for ii = 1:nn
    for jj = 1:mm
    q_pha_img(ii,jj) = dfx^2*(ii)^2 + dfy^2*(jj)^2; % fx^2 + fy^2
    end
end
% q_pha_img = e_pha_dx;

pha_obj = exp(i*pi/z/r.*q_pha_obj); % exp(j*k/2/z*(x^2+y^2))
pha_img = exp(i*pi/z/r.*q_pha_img); % exp(j*k/2/z*(fx^2+fy^2))

img = fftshift(fft2(fftshift(obj.*pha_obj)));
img = img.*pha_img;


end
