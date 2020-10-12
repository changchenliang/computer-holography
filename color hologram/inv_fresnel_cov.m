function [dx obj ] = inv_fresnel_cov( dfx, r, img, zji )
%INV_FRESNEL_COV Summary of this function goes here
%   Detailed explanation goes here

dfy = dfx;
[nn,mm] = size(abs(img));
z = -abs(zji);

dx = 1/(dfx*nn)*r*z;
dy = 1/(dfy*mm)*r*z;

% Q operator with dfx, dfy at frequency plane
q_pha_img = zeros(nn,mm);
for ii = 1:nn
    for jj = 1:mm
    q_pha_img(ii,jj) = dfx^2*(jj-mm/2)^2 + dfy^2*(ii-nn/2)^2; % fx^2 + fy^2
    end
end


q_pha_obj = zeros(nn,mm);
for ii = 1:nn
    for jj = 1:mm
    q_pha_obj(ii,jj) = dx^2*(jj-mm/2)^2 + dy^2*(ii-nn/2)^2; % x^2 + y^2
    end
end

pha_img = exp(i*pi/z/r.*q_pha_img); % exp(j*k/2/z*(fx^2+fy^2))
pha_obj = exp(i*pi/z/r.*q_pha_obj); % exp(j*k/2/z*(x^2+y^2))

tmp = fftshift(ifft2(fftshift(img.*pha_img)));
obj = tmp.*pha_obj;


end
