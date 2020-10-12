
function shiftimg=img_shift(img,theta,fi,z,dx,dy);

[mm,nn]=size(img);
xshift=floor(z*fi/dx);
yshift=floor(z*theta/dy);

se=translate(strel(1),[xshift -yshift]);
shiftimg=imdilate(img1,se);
