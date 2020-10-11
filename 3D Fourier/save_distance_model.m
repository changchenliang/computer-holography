%±£´æ¾àÀëÄ£ÐÍ
for ii=1:mm/2
    for jj=1:nn/2
        z(ii,jj)=0.2;
    end
end
for ii=1:mm/2
    for jj=nn/2+1:nn
        z(ii,jj)=0.3;
    end
end
for ii=mm/2+1:mm
    for jj=1:nn/2
        z(ii,jj)=0.5;
    end
end
for ii=mm/2+1:mm
    for jj=nn/2+1:nn
        z(ii,jj)=0.8;
    end
end