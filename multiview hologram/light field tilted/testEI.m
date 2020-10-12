clc;clear;
M=3600;N=3600;
m=60;n=60;micr_N=60;
EI=EIfour2one(M,N,m,n,micr_N);
%EI=EIfour2one2(M,N,m,n,micr_N);
figure;imshow(EI);
imwrite(EI,'E:\研究僧\课题\集成成像\傅里叶全息图\EIfour2one.jpg')