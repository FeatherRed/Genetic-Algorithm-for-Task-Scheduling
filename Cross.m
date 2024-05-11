function [c1,c2] = Cross(parents,height,pc)
%CROSS 此处显示有关此函数的摘要
%   此处显示详细说明
c1 = parents(1,:);
c2 = parents(2,:);
[~,m] = size(parents);
pick = rand;
while pick == 0
    pick = rand;
end
%% 1 - pc 改进IMCX
if pick > pc
    n = randi(max(height) + 1) - 1;
    index = zeros(2,m);
    for j = 1:m
        for i = 1:length(parents(1,j).dealers)
            if height(parents(1,j).dealers(i)) <= n
                index(1,j) = i;
            else
                break;
            end
        end
        for i = 1:length(parents(2,j).dealers)
            if height(parents(2,j).dealers(i)) <= n
                index(2,j) = i;
            else
                break;
            end
        end
    end
    tempc1 = c1;
    tempc2 = c2;
    for j = 1:m
        c1(1,j).dealers = [tempc1(1,j).dealers(1,1:index(1,j)),tempc2(1,j).dealers(1,index(2,j) + 1:end)];
        c2(1,j).dealers = [tempc2(1,j).dealers(1,1:index(2,j)),tempc1(1,j).dealers(1,index(1,j) + 1:end)];
    end
% 内部交叉INCX
else
    %处理父1
    n = randi(max(height) + 1) - 1;
    index1 = randperm(m);
    j1 = index1(1);
    j2 = index1(2);
    index = zeros(2,2);
    for i = 1:length(parents(1,j1).dealers)
        if height(parents(1,j1).dealers(i)) <= n
            index(1,1) = i;
        else
            break;
        end
    end
    for i = 1:length(parents(1,j2).dealers)
        if height(parents(1,j2).dealers(i)) <= n
            index(1,2) = i;
        else
            break;
        end
    end
    tempc1 = c1;
    tempc2 = c2;
    c1(1,j1).dealers = [tempc1(1,j1).dealers(1,1:index(1,1)),tempc1(1,j2).dealers(1,index(1,2) + 1:end)];
    c1(1,j2).dealers = [tempc1(1,j2).dealers(1,1:index(1,2)),tempc1(1,j1).dealers(1,index(1,1) + 1:end)];
    %处理父2
    n = randi(max(height) + 1) - 1;
    index1 = randperm(m);
    j1 = index1(1);
    j2 = index1(2);
    for i = 1:length(parents(2,j1).dealers)
        if height(parents(2,j1).dealers(i)) <= n
            index(2,1) = i;
        else
            break;
        end
    end
    for i = 1:length(parents(2,j2).dealers)
        if height(parents(2,j2).dealers(i)) <= n
            index(2,2) = i;
        else
            break;
        end
    end
    c2(1,j1).dealers = [tempc2(1,j1).dealers(1,1:index(2,1)),tempc2(1,j2).dealers(1,index(2,2) + 1:end)];
    c2(1,j2).dealers = [tempc2(1,j2).dealers(1,1:index(2,2)),tempc2(1,j1).dealers(1,index(2,1) + 1:end)];
end
end