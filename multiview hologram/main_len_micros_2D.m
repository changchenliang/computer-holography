%2012 11 26 by lichao
%2012 12 1 �޸�
%2012 12 13 �޸ģ�������΢͸���󴫸����ĵ���
%2012 12 19�޸�
%2012 12 22�޸� �����˴�������ͼ�����������
%2ά��
%͸��+΢͸������

%���ʣ�΢͸���Ƿ���Ͻ����ѧ ���ϣ���F��lens_d,�Ȳ����ɼ�������

%��͸��d�����壬��͸����v���ɵ���
%����������ѧ����������͸���ľ���Զ���ڽ���

%�ɷֱ���v=16,17,0,17.093,15.84

addpath(genpath('.\image'));
addpath(genpath('.\image2'));
addpath(genpath('.\data'));
addpath(genpath('.\dataRGB'));
addpath(genpath('.\len_sub'));

clearall

%%%%%%%%%%%%%%%%%%---------������Ϣ--------------%%%%%%%%%%%%%%%%%%%%%%
[obj,obj1,d,d2,object_num,error]=select_object();
if error==1
    clearall
    break;
elseif object_num==1
    clear obj1
end

%%%%%%%%%%%%%%%%%%---------���������Ϣ----------------%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%----------�ɵ�����---------------%%%%%%%%%%
v=16.9;%���  Ĭ��16
N_line=21;%����͸������ɢ����ÿ��������͸���ж��ٹ���  Ĭ��81
d_m=18;%������͸���Ķ��ٱ�

error=ensure_par(v,N_line,d_m,object_num,d,d2);
if error==1
    clearall
    disp('�����µ���������');
    break;
end

%%%%%%%%%%----------�̶�����---------------%%%%%%%%%%
D=4;%ֱ��
F=16;%����  f-num=4
lens_d=0.04;%΢͸��ֱ��
sen_N=20;%ÿ��΢͸���󴫸�������

lens_f=lens_d*F/D;%΢͸������
lens_v=lens_f;  %������λ��
micr_N=ceil(D/lens_d);%΢͸������
sen_N_total=micr_N*sen_N;%�������ܸ���
sen_d=lens_d/sen_N;%������ֱ��

if mod(sen_N_total,2)==0
    sen_N_total=sen_N_total+1;
end

im_max=zeros(3,1);%�ֱ𱣴�R��G��B�����ֵ���Ա�ת��Ϊuint8�ͣ��Խ�ʡ�ڴ�

%%%%%%%%%%%%%%%%%%----------���������̲���------------%%%%%%%%%%%%%%%%%%%%%
tic
for k=1:3
    if object_num==1
        fprintf_RGB(k);%�ַ�����ӡ
        obje=obj(:,:,k);
        im=LF_sim(obje,d,d_m,D,N_line,F,v,lens_d,lens_f,sen_N);
        im_max(k)=max(max(max(max(im))));
    elseif object_num==2
        fprintf_RGB(k); %�ַ�����ӡ
        obje=obj(:,:,k);
        im=LF_sim(obje,d,d_m,D,N_line,F,v,lens_d,lens_f,sen_N);
        obje=obj1(:,:,k);
        im=im+LF_sim(obje,d2,d_m,D,N_line,F,v,lens_d,lens_f,sen_N);
        im_max(k)=max(max(max(max(im))));
    end
    
    save (sprintf('./dataRGB/im_d_%d_v_%d_Nline_%d_%d.mat',d,v,N_line,k),'im');
    
end
t=toc;
fprintf(['\nģ��ⳡ����ʱ��Ϊ��t=',num2str(t),'s\n']);

%%  ����ԭʼͼ��
figure
if object_num==1
    imshow(uint8(obj),[]);title('obj��������')
elseif object_num==2
    subplot(1,2,1),imshow(uint8(obj),[]);title('obj������һ������');
    subplot(1,2,2),imshow(uint8(obj1),[]);title('obj1�����ڶ�������');
end
fprintf('\n�ѻ�������ͼ��\n');

%%  ��������������
clear im
%im_RGB=zeros(micr_N*sen_N,micr_N*sen_N,3);
%im_RGB=uint8(im_RGB);
im_RGB=reshape4to2_im(d,v,N_line,micr_N,sen_N,im_max);

figure
warning off all
imshow(im_RGB,[]);title('������ͼ��im');
imwrite(im_RGB,'data\1.jpg');%��΢͸��ͼ�񱣴�Ϊim_RGB.jpg
warning on all

imwrite(im_RGB,sprintf('./dataRGB/im_d_%d_v_%d_Nline_%d_RGB.jpg',d,v,N_line));%��΢͸��ͼ�񱣴�Ϊim_RGB.jpg

fprintf('\n�ѻ���������ͼ��\n');

%% ԭʼ��������ع����ͼ��
im_micr=sum_4D_im(d,v,N_line,micr_N);
max_im_micr=max(max(max(im_micr)));
im_micr=uint8(im_micr/max_im_micr*255);
figure
imshow(im_micr,[]);title('ԭʼ��������ع���');
imwrite(im_micr,'data\2.jpg');%��΢͸��ͼ�񱣴�Ϊim_RGB.jpg
fprintf('\n�ѻ���ԭʼ�����ع�ͼ��!\n');
disp('The end!');