function y=RMS(f,g);
[m,n]=size(f);
f=abs(f);
g=abs(g);
a=0;
for i=1:m;
    for j=1:n;
    a=a+(abs(f(i,j)-g(i,j)));
    end
end
y=sqrt(a/(m*n));