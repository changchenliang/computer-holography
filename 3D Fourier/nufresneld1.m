% nonuniform sampled Fresnel diffraction based on nufft
function output=nufresneld1 (input,x_in,y_in,yn_out,xn_out,iflag,eps,r,z,dout)
[mm,nn]=size(input);
nj=mm*nn;
for ii=1:mm
    for jj=1:nn
        chrp1(ii,jj)=exp(1i*pi/r/z*(x_in(ii,jj)^2+y_in(ii,jj)^2));
    end
end
input=input.*chrp1;

xmax=max(max(x_in));
x_in_tmp=2*pi*(x_in+xmax)/(2*xmax)-pi;
ymax=max(max(y_in));
y_in_tmp=2*pi*(y_in+ymax)/(2*ymax)-pi;
%input=fftshift(input);
[output,ier]=nufft2d1(nj,y_in_tmp,x_in_tmp,input,iflag,eps,yn_out,xn_out);
%output=fftshift(output);
for ii=1:yn_out
    for jj=1:xn_out
        chrp2(ii,jj)=exp(1i*pi/r/z*(dout^2*(jj-1-ceil(xn_out/2))^2+dout^2*(ii-1-ceil(yn_out/2))^2));
    end
end
%output=output';
%save output.mat;
output=output.*chrp2;