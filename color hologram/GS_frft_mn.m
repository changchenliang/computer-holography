function [obj_phi] = GS_frft_mn(img0,obj_phi,a,r,f1);     %��������ͼ��ĳ������ʱ��ȫϢͼ
%��ͨGS�㷨��
%obj��ʾ���渴�����img��ʾ���渴�����LCoS��Ϊ���棬ͶӰ��Ϊ���档
%dx��dfxΪ�����ʣ�dxΪLCoS�ˣ�15um��
%obj_phiΪLCoS����λ��Ϊ��������֡�Ĵ��ݹʲ�����ԭ�������в��������λ���㷨��������Ϊ�βδӵ��ú����д��ݹ���

%img0=enlarge_2_512(img0);
img_amp0 = double(img0)+0.00000001; %��ȡͼ��
%img_amp0 = fftshift(img_amp0);
%img_amp0 = fliplr(img_amp0);
%img_amp0 = flipud(img_amp0);
[mm,nn] = size(img_amp0);                %ȡ�ֱ���

%obj_phi = rand(nn,mm)*2*pi;   %%����LCoS�������λ��//���д����Ѿ�����Ҫ���ɵ��ú����д��ݹ���

%r=5.32e-7;                                %����532nm����ɫ����
%f1=0.5;
dx=8e-6;
dy=dx;
fe=f1*sin(a*pi/2);
z=f1*sin(a*pi/2)*tan(a*pi/4)

b=1;
p=0;
t=[];
k=[];
for ii = 0:16                %��������
    obj=b.*exp(i.*obj_phi);                   %�ɾ��ȹ��obj_phi���LCoS�˸����������ȹ���ȫ1���󣬹�����ʡ�ԡ�
    %img=frft(obj,a);
    %img=myfrft(obj,a,dx,r,z,fe);
    %img=myfrft2(obj,a);
    [dfx,dfy,img]=frft_mn(obj,a,dx,dy,r,fe);
%img_amp=abs(img);
%figure;
%a=max(max(img_amp))/256;
%imshow(uint8(img_amp/a));
%    Er(ii)=sum(sum((img_amp/a-img_amp0).^2))/sum(sum((img_amp).^2));
    
    q=abs(img);
    t(ii+1)=RMS(q,img_amp0);
    
    img_phi=angle(img);
    img = img_amp0.*exp(i.*img_phi);       %��Ŀ��ͼ���img_phi���LCoS�˸������
    %obj = frft(img,-a);
    %obj = myfrft(img,-a,dfx,r,z,fe);
    %obj = myfrft2(img,-a);
    [dx,dy,obj]=inv_frft_mn(img,a,dfx,dfy,r,fe);
    obj_phi=angle(obj);
    b=avesqrt(abs(obj));
    k(ii+1)=ii;
    ii

end


obj=b.*exp(i.*obj_phi);
[dfx,dfy,zout]=frft_mn(obj,a,dx,dy,r,fe);
zout=abs(zout);
plot(k,t,'r-');                           %��������ǰ���������ŵ��������仯��ͼ��
%axis([0 16 10 40]);
phi=255-uint8((obj_phi+pi)*255/(2*pi));
imwrite(phi,'pic\lena19201080.bmp');          %�����λͼ

res=abs(zout-img0);
zout=uint8(zout);
imwrite(zout,'pic\lena19201080_rec.jpg');          %�����ԭ���ͼ��

%imshow(res);                               %�����в�ͼ
return;