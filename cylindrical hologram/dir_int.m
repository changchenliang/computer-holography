% direct integral

function [img]=dir_int(obj,lamda,R,r,theta1,h1,theta2,h2);

[m1,n1]=size(obj);
[m2,n2]=size(theta2);
k=2*pi/lamda;

for ii=1:m2
    for jj=1:n2
        img_tmp=0;
        for kk=1:m1
            for ll=1:n1
                L=sqrt(R^2+r^2-2*R*r*cos(theta1(kk,ll)-theta2(ii,jj))+(h1(kk,ll)-h2(ii,jj))^2);
                img_tmp=img_tmp+obj(kk,ll)/L*exp(1i*k*L);
            end
        end
        img(ii,jj)=img_tmp;
        %n2*(ii-1)+jj
    end
    ii
end

