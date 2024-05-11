function Children = Mutation(Children,height,pm)
%MULATION 此处显示有关此函数的摘要
%   此处显示详细说明
[n,m] = size(Children);
for i = 1:n
    pick = rand;
    while pick == 0
        pick = rand;
    end
    if pick > pm
        continue;
    end
    %开始变异
    nx = randi(max(height) + 1) - 1;
    temp_task = Children(i,:);
    Count = zeros(1,m);
    Height = cell(m,1);
    for j = 1:m
        task_j = temp_task(j).dealers;
        for z = 1:length(task_j)
            Height{j} = [Height{j},height(task_j(z))];
            if height(task_j(z)) == nx
                Count(j) = Count(j) + 1;
            end
        end
    end
    %迁移
    [~,index_max] = max(Count);
    [~,index_min] = min(Count);
    while(index_max == index_min)
        index_min = randi(length(Count));
    end

    Height_max = find(Height{index_max} == nx);
    %选择一个
    Tj_index = Height_max(randi(numel(Height_max)));
    Tj = temp_task(index_max).dealers(Tj_index);
    %从index_max中删掉Tj_index
    Children(i,index_max).dealers(Tj_index) = [];
    %将Tj放入index_min中

    Height_min_1 = find(Height{index_min} < nx);
    Height_min_2 = find(Height{index_min} == nx);
    Height_min = [max(Height_min_1),Height_min_2];
    if(isempty(Height_min)) Tx_index = 0;
    else Tx_index = Height_min(randi(numel(Height_min)));
    end
    %插入
    Children(i,index_min).dealers = [Children(i,index_min).dealers(1:Tx_index),Tj,Children(i,index_min).dealers(1,Tx_index + 1 : end)];
end
end

