%2012 12 18 by lichao
%�����ؾ۽�
%2012 12 19 �޸�
%2012 12 20 �޸�


addpath(genpath('C:\Users\Сľ��\Desktop\�ⳡ�������\image'));
addpath(genpath('C:\Users\Сľ��\Desktop\�ⳡ�������\image2'));
addpath(genpath('C:\Users\Сľ��\Desktop\�ⳡ�������\data'));
addpath(genpath('C:\Users\Сľ��\Desktop\�ⳡ�������\dataRGB'));
addpath(genpath('C:\Users\Сľ��\Desktop\�ⳡ�������\refocuse_sub'));

clear all

%% ������Ϣ
F=16;%��͸������
%%%%%%%%%%----------�ɵ�����---------------%%%%%%%%%%
v=15;  %Ĭ��16
d=250;%������λ�ã�����load
d_re=260;%�ؾ۽�λ��
N_line=81;%Ĭ��81������load

par_menu=menu('ȷ�����������Ƿ���ȷ��',['΢͸�����룺v=',num2str(v)],['�������룺d=',num2str(d)],...
    ['�ؾ۽�λ�ã�d_re=',num2str(d_re)],['��͸�������ʣ�N_line=',num2str(N_line)],'��','��');

if par_menu<=5
    clearall
    disp('�����µ���������');
    break;
end

v_re=F*d_re/(d_re-F);    %����۽�λ��
alpha=v_re/v;        %Ҳ����ֱ�ӵ��ڲ���alpha

disp(['�ɵ�������΢͸��λ�ã�:v=',num2str(v)]);
disp(['�ɵ���������͸�������ʣ�:N_line=',num2str(N_line)]);
disp(['�ɵ�����������λ�ã�:d=',num2str(d)]);
disp(['�ɵ��������۽�λ�ã�:d_re=',num2str(d_re)]);
%%%%%%%%%%----------�ɵ�����---------------%%%%%%%%%%

D=4;%��͸��ֱ��
lens_d=0.02;
sen_N=20;%ÿ��΢͸���󴫸�������
sen_d=lens_d/sen_N;
micr_N=fix(D/lens_d);%΢͸������
sen_N_total=fix(D/sen_d);%�������ܸ���
KK_num=3;            %RGBͼ����������


%% ����ÿ��΢͸����Ӧ��У���Ĵ���������
sen_coor=sen_adjust(D,micr_N,F,v,sen_N);

%% ��RGBͼ�������ؾ۽�
fprintf('\n��һ����\n');
tic
im_re=refocuse_im(D,alpha,d,v,N_line,micr_N,sen_N);
t=toc;
fprintf(['\n�����ؾ۽�ʱ��Ϊ:t=',num2str(t),'s\n']);

im_re=im_re/max(max(max(im_re)));%��һ��
%% ��ͼ������ع���΢͸�����
im_rec=im_recon3(D,d,v,N_line,lens_d); %����im_recon3�Թⳡԭʼ��������ع�
im_rec=im_rec/max(max(max(im_rec)));%��һ��

figure
subplot(1,2,1),imshow(im_rec,[]);
title('�ؾ۽�ǰ����ͷ��ؽ���ͼ��');
subplot(1,2,2),imshow(im_re,[]);
title('�ؾ۽�����ͷ��ؽ���ͼ��');

fprintf('\n���ع���ɣ�\n');

%% ȥ��ͼ������Ч�ĺ�ɫ��Ե
fprintf('\n�ڶ�����\n');

fprintf('\n����ȥ���ؾ۽�ͼ�����Ч��Ե��\n')
im_full=sub_revise3_im(im_rec);
fprintf('\n����ȥ��ԭʼͼ�����Ч��Ե��\n')
im_re_full=sub_revise3_im(im_re);

figure
subplot(1,2,1),imshow(im_full,[]);title('�ؾ۽�ǰ������0��0�е�ͼ��');
subplot(1,2,2),imshow(im_re_full,[]);title('�ؾ۽�������0��0�е�ͼ��');

fprintf('\n��ȥ����Ч��Ե��\n');
%% ͼ��ת����������ɷ�������
fprintf('\n��������\n');

fprintf('\n���ڶԾ۽�ǰ�ع�ͼ����з�ת��\n')
im_full_final=sub_reversal3_im(im_full);
fprintf('\n���ڶԾ۽����ع�ͼ����з�ת��\n')
im_re_full_final=sub_reversal3_im(im_re_full);

figure
subplot(1,2,1),imshow(im_full_final,[]);title('�ؾ۽�ǰ������ͼ��');
subplot(1,2,2),imshow(im_re_full_final,[]);title('�ؾ۽�������ͼ��');

fprintf('\nͼ��������!\n');


%% ����������ͼ��
figure

im_RGB=imread(sprintf('./dataRGB/im_d_%d_v_%d_Nline_%d_RGB.jpg',d,v,N_line));
warning off all  %�򴫸���ͼ�����imshow�����warning���˴���warning�ص�
imwrite(im_RGB,'data\1.bmp');
imshow(im_RGB,[]);title('������ͼ��im');
warning on all


clear im_RGB
fprintf('\n�ѻ���������ͼ��\n');
%% ����               
fprintf('\nThe end!\n');    