function Fitness = fitness(individuals,Time,dependency)
%FITNESS 此处显示有关此函数的摘要
%   此处显示详细说明
    [n,m] = size(individuals.chrom);
    p_task = individuals.chrom;
    c = sum(Time);
    for i =1:n
        finish_time = zeros(1,m);
        time_dependency = dependency;
        time_dependency_1 = dependency;
        p = 1;
        Len = 0;
        for j = 1:m
            Len = length(p_task(i,j).dealers) + Len;
        end
        while(Len ~= 0)
           if(isempty(p_task(i,p).dealers))
              if(mod(p,m) == 0)
                    p = 1;
              else
                    p = mod(p,m) + 1;
              end
              continue;
           end
           task_first = p_task(i,p).dealers(1,1);
           %判断是否已经调度完毕
           if(sum(time_dependency(:,task_first)) == 0)
               p_task(i,p).dealers(1) = [];
               finish_time(p) = finish_time(p) + Time(task_first);
               time_dependency(task_first,:) = 0;    %已经处理完，都等于0
           end
           %搜索其他处理机p
           for j = 1:m
               if(j == p)continue;
               end
               j_task = p_task(i,j).dealers;
               for z = 1:length(j_task)
                   task_j = j_task(z);
                   if(time_dependency_1(task_first,task_j) == 1 && finish_time(p) > finish_time(j))
                       finish_time(j) = finish_time(p);
                   end
               end
           end
           if(mod(p,m) == 0)
               p = 1;
           else
               p = mod(p,m) + 1;
           end
           Len = 0;
           for j = 1:m
               Len = length(p_task(i,j).dealers) + Len;
           end
        end
        individuals.fitness(i,1) = c - max(finish_time);
    end
    Fitness = individuals.fitness;
end
