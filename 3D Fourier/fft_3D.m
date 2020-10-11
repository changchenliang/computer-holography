function output=fft_3D(input,dx,dfx)
[xx,yy,zz]=size(input);
s=dx*dfx;
A=zeros(xx,yy,zz);
for ii=1:xx
    for jj=1:yy
        for kk=1:zz
            A(ii,jj,kk)=s*((ii-1-ceil(xx/2))^2+(jj-1-ceil(yy/2))^2+(kk-1-ceil(zz/2))^2);
        end
    end
end
chirp1=exp(-1i*pi*A);
chirp_conv=exp(1i*pi*A);
input=input.*chirp1;
% L1=xx+xx-1;L2=yy+yy-1;L3=zz+zz-1;
% input_temp=zeros(L1,L2,L3);chirp_conv_temp=zeros(L1,L2,L3);
% input_temp(ceil(L1/4)+1:(ceil(L1/4)+ceil(L1/2)),ceil(L2/4)+1:(ceil(L2/4)+ceil(L2/2)),ceil(L3/4)+1:(ceil(L3/4)+ceil(L3/2)))=input(1:xx,1:yy,1:zz);
% chirp_conv_temp(ceil(L1/4)+1:(ceil(L1/4)+ceil(L1/2)),ceil(L2/4)+1:(ceil(L2/4)+ceil(L2/2)),ceil(L3/4)+1:(ceil(L3/4)+ceil(L3/2)))=chirp_conv(1:xx,1:yy,1:zz);
output=fftshift(ifftn((fftn(fftshift(input))).*(fftn(fftshift(chirp_conv)))));
% output=half_img_3D(output_temp);
chirp2=chirp1;
output=output.*chirp2;