function y=avesqrt(f);
[m,n]=size(f);
a=0;
for i=1:m
    for j=1:n
        a=a+(f(i,j))^2;
    end
end
y=sqrt(a/(m*n));    