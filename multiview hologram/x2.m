%对三D前置处理及图片的获取
wh = vrworld('ff1.wrl');
open(wh);
r=0;
z=0;
mynode = vrnode(wh, 'k');
mynode1 = vrnode(wh, 'M');
mynode2 = vrnode(wh, 'Q');
%mynode3 =vrnode(wh,'R');
%mynode4=vrnode(wh,'G');

setfield(mynode,'position',[0  0  3]);
setfield(mynode,'orientation',[1 0 0 0]);
setfield(mynode2,'rotation',[0 1 0 -1.57/3]);
setfield(mynode1,'translation',[0 0.5 -2.5]);
setfield(mynode1,'scale',[1.5 1.5 1.5]);
setfield(mynode2,'translation',[0 0 0]);
setfield(mynode2,'translation',[0 0 r]);
%setfield(mynode4,'translation',[-0.31  0  2.5]);
h=2+r;
m=0.01;

k=vrfigure(wh);
for i=3*m+z:-m:-3*m+z
    for j=3*m:-m:-3*m
        setfield(mynode,'position',[i  j  (h^2-z^2)^0.5])
        x=atan(((i)^2+(j)^2)^0.5/h);
        %
        if((i>0&&j>0)||(i<0&&j<0))
        setfield(mynode,'orientation',[1/i -1/j 0 -x]);
        elseif(j==0&&i>0)
            setfield(mynode,'orientation',[0 1 0 x]);
        elseif(j==0&&i<0)
            setfield(mynode,'orientation',[0 1 0 -x]);
        elseif(i==0&&j<0)
            setfield(mynode,'orientation',[1 0 0 x]);
        elseif(i==0&&j>0)
            setfield(mynode,'orientation',[1 0 0 -x]);
        elseif(i==0&&j==0)
            setfield(mynode,'orientation',[1 0 0 0]);
        else
            setfield(mynode,'orientation',[1/i -1/j 0 x]);
        end
        %}
        subi=capture(k); 
        temp=['fff/' num2str(round(4-1/m*j)) '_' num2str(4+round(1/m*(i-z))) '.bmp'];
        imwrite(subi,temp);
    end
end
%}
vrclose
clear all
M=146;
N=274;
%调整图片大小，服务像素分配
for i=1:6
    for j=1:6
    temp=['fff/' num2str(i) '_' num2str(j) '.bmp'];
    temp1=['fff1/' num2str(i) '_' num2str(j) '.bmp'];
    su=imread(temp);
    A=su(190-M+1:190+M,:,:);
    A=imresize(A,[M*2,round(576*6/5)]);
    %A=imresize(A,[283,333]);
    A=A(:,round(576*7/12)-N+1:round(576*7/12)+N,:);
    imwrite(A,temp1);
    
    end
end
clear all
%象素分配
Ma=146;
Na=274;
for i=1:7
    for j=1:6
        temp2=['fff1/' num2str(i) '_' num2str(j) '.bmp'];
        A{1,i}{1,j}=imread(temp2);
    end
end

for m=1:Ma
    for n=1:Na
        N=zeros(6,5,3);
         for x=1:6
             for y=1:5
                 if(mod(n,2)==1)
                     N(x,y,:)=A{1,x}{1,y}(2*m-1,2*n-1,:);
               
                 else
                     N(x,y,:)=A{1,x}{1,y}(2*m,2*n-1,:);
                 end
             end
         end
         
 %{    
    %取圆
         B=zeros(11,11,3);
for p=1:11
    for q=1:11
        if((p-6)^2+(q-6)^2<30.26)
            B(p,q,:)=N(p,q,:);
        end
    end
end

%}
         temp3=['ff2/' num2str(m) '_' num2str(n) '.bmp'];
          N=uint8(N);
       
         imwrite(N,temp3)
    end
end
clear all

%子图合成
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
M=146;
N=274;

col=zeros(6*M+3,5*N,3);

for i=1:M
    for j=1:N
        temp=['ff2/' num2str(i) '_' num2str(j) '.bmp'];
        pic=double(imread(temp));
        pic=imrotate(pic,180);
       
        %B{i}{j}=pic;
        if(mod(j,2)==1)
            col(6*i-5:6*i,5*j-4:5*j,:)=pic;
        else
           col(6*i-5+3:6*i+3,5*j-4:5*j,:)=pic;
        
    end
end
end  
col=col(1:6*M,:,:);
col=uint8(col);
imwrite(col,'ben0.01_6.bmp')