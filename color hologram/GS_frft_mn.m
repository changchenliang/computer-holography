function [obj_phi] = GS_frft_mn(img0,obj_phi,a,r,f1);     %用来计算图像的长宽不相等时的全息图
%普通GS算法。
%obj表示物面复振幅，img表示像面复振幅。LCoS端为物面，投影面为像面。
%dx、dfx为采样率，dx为LCoS端，15um。
%obj_phi为LCoS端相位，为便于相邻帧的传递故不采用原来函数中产生随机相位的算法，而是作为形参从调用函数中传递过来

%img0=enlarge_2_512(img0);
img_amp0 = double(img0)+0.00000001; %读取图像
%img_amp0 = fftshift(img_amp0);
%img_amp0 = fliplr(img_amp0);
%img_amp0 = flipud(img_amp0);
[mm,nn] = size(img_amp0);                %取分辨率

%obj_phi = rand(nn,mm)*2*pi;   %%产生LCoS端随机相位。//这行代码已经不需要，由调用函数中传递过来

%r=5.32e-7;                                %波长532nm，绿色激光
%f1=0.5;
dx=8e-6;
dy=dx;
fe=f1*sin(a*pi/2);
z=f1*sin(a*pi/2)*tan(a*pi/4)

b=1;
p=0;
t=[];
k=[];
for ii = 0:16                %迭代次数
    obj=b.*exp(i.*obj_phi);                   %由均匀光和obj_phi组成LCoS端复振幅。因均匀光是全1矩阵，故这里省略。
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
    img = img_amp0.*exp(i.*img_phi);       %由目标图像和img_phi组成LCoS端复振幅。
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
plot(k,t,'r-');                           %做出迭代前后的误差随着迭代次数变化的图像
%axis([0 16 10 40]);
phi=255-uint8((obj_phi+pi)*255/(2*pi));
imwrite(phi,'pic\lena19201080.bmp');          %输出相位图

res=abs(zout-img0);
zout=uint8(zout);
imwrite(zout,'pic\lena19201080_rec.jpg');          %输出复原后的图像

%imshow(res);                               %做出残差图
return;