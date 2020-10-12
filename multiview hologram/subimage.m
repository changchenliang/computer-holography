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
        temp=['pic/sub_img/' num2str(round(4-1/m*j)) '_' num2str(4+round(1/m*(i-z))) '.bmp'];
        imwrite(subi,temp);
    end
end
%}
