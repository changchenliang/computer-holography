% video_making

clc;
 N=50;
% for r=0.3:-(0.3-0.15)/N:0.15;
% [du,img]=cylindrical_helical_spectrum(dh,lamda,obj2,R,r);
% nameout=['pic\NUFFT\parrots\r=' num2str(r) '.jpg'];
% imwrite(1.3*mat2gray(abs(img)),nameout);
% %figure(1)
% %imshow(uint8(abs(fliplr(obj))));
% title(['r = ',num2str(r)]);
% pause(0.001);
% end

aviobj = avifile('pic\NUFFT\test1.avi');
aviobj.Quality = 100;
aviobj.Fps = 5;
aviobj.compression='none';
for r=0.3:-(0.3-0.15)/N:0.15
       namein=['pic\NUFFT\abcde\r=' num2str(r) '.jpg'];
       adata=imread(namein);
             adata=cat(3,adata,adata,adata);
    aviobj = addframe(aviobj,adata);
end
aviobj=close(aviobj); 