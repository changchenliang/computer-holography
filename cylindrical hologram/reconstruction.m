% reconstruction
clear theta1; 
clear h1; 
clear theta2;
clear h2; 
[mm,nn]=size(obj);
theta=linspace(-pi,pi,nn);
h=linspace(-0.005,0.005,mm);
[theta1,h1]=meshgrid(theta,h);
[theta2,h2]=meshgrid(theta,h);
%dtheta=2*pi/(nn-1);

% for ii=1:mm
%     for jj=1:nn
%         theta1(ii,jj)=dtheta*(jj-nn/2);
%     end
% end
% 
% for ii=1:mm
%     for jj=1:nn
%         h1(ii,jj)=dh*(ii-mm/2-0.5);
%     end
% end
% 
% %m=128;
% %n=40;
% for ii=1:mm
%     for jj=1:nn
%         theta2(ii,jj)=dtheta*(jj-nn/2);
%     end
% end
% 
% for ii=1:mm
%     for jj=1:nn
%         h2(ii,jj)=dh*(ii-mm/2-0.5);
%     end
% end

[img]=dir_int((obj),lamda,R,r,theta1,h1,theta2,h2);
img=img/max(max(abs(img)));
figure; imshow(abs(img));