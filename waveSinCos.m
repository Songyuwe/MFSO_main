function W = waveSinCos(n)
    % 定义x的范围，两个周期内，例如从0到4π
    x = linspace(0, 4*pi, 1000); % 生成1000个点以获得足够的数据

    % 计算sin(x)和cos(x)的值
    y_sin = sin(x);
    y_cos = cos(x);

    % 确保n不超过x的长度
    if n > length(x)
        error('n cannot be greater than the number of data points in x.');
    end

    % 生成随机索引
    random_indices = randperm(length(x), n);

    % 初始化结果向量
    points_vector = zeros(n, 2);

    % 对于每个随机索引，从sin(x)和cos(x)中随机选择一个值
    for i = 1:n
        if rand <= 0.5
            points_vector(i, 1) = x(random_indices(i));
            points_vector(i, 2) = y_sin(random_indices(i));
        else
            points_vector(i, 1) = x(random_indices(i));
            points_vector(i, 2) = y_cos(random_indices(i));
        end
    end
    points_vector=points_vector';
    W=points_vector(2,:);
end