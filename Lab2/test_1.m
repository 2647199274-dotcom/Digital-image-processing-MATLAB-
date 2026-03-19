clc;
clear;

figure;

img = imread('picture/Dragon.png');
subplot(2,3,1);
imshow(img);
title('原图');

%平移
img_1 = imtranslate(img,[52 34]);
subplot(2,3,2);
imshow(img_1);
title('平移');
imwrite(img_1,'result\translate.png')

%垂直镜像
img_2 = flipud(img);
subplot(2,3,3);
imshow(img_2);
title('垂直镜像')
imwrite(img_2,'result\flipud.png')

%水平镜像
img_3 = fliplr(img);
subplot(2,3,4);
imshow(img_3);
title('水平镜像');
imwrite(img_3,'result\fliplr.png');

%缩放
img_4 = imresize(img,0.5);
subplot(2,3,5);
imshow(img_4);
title('缩小');
imwrite(img_4,'result\resize.png');

%旋转
img_5 = imrotate(img,45);
subplot(2,3,6);
imshow(img_5);
title('旋转45°');
imwrite(img_5,'result\rotate.png');
