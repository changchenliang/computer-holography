function output=turn_over(input);
[mm,nn]=size(input);
for ii=1:mm
    for jj=1:nn
        if input(ii,jj)>0
            output(ii,jj)=0;
        else
            output(ii,jj)=255;
        end
    end
end
