function [obj_phi] = GS_Forier(img0,obj_phi)
%��ͨGS�㷨��
%obj��ʾ���渴�����img��ʾ���渴�����LCoS��Ϊ���棬ͶӰ��Ϊ���档
%dx��dfxΪ�����ʣ�dxΪLCoS�ˣ�15um��
%obj_phiΪLCoS����λ��Ϊ��������֡�Ĵ��ݹʲ�����ԭ�������в��������λ���㷨��������Ϊ�βδӵ��ú����д��ݹ���

img_amp0 = double(img0)+0.00000001; %��ȡͼ��
%img_amp0 = fliplr(img_amp0);

[nn,mm] = size(img_amp0);                %ȡ�ֱ���

%obj_phi = rand(nn,mm)*2*pi;   %%����LCoS�������λ��//���д����Ѿ�����Ҫ���ɵ��ú����д��ݹ���

r=5.32e-7;                                %����532nm����ɫ����
%z=1.5;   %ͶӰ���룬��λΪm������̫С����Ϊ��ڳ������þ��롣
b=1;
t=[];
k=[];
%Er=zeros(65);
for ii = 0:5                       %��������
    obj=b.*exp(1i.*obj_phi);                   %�ɾ��ȹ��obj_phi���LCoS�˸����������ȹ���ȫ1���󣬹�����ʡ�ԡ�
    img=fftshift(fft2(fftshift(obj)));
    %img=fft2(obj);
    q=abs(img);
    t(ii+1)=RMS(q,img_amp0);
%img_amp=abs(img);
%figure;
%a=max(max(img_amp))/256;
%imshow(uint8(img_amp/a));
%    Er(ii)=sum(sum((img_amp/a-img_amp0).^2))/sum(sum((img_amp).^2));
    
    img_phi=angle(img);
    img = img_amp0.*exp(1i.*img_phi);       %��Ŀ��ͼ���img_phi���LCoS�˸������
    obj = fftshift(ifft2(fftshift(img)));
    %obj=ifft2(img);
    obj_phi=angle(obj);
    b=avesqrt(abs(obj));
    k(ii+1)=ii;
    %ii
end
%figure; plot(k,t,'r-'); 
%axis([0 16 10 40]);

% obj=b.*exp(i.*obj_phi);
% phi=255-uint8((obj_phi+pi)*255/(2*pi));
% %imwrite(phi,'pic\rose.bmp'); 
% 
% zout=fftshift(fft2(fftshift(obj)));
% zout=abs(zout);
% zout=uint8(zout);
% figure; imshow(zout);
%imwrite(zout,'pic\exp\lena_amp_Fourier.jpg');
return;