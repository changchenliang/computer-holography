function [CCD]= CCDGET(mm,nn,theta,A,circle,obj)
%%%%%%%%%%% k��ͼƬ��� mm,nn��ͼƬ�Ĵ�С,AB�ǹ�����������ϵ����abcd��ƽ�沨ϵ��%%%%%
    phi_r = zeros(mm,nn);             
%     if  theta>0 && theta<=pi
%                 flag1=-1;
%             else
%                 flag1=1;
%     end
%     if theta==pi/2 || theta==-pi/2
%         flag2=0;
%     else
%         flag2=1;
%     end
for ii = 1:mm
        for jj=1:nn

            phi_r(ii,jj)=(sin(theta)*ii-cos(theta)*jj)*A*2*pi;%��бƽ�沨
        end
    end
    phi_r=angle(exp(1i.*phi_r));
%     phi_r=255-uint8((phi_r+pi)*255/(2*pi));
%     figure;imshow(phi_r);
    Sample=obj.*exp(1i.*phi_r);
    Sample_fft=fftshift(fft2(fftshift(Sample)));
    Sample_fft=Sample_fft/max(max(abs(Sample_fft)));
%     figure;imshow(abs(Sample_fft));
    %//////////////////Ƶ���˲�*����///////////////////////////////////////
%     y0=B*mm/4;
%     x0=C*nn/4;
%     d=mm/4;
%     ii=1;
%     for y=1:mm
%         for x=1:nn
%             if sqrt((x-x0)^2+(y-y0)^2)<=d
%                 circle(y,x)=256;
%                 F(ii,2*k-1)=x;
%                 F(ii,2*k)=y;
%                 N=ii;
%                 ii=ii+1;
%             else 
%                 circle(y,x)=0;
%             end 
%         end 
%     end
%         figure(1);imshow(circle);
   Sample_fft2=Sample_fft.*circle;
         figure;imshow(Sample_fft2/10);
    CCD=fftshift(fft2(fftshift(Sample_fft2)));
        CCD=CCD/max(max(abs(CCD)));
     %CCD=imnoise(CCD,'gaussian',0.01);
    CCD=abs(CCD);
        %figure;imshow(abs(CCD));
return