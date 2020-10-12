function [b,obj_phi] = GS_Fresnel(img0,obj_phi,z)
%使用菲涅尔衍射公式的GS算法。《傅里叶光学导论》第三版P61，公式4.17
%obj表示物面复振幅，img表示像面复振幅。LCoS端为物面，投影面为像面。
%dx、dfx为采样率，dx为LCoS端，15um。
%obj_phi为LCoS端相位，为便于相邻帧的传递故不采用原来函数中产生随机相位的算法，而是作为形参从调用函数中传递过来

img_amp0 = double(img0)+0.00000001; %读取图像
[nn,mm] = size(img_amp0);                  %取分辨率

%obj_phi = rand(nn,mm)*2*pi;   %%产生LCoS端随机相位。//这行代码已经不需要，由调用函数中传递过来

r=5.32e-7;                                %波长532nm，绿色激光
%z=1.5;                                     %投影距离，单位为m，不能太小。改为入口程序设置距离。
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

for ii = 1:64                              %迭代次数
    obj=exp(1i.*obj_phi);                   %由均匀光和obj_phi组成LCoS端复振幅。因均匀光是全1矩阵，故这里省略。
    [dfx img ] = fresnel_cov( dx, r, obj, z );
    img_phi=angle(img);
    img = img_amp0.*slant_phi.*exp(1i.*img_phi);       %由目标图像和img_phi组成LCoS端复振幅。
    [dx obj ] = inv_fresnel_cov(dfx, r, img, z );
    obj_phi=angle(obj);
    b=avesqrt(abs(obj));
    ii
end

%img_amp=abs(img);
%figure;
%imshow(img_amp);           %另，[]只对灰度图有效；



return;