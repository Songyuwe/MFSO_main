function w=Brown(dim)
% 设置参数
T = 1; % 时间长度
N = dim; % 时间步数
dt = T/N; % 时间步长

% 生成随机数
M = 100; % K-L展开项数
xi = randn(M, N); % 随机数，每列代表一个展开项的随机数序列

% 计算布朗运动轨迹
t = linspace(0, T, N+1); % 时间网格
W = zeros(1, N+1); % 布朗运动轨迹
for i = 1:N
    sum_term = 0;
    for j = 1:M
        sum_term = sum_term + (2*sqrt(2)/((2*j-1)*pi))*sin(((j-0.5)*pi*t(i+1)));
    end
    W(i+1) = W(i) + sqrt(dt)*sum_term*xi(j, i);
end
w=W(2:end);
% % 绘制布朗运动轨迹
% plot(t, W,'g')
% xlabel('时间')
% ylabel('布朗运动轨迹')
% title('布朗运动模拟演示')
end
