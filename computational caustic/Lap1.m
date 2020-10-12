function [C] = Lap1(A)

[mm,nn]=size(A);
tmp=zeros(mm+2,nn+2);
B=zeros(mm+2,nn+2);
tmp(2:mm+1,2:nn+1)=A;
for ii=2:mm+1
    for jj=2:nn+1
        B(ii,jj)=tmp(ii+1,jj)+tmp(ii,jj+1)-2*tmp(ii,jj);
    end
end
C=B(2:mm+1,2:nn+1);