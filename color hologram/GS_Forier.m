function [obj_phi] = GS_Forier(img0,obj_phi)
%普通GS算法。
%obj表示物面复振幅，img表示像面复振幅。LCoS端为物面，投影面为像面。
%dx、dfx为采样率，dx为LCoS端，15um。
%obj_phi为LCoS端相位，为便于相邻帧的传递故不采用原来函数中产生随机相位的算法，而是作为形参从调用函数中传递过来

img_amp0 = double(img0)+0.00000001; %读取图像
%img_amp0 = fliplr(img_amp0);

[nn,mm] = size(img_amp0);                %取分辨率

%obj_phi = rand(nn,mm)*2*pi;   %%产生LCoS端随机相位。//这行代码已经不需要，由调用函数中传递过来

r=5.32e-7;                                %波长532nm，绿色激光
%z=1.5;   %投影距离，单位为m，不能太小。改为入口程序设置距离。
b=1;
t=[];
k=[];
%Er=zeros(65);
for ii = 0:5                       %迭代次数
    obj=b.*exp(1i.*obj_phi);                   %由均匀光和obj_phi组成LCoS端复振幅。因均匀光是全1矩阵，故这里省略。
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
    img = img_amp0.*exp(1i.*img_phi);       %由目标图像和img_phi组成LCoS端复振幅。
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