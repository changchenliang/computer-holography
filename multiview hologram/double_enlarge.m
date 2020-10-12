function img=double_enlarge(img0);
[mm,nn]=size(img0);
img=zeros(2*mm,2*nn);
img(1:mm,1:nn)=img0(1:mm,1:nn);
