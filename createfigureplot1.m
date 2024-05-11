function createfigureplot1(YMatrix1)
%CREATEFIGURE(YMatrix1)
%  YMATRIX1:  plot y 数据的矩阵

%  由 MATLAB 于 21-Apr-2024 21:23:23 自动生成

% 创建 figure
figure1 = figure;
colormap(winter);

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 plot 的矩阵输入创建多个 line 对象
plot1 = plot(YMatrix1,...
    'MarkerIndices',[1,51 101 151 201 251 301 351 401 451 501 551 601 651 701 751 801 851 901 951 1001],...
    'MarkerSize',10);
set(plot1(2),'DisplayName','Avg',...
    'MarkerEdgeColor',[0.301960784313725 0.745098039215686 0.933333333333333],...
    'LineWidth',2.5,...
    'Color',[0.580392156862745 0.384313725490196 0.6]);
set(plot1(1),'DisplayName','Best',...
    'MarkerEdgeColor',[0.149019607843137 0.149019607843137 0.149019607843137],...
    'Marker','hexagram',...
    'LineWidth',2,...
    'Color',[0.4 0.466666666666667 0.67843137254902]);

% 创建 xlabel
xlabel('进化代数');

% 创建 title
title('进化曲线','FontWeight','bold');

% 取消以下行的注释以保留坐标区的 X 范围
xlim(axes1,[-5 1005]);
box(axes1,'on');
hold(axes1,'off');
% 设置其余坐标区属性
set(axes1,'FontName','Serif','FontSize',14,'FontWeight','bold','LineWidth',...
    1,'XTick',[0 200 400 600 800 1000]);
% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.737023808195477 0.794365076912774 0.146785715614046 0.113571431023734],...
    'EdgeColor',[0 0 0]);

