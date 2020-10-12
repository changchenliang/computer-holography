function [C] = Lap1_gra(A)

[dx,dy]=gradient(A);
C=sqrt(dx.^2+dy.^2);