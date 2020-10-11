function out_img=half_img_3D(in_img);
[m,n,p]=size(in_img);
out_img=zeros(ceil(m/2),ceil(n/2),ceil(p/2));
out_img(1:ceil(m/2),1:ceil(n/2),1:ceil(p/2))=in_img(ceil(m/4):(ceil(m/4)+ceil(m/2)-1),ceil(n/4):(ceil(n/4)+ceil(n/2)-1),ceil(p/4):(ceil(p/4)+ceil(p/2)-1));