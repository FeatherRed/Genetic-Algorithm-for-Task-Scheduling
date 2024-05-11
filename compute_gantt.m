function [start_time,end_time,jobId] = compute_gantt(bestchrom,Time,dependency)
%COMPUTE_GANTT 此处显示有关此函数的摘要
%   此处显示详细说明
[~,m] = size(bestchrom);
[n,~] = size(dependency);
start_time = zeros(1,m);
end_time = zeros(1,m);
jobId = zeros(1,n);
finish_time = zeros(1,m);
p = 1;
Len = 0;
time_dependency = dependency;
time_dependency_1 = dependency;
for j = 1:m
    Len = length(bestchrom(j).dealers) + Len;
end
while(Len ~= 0)
    if(isempty(bestchrom(p).dealers))
      if(mod(p,m) == 0)
            p = 1;
      else
            p = mod(p,m) + 1;
      end
      continue;
   end
   task_first = bestchrom(p).dealers(1,1);
   jobId(task_first) = p;
   if(sum(time_dependency(:,task_first)) == 0)
       bestchrom(p).dealers(1) = [];
       start_time(task_first) = finish_time(p);
       finish_time(p) = finish_time(p) + Time(task_first);
       time_dependency(task_first,:) = 0;
   end
   %搜索其他处理机
   for j = 1:m
       if(j == p)continue;
       end
       j_task =bestchrom(j).dealers;
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
       Len = length(bestchrom(j).dealers) + Len;
   end
   
end
end_time = start_time + Time;
end

