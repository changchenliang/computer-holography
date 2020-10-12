function [C] = Lap2_gra(A)

[dx,dy]=gradient(A);
[dxx,dxy]=gradient(dx);
[dyx,dyy]=gradient(dy);
C=(dxx)+(dyy);