function EI=EIfour2one(M,N,m,n,micr_N)
EI1=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0,0).jpg')));
EI2=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0.5,0).jpg')));
EI3=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0,-0.5).jpg')));
EI4=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0.5,-0.5).jpg')));
EI=zeros(2*M,2*N);
for i=1:micr_N
    for j=1:micr_N
        EI(1+(i-1)*m*2:m+(i-1)*m*2,1+(j-1)*n*2:n+(j-1)*n*2)=EI1(1+(i-1)*m:m+(i-1)*m,1+(j-1)*n:n+(j-1)*n);
        EI(1+(i-1)*m*2:m+(i-1)*m*2,n+1+(j-1)*n*2:n*2+(j-1)*n*2)=EI2(1+(i-1)*m:m+(i-1)*m,1+(j-1)*n:n+(j-1)*n);
        EI(m+1+(i-1)*m*2:m*2+(i-1)*m*2,1+(j-1)*n*2:n+(j-1)*n*2)=EI3(1+(i-1)*m:m+(i-1)*m,1+(j-1)*n:n+(j-1)*n);
        EI(m+1+(i-1)*m*2:m*2+(i-1)*m*2,n+1+(j-1)*n*2:n*2+(j-1)*n*2)=EI4(1+(i-1)*m:m+(i-1)*m,1+(j-1)*n:n+(j-1)*n);
    end
end