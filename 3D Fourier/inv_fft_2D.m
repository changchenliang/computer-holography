function output=inv_fft_2D(input,dfx,dx)
[xx,yy,]=size(input);
s=dx*dfx;
A=zeros(xx,yy);
for ii=1:xx
    for jj=1:yy
            A(ii,jj)=s*((ii-1-ceil(xx/2))^2+(jj-1-ceil(yy/2))^2);
    end
end
chirp1=exp(1i*pi*A);
chirp_conv=exp(-1i*pi*A);
input=input.*chirp1;
% L1=xx+xx-1;L2=yy+yy-1;
% input_temp=zeros(L1,L2);chirp_conv_temp=zeros(L1,L2);
% input_temp(ceil(L1/4)+1:(ceil(L1/4)+ceil(L1/2)),ceil(L2/4)+1:(ceil(L2/4)+ceil(L2/2)))=input(1:xx,1:yy);
% chirp_conv_temp(ceil(L1/4)+1:(ceil(L1/4)+ceil(L1/2)),ceil(L2/4)+1:(ceil(L2/4)+ceil(L2/2)))=chirp_conv(1:xx,1:yy);
 output=fftshift(ifft2((fft2(fftshift(input))).*(fft2(fftshift(chirp_conv)))));
% output=half_img(output_temp);
chirp2=chirp1;
output=output.*chirp2;