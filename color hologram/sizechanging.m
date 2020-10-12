function output=sizechanging(input,dx,a,b)

[m,n]=size(input);
X1=linspace(-m*dx/2,m*dx/2,m);
Y1=linspace(-n*dx/2,n*dx/2,n);
[X1,Y1]=meshgrid(X1,Y1);
X2=linspace(-m*dx/2,m*dx/2,a);
Y2=linspace(-n*dx/2,n*dx/2,b);
[X2,Y2]=meshgrid(X2,Y2);
output=interp2(X1,Y1,input,X2,Y2,'nearest');

return