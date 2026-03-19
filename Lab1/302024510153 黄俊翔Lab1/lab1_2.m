clc; 
clear; 

%读取带调色盘图片
img_path = 'picture/lab1_2.gif';

[img, map] = imread(img_path,'frames','all');
%播放第一帧
imshow(img(:,:,:,1),map);
%查看信息
info = imfinfo(img_path);
numFrames = size(img,4);
disp(info);
disp(numFrames);

%多图显示
figure;

%原始图像
subplot(2,2,1);
imshow(img_path);
title('原始图像');

%灰度图
gray = ind2gray(img, map);
subplot(2,2,2);
imshow(gray);
title('灰度图像');

%黑白图
level = graythresh(gray); 
bw = im2bw(gray, level);  
subplot(2,2,3);
imshow(bw);
title('黑白图像');

%索引图
[new_ing, new_map] = gray2ind(gray, 16);
subplot(2,2,4);
imshow(new_ing, new_map);
title('索引图像');

%保存处理结果
imwrite(gray, 'picture/lab1_2_gray.jpg');
imwrite(bw, 'picture/lab1_2_binary.jpg');
imwrite(gray, 'picture/lab1_2_gray.png');
imwrite(bw, 'picture/lab1_2_binary.png');
imwrite(img, map, 'picture/lab1_2_copy.gif');  
