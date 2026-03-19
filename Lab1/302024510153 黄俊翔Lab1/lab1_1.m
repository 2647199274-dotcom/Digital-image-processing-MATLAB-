image_1_path = 'picture/cat.jpg';
img1 = imread(image_1_path);
imshow(img1);

%Í¼ÏñĞÅÏ¢
image1_info = imfinfo(image_1_path);
disp(image1_info);

%Í¼ÏñÏÔÊ¾
figure('name','¶àÍ¼ÏñÏÔÊ¾');

%RGB²ÊÉ«
subplot(2,2,1);
imshow(img1);
title('RGB');

%»Ò¶ÈÍ¼Ïñ
gray_img = rgb2gray(img1);
subplot(2,2,2);
imshow(gray_img);
title('»Ò¶È');

%ºÚ°×
level = graythresh(gray_img);  
bw_img = im2bw(gray_img, level);    
subplot(2,2,3);
imshow(bw_img);
title('ºÚ°×');

%Ô­Í¼
subplot(2,2,4);
imshow(img1);
title('Ô­Í¼');

%±£´æÍ¼Æ¬
imwrite(gray_img, 'result/cat_gray.jpg');
imwrite(bw_img, 'result/cat_binary.jpg');

imwrite(gray_img, 'result/cat_gray.png');
imwrite(bw_img, 'result/cat_binary.png');



