I = imread('mygirl.png');
if size(I,3) == 3
    I = rgb2gray(I);
end
[M,N] = size(I);
I_uint8 = uint8(I); % 0~255

L = 256;

% 统计直方图
histogram = zeros(L,1);
for i = 1:M
    for j = 1:N
        histogram(I_uint8(i,j)+1) = histogram(I_uint8(i,j)+1) + 1;
    end
end

% 归一化概率
prob = histogram / (M*N);

% 累计分布函数
cdf = cumsum(prob);

% 插值映射
x = 0:L-1;           % 输入灰度
y = cdf * (L-1);     % 输出灰度
histeq_sparse = interp1(x, y, double(I_uint8), 'linear'); 
histeq_sparse = round(histeq_sparse);
histeq_sparse = uint8(histeq_sparse);

% 显示
figure;
imshow(histeq_sparse); title('自定义均衡化');

figure;
imhist(histeq_sparse); title('直方图');