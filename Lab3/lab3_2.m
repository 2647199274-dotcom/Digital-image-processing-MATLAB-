clc; clear; close all;

%% ----------------- 读取图像 -----------------
I = imread('mygirl.png'); 
I = rgb2gray(I); % 转灰度
I = im2double(I); % 归一化到 [0,1]

figure;
subplot(2,2,1);
imshow(I); title('原始图像');

[M,N] = size(I);

%% ----------------- 对数增强 -----------------
C = 30; 
logImage = zeros(M,N);

for i = 1:M
    for j = 1:N
        logImage(i,j) = C * log(1 + I(i,j));
    end
end
logImage = logImage / max(logImage(:)); % 归一化到 [0,1]
subplot(2,2,2);
imshow(logImage); title('对数增强');

%% ----------------- 指数增强 -----------------
b = 2; c = 1.5;

expImage = zeros(M,N);
for i = 1:M
    for j = 1:N
        expImage(i,j) = b^(I(i,j)^c) - 1;
    end
end
expImage = expImage / max(expImage(:)); % 归一化 [0,1]
subplot(2,2,3);
imshow(expImage); title('指数增强');

%% ----------------- 直方图均衡化 -----------------
L = 256;
[M,N] = size(I);
I_uint8 = uint8(I * (L-1)); % 转 0~255 灰度
%I_uint8 = uint8(I);

% 先统计每个灰度值像素的出现次数
histogram = zeros(L,1);
for i = 1:M
    for j = 1:N
        gray = I_uint8(i,j);
        histogram(gray+1) = histogram(gray+1) + 1;
    end
end

% 归一化概率 p(rk​)=nk​/(M∗N)
prob = zeros(L,1); 
for k = 1:L
    prob(k) = histogram(k) / (M * N);
end

% 累计分布函数 CDF(rk​)=∑​p(ri​) 计算累计概率
cdf = zeros(L,1);
cdf(1) = prob(1);
for k = 2:L
    cdf(k) = cdf(k-1) + prob(k);
end

% 灰度映射
histeq = zeros(M,N); 
for i = 1:M 
    for j = 1:N 
        gray = I_uint8(i,j); 
        histeq(i,j) = round(cdf(gray+1) * (L-1)); 
    end 
end

% 灰度映射 插值映射
% x = 0:L-1;           % 输入灰度
% y = cdf * (L-1);     % 输出灰度

% 使用映射值索引
% histeq = interp1(x, y, double(I_uint8), 'linear'); 
% histeq= round(histeq);
% histeq = uint8(histeq);

subplot(2,2,4);
imshow(uint8(histeq)); title('直方图均衡化');

%% ----------------- 输出直方图 -----------------
figure;
subplot(3,2,1); imhist(I); title('原始');
subplot(3,2,2); imhist(uint8(logImage*255)); title('对数增强');
subplot(3,2,3); imhist(uint8(expImage*255)); title('指数增强');
subplot(3,2,4); imhist(uint8(histeq)); title('直方图均衡化');

%% 输出对数增强和指数增强的曲线图
r = linspace(0,1,256); % 输入灰度 0~1

s_orig = r;                 % 原图灰度曲线（线性映射）

s_log = C * log(1 + r);
s_log = s_log / max(s_log); % 对数变换映射曲线

s_exp = b.^(r.^c) - 1;
s_exp = s_exp / max(s_exp); % 指数变换映射曲线

cdf_curve = cdf;              % 累积分布函数
s_hist = cdf_curve;           % 范围 [0,1] 归一化
s_hist = s_hist / max(s_hist);% 直方图均衡化映射曲线

figure;
plot(r, s_orig, 'k--', 'LineWidth', 2); hold on; % 原图黑色虚线
plot(r, s_log, 'b-', 'LineWidth', 2); 
plot(r, s_exp, 'r-', 'LineWidth', 2);
plot(linspace(0,1,L), s_hist, 'g-', 'LineWidth', 2);
xlabel('输入灰度 r'); ylabel('输出灰度 s');
title('灰度映射曲线');
legend('原图','对数增强','指数增强','直方图均衡化');
grid on;