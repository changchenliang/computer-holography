function out_img=double_img(in_img);
[m,n]=size(in_img);
out_img=zeros(2*m,2*n);
out_img(ceil(m/2):(ceil(m/2)+m-1),ceil(n/2):(ceil(n/2)+n-1))=in_img(1:m,1:n);