function [dfx img ] = fresnel_cov(dx, r, obj, z )
%FRESNEL_COV Summary of this function goes here
%����������
%   Detailed explanation goes here
% ע�⣬�ù�ʽ������ֱ�����ڷ�����ߴ�������������������ƽ���ϲ����ʲ�ͬ��

%dx�ǲ�����
dy = dx;
[nn,mm] = size(abs(obj));

dfx = 1/(dx*nn)*r*z;
dfy = 1/(dy*mm)*r*z;

% Q operator with dfx, dfy at frequency plane
q_pha_obj = zeros(nn,mm);
for ii = 1:nn
    for jj = 1:mm
    q_pha_obj(ii,jj) = dx^2*(jj-mm/2)^2 + dy^2*(ii-nn/2)^2; % x^2 + y^2
    end
end

q_pha_img = zeros(nn,mm);
for ii = 1:nn
    for jj = 1:mm
    q_pha_img(ii,jj) = dfx^2*(jj-mm/2)^2 + dfy^2*(ii-nn/2)^2; % fx^2 + fy^2
    end
end
% q_pha_img = e_pha_dx;

pha_obj = exp(i*pi/z/r.*q_pha_obj); % exp(j*k/2/z*(x^2+y^2))
pha_img = exp(i*pi/z/r.*q_pha_img); % exp(j*k/2/z*(fx^2+fy^2))

img = fftshift(fft2(fftshift(obj.*pha_obj)));
img = img.*pha_img;


end
