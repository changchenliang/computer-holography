function oi=EI2oi(EI,micr_M,micr_N,m,n,x,y)
%基本图像转化为正交子图
%EI为基本图像，micr_M*micr_N为透镜个数，（m,n）为每张小基本图像的像素（x,y）为正交子图坐标

%[M,N]=size(EI);
%m=ceil(M/micr_N);n=ceil(N/micr_N);%写到主程序里去
for i=1:micr_M
    for j=1:micr_N
        oi(i,j)=EI(x+(i-1)*m,y+(j-1)*n);
    end
end