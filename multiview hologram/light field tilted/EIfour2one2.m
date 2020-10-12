function EI=EIfour2one2(M,N)
EI1=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0,0).jpg')));
EI2=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0.5,0).jpg')));
EI3=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0,-0.5).jpg')));
EI4=double(rgb2gray(imread('E:\研究僧\课题\集成成像\傅里叶全息图\EI3600(0.5,-0.5).jpg')));
EI=zeros(2*M,2*N);
for i=1:M
    for j=1:N
        EI(1+(i-1)*2,1+(j-1)*2)=EI1(i,j);
        EI(1+(i-1)*2,2+(j-1)*2)=EI2(i,j);
        EI(2+(i-1)*2,1+(j-1)*2)=EI3(i,j);
        EI(2+(i-1)*2,2+(j-1)*2)=EI4(i,j);
    end
end