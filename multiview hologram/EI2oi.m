function oi=EI2oi(EI,micr_M,micr_N,m,n,x,y)
%����ͼ��ת��Ϊ������ͼ
%EIΪ����ͼ��micr_M*micr_NΪ͸����������m,n��Ϊÿ��С����ͼ������أ�x,y��Ϊ������ͼ����

%[M,N]=size(EI);
%m=ceil(M/micr_N);n=ceil(N/micr_N);%д����������ȥ
for i=1:micr_M
    for j=1:micr_N
        oi(i,j)=EI(x+(i-1)*m,y+(j-1)*n);
    end
end