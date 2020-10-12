function [mm,nn]=enlarge(m,n,c,d,phi_max)
a1=round(n+c*tan(phi_max)*d*1000);
a2=round(-c*tan(phi_max)*d*1000);
nn=a1-a2+1;
b1=round(m+c*tan(phi_max)*d*1000);
b2=round(-c*tan(phi_max)*d*1000);
mm=b1-b2+1;
