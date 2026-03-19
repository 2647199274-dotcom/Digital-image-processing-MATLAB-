clc;
clear;

img = imread('picture/Dragon.png');
figure;
subplot(2,3,1);
imshow(img);
title('原图')

[h,w,c] = size(img);

%% 平移
tx = 52;
ty = 34;       %移动距离
img_1 = uint8(zeros(h,w,c));  %创建新图像
for y=1:h
    for x=1:w
        newx = x + tx;
        newy = y + ty;
        if newx>=1 && newx<=w && newy>=1 && newy<=h
            img_1(newy,newx,:) = img(y,x,:);          %防止数组越界
        end
    end
end
subplot(2,3,2);
imshow(img_1)
imwrite(img_1,'result\my_translate.png')

%% 垂直镜像
img_2 = uint8(zeros(h,w,c));

for y=1:h
    for x=1:w
        newy = h - y + 1;           %x坐标不变，y坐标取垂直镜像坐标
        img_2(newy,x,:) = img(y,x,:);
    end
end
subplot(2,3,3);
imshow(img_2)
imwrite(img_2,'result\my_flipud.png')


%% 水平镜像
img_3 = uint8(zeros(h,w,c));

for y=1:h
    for x=1:w
        newx = w - x + 1;
        img_3(y,newx,:) = img(y,x,:);
    end
end
subplot(2,3,4);
imshow(img_3)
imwrite(img_3,'result\my_fliplr.png')


%% 缩放
sx = 0.5;
sy = 0.5;   %缩小0.5倍
newh = round(h*sy);
neww = round(w*sx);    %目标图像的宽和高
img_4 = uint8(zeros(newh,neww,c));

for y=1:newh
    for x=1:neww
        srcx = round(x/sx);
        srcy = round(y/sy);                 %逆向映射,x = x'/sx  y = y'/sy
        if srcx>=1 && srcx<=w && srcy>=1 && srcy<=h
            img_4(y,x,:) = img(srcy,srcx,:);
        end
    end
end
subplot(2,3,5);
imshow(img_4)
imwrite(img_4,'result\my_resize.png')


%% 旋转
angle = 45;                 %目标角度并转化为弧度制
theta = angle*pi/180;
img_5 = uint8(zeros(h,w,c));

cx = w/2;
cy = h/2;

for y=1:h
    for x=1:w
        xt = x - cx;
        yt = y - cy;
        
        srcx = xt*cos(theta) + yt*sin(theta);
        srcy = -xt*sin(theta) + yt*cos(theta);
        
        srcx = round(srcx + cx);
        srcy = round(srcy + cy);
        
        if srcx>=1 && srcx<=w && srcy>=1 && srcy<=h
            img_5(y,x,:) = img(srcy,srcx,:);
        end
    end
end

subplot(2,3,6);
imshow(img_5)
imwrite(img_5,'result\my_rotate.png')