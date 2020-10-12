function [b,obj_phi] = GS_Fresnel(img0,obj_phi,z)
%ʹ�÷��������乫ʽ��GS�㷨��������Ҷ��ѧ���ۡ�������P61����ʽ4.17
%obj��ʾ���渴�����img��ʾ���渴�����LCoS��Ϊ���棬ͶӰ��Ϊ���档
%dx��dfxΪ�����ʣ�dxΪLCoS�ˣ�15um��
%obj_phiΪLCoS����λ��Ϊ��������֡�Ĵ��ݹʲ�����ԭ�������в��������λ���㷨��������Ϊ�βδӵ��ú����д��ݹ���

img_amp0 = double(img0)+0.00000001; %��ȡͼ��
[nn,mm] = size(img_amp0);                  %ȡ�ֱ���

%obj_phi = rand(nn,mm)*2*pi;   %%����LCoS�������λ��//���д����Ѿ�����Ҫ���ɵ��ú����д��ݹ���

r=5.32e-7;                                %����532nm����ɫ����
%z=1.5;                                     %ͶӰ���룬��λΪm������̫С����Ϊ��ڳ������þ��롣
phi_y=45*pi/180;
dx=1.5e-5;
dy=dx;
dfy = 1/(dy*nn)*r*z;
dfx=dfy;
b=1;

for ii=1:nn
    for jj=1:mm
        slant_phi=exp(-1i*(2*pi)*(nn-512/2)*dfy*tan(phi_y));
    end
end

for ii = 1:64                              %��������
    obj=exp(1i.*obj_phi);                   %�ɾ��ȹ��obj_phi���LCoS�˸����������ȹ���ȫ1���󣬹�����ʡ�ԡ�
    [dfx img ] = fresnel_cov( dx, r, obj, z );
    img_phi=angle(img);
    img = img_amp0.*slant_phi.*exp(1i.*img_phi);       %��Ŀ��ͼ���img_phi���LCoS�˸������
    [dx obj ] = inv_fresnel_cov(dfx, r, img, z );
    obj_phi=angle(obj);
    b=avesqrt(abs(obj));
    ii
end

%img_amp=abs(img);
%figure;
%imshow(img_amp);           %��[]ֻ�ԻҶ�ͼ��Ч��



return;