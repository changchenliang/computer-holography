function OI=oi2OI(EI,micr_M,micr_N,m,n)
M=micr_M*m;
N=micr_N*n;
OI=zeros(M,N);
for i=1:m
    for j=1:n
%for i=ceil(m/3)+1:ceil(m*2/3)
    %for j=ceil(n/3)+1:ceil(n*2/3)
        oi=EI2oi(EI,micr_M,micr_N,m,n,i,j);
        OI((1+(i-1)*micr_M):(i*micr_M),(1+(j-1)*micr_N):(j*micr_N))=oi(1:micr_M,1:micr_N);
    end
end