clc; clear; close all;

I = imread('mygirl.png');
I = rgb2gray(I);

I = im2double(I); % 转 double, 范围 [0,1]

figure;
subplot(2,2,1);
imshow(I); title('原始图像');

% 对数增强 -->变暗
C = 5; % 对数变换常数
logImage = C * log(1 + I);
logImage = mat2gray(logImage); % 归一化到 [0,1]

subplot(2,2,2);
imshow(logImage);
title('对数增强');

% 指数增强
b = 1.5; % 底数
c = 1.5; % 指数系数
expImage = b.^(I.^c) - 1;
expImage = mat2gray(expImage);

subplot(2,2,3);
imshow(expImage);
title('指数增强');

% 直方图均衡化
histeqImage = histeq(I);

subplot(2,2,4);
imshow(histeqImage);
title('直方图均衡化');

% 显示图像
figure;
subplot(2,2,1); imhist(I); title('原始');
subplot(2,2,2); imhist(logImage); title('对数增强');
subplot(2,2,3); imhist(expImage); title('指数增强');
subplot(2,2,4); imhist(histeqImage); title('直方图均衡化');

% 输出对数增强和指数增强的曲线图
r = linspace(0,1,256); % 输入灰度 0~1

s_orig = r;                 % 原图灰度曲线（线性映射）

s_log = C * log(1 + r);
s_log = s_log / max(s_log); % 对数变换映射曲线

s_exp = b.^(r.^c) - 1;
s_exp = s_exp / max(s_exp); % 指数变换映射曲线


[histeqImage, T] = histeq(I, 256);
s_hist = T / max(T);% 直方图均衡化映射曲线

figure;
plot(r, s_orig, 'k--', 'LineWidth', 2); hold on; % 原图黑色虚线
plot(r, s_log, 'b-', 'LineWidth', 2); 
plot(r, s_exp, 'r-', 'LineWidth', 2);
plot(r, s_hist, 'g-', 'LineWidth', 2);
xlabel('输入灰度 r'); ylabel('输出灰度 s');
title('灰度映射曲线');
legend('原图','对数增强','指数增强','直方图均衡化');
grid on