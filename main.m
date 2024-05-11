clc;
clear;
%% 任务规模
num_tasks = 30;                                             % 任务数目
num_deal = 3;                                               % 处理机个数
execution_time = randi([1, 50], 1, num_tasks);              % 生成任务执行时间
dependency_matrix = randi([0, 1], num_tasks, num_tasks);    % 生成任务依赖关系（假设是一个随机的有向图）
dependency_matrix = triu(dependency_matrix, 1);             % 确保没有循环依赖
G = digraph(dependency_matrix);                             % 创建一个有向图对象
createfiguretask(G);                                        % 绘制图形
%% 参数规模
N = 10;                                                     %种群规模
E = 1;                                                      %精英个数
max_gen = 1000;                                             %最大进化代数
pINCX = 0.8;                                                %内部交叉概率
pmigration = 0.2;                                           %迁移变异概率
dealer = struct('dealers',cell(N,num_deal));                %定义任务序列
individuals = struct('fitness',zeros(N,1),'chrom',dealer);  %定义种群
%% Compute height
height = zeros(1,num_tasks);
top_order = toposort(G);
for i = 1:num_tasks
    pred = predecessors(G, top_order(i));                   %获取当前节点的前驱节点
    if isempty(pred)                                        %如果前驱节点为空，高度为0
        height(top_order(i)) = 0;
    else
        max_height = max(height(pred));                     %获取前驱节点中最高的高度
        height(top_order(i)) = max_height + 1;              %当前节点的高度为前驱节点中最高高度加1
    end
end
%% Separate
height_groups = cell(1,max(height) + 1);
for i = 1:length(height)
    h = height(i);
    height_groups{h + 1} = [height_groups{h + 1},i];
end
% 输出分类结果
for i = 1:length(height_groups)
    fprintf('高度 %d 的任务为: %s\n', i-1, num2str(height_groups{i}));
end
%% 初始化种群
for z = 1:N
    for i = 1:length(height_groups)
        task_height = height_groups{i};
        len_task = length(task_height);
        nj = zeros(1,num_deal);
        u = len_task / num_deal;
        while(sum(nj) ~= len_task)
            for j = 1:num_deal
                nj(j) = randi([fix(u / 2),ceil(3 * u / 2)]);
            end
        end
    %对nj开始取随机数
        for j = 1:num_deal
            randomindex = randperm(length(task_height));
            if(isempty(randomindex))break;
            end
            elementstoremove = task_height(randomindex(1:nj(j)));
            individuals.chrom(z,j).dealers = [individuals.chrom(z,j).dealers,elementstoremove];
            task_height(randomindex(1:nj(j))) = [];
        end
    end
end
%% 计算适应度
individuals.fitness = fitness(individuals,execution_time,dependency_matrix);
%% 记录值
[best_fitness,best_index] = max(individuals.fitness);
avg_fitness = [mean(individuals.fitness)];
[start_time,end_time,jobId] = compute_gantt(individuals.chrom(best_index,:),execution_time,dependency_matrix);
GTC1 = ganttChart(start_time,execution_time,jobId);
%% GA
gen = 0;
while gen<max_gen
    [parents,index] = sort(individuals.fitness(:),'descend');
    Elites = individuals.chrom(index(1:E),:);
    Children = [];
    while length(Children) < N-E
        %选择
        parents = Select(individuals,N);
        %改进交叉IMCX与内部交叉INCX
        [c1,c2] = Cross(parents,height,pINCX);
        Children = [Children;c1];
        if length(Children) < N - E
            Children = [Children;c2];
        end
    end
    %迁移变异
    Children = Mutation(Children,height,pmigration);

    %将子代并入,更新适应度
    individuals.chrom(1:N-E,:) = Children(1:N-E,:);
    individuals.chrom(N-E+1:N,:) = Elites(1:E,:);
    individuals.fitness = fitness(individuals,execution_time,dependency_matrix);
    best_fitness = [best_fitness,max(individuals.fitness)];
    avg_fitness = [avg_fitness,mean(individuals.fitness)];
    gen = gen + 1; 
end
%% 绘制结果
best_time = sum(execution_time) - best_fitness;
avg_time = sum(execution_time) - avg_fitness;
createfigureplot1([best_fitness;avg_fitness]');
createfigureplot2([best_time;avg_time]');
[best_fitness,best_index] = max(individuals.fitness);
[start_time,end_time,jobId] = compute_gantt(individuals.chrom(best_index,:),execution_time,dependency_matrix);
GTC2 = ganttChart(start_time,execution_time,jobId);