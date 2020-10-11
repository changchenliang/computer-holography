% nonuniform sampled fresnel diffraction based on nufft
function output=nufresneld2 (input,x_out,y_out,yn_in,xn_in,iflag,eps,r,z,din)
[mm,nn]=size(x_out);
nj=mm*nn;
for ii=1:yn_in
    for jj=1:xn_in
        chrp1(ii,jj)=exp(1i*pi/r/z*(din^2*(jj-1-ceil(xn_in/2))^2+din^2*(ii-1-ceil(yn_in/2))^2));
    end
end
%input=input.*chrp1;

xmax=max(max(x_out));
x_out_tmp=2*pi*(x_out+xmax)/(2*xmax)-pi;
ymax=max(max(y_out));
y_out_tmp=2*pi*(y_out+ymax)/(2*ymax)-pi;
%input=fftshift(input);
[output_tmp,ier]=nufft2d2(nj,y_out_tmp,x_out_tmp,iflag,eps,yn_in,xn_in,input);
for jj=1:nn
    for ii=1:mm
        output(ii,jj)=output_tmp(mm*(jj-1)+ii,1);
    end
end
%output=fftshift(output);
%output=output';

for ii=1:mm
    for jj=1:nn
        chrp2(ii,jj)=exp(1i*pi/r/z*(x_out(ii,jj)^2+y_out(ii,jj)^2));
    end
end

output=output.*chrp2;