function createfigureplot2(YMatrix1)
%CREATEFIGURE(YMatrix1)
%  YMATRIX1:  plot y 数据的矩阵

%  由 MATLAB 于 21-Apr-2024 21:29:52 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 plot 的矩阵输入创建多个 line 对象
plot1 = plot(YMatrix1, ...
    MarkerSize=10);
set(plot1(1),'DisplayName','Best',...
    'MarkerIndices',[1,51 101 151 201 251 301 351 401 451 501 551 601 651 701 751 801 851 901 951 1001],...
    'MarkerEdgeColor',[0.929411764705882 0.694117647058824 0.125490196078431],...
    'Marker','pentagram',...
    'LineWidth',2,...
    'Color',[0.32156862745098 0.0274509803921569 0.0823529411764706]);
set(plot1(2),'DisplayName','Avg','LineWidth',2.5,...
    'Color',[0.541176470588235 0.56078431372549 0.811764705882353]);

% 创建 ylabel
ylabel('完成时间');

% 创建 xlabel
xlabel('进化代数');

% 取消以下行的注释以保留坐标区的 X 范围
xlim(axes1,[-5 1005]);
% 取消以下行的注释以保留坐标区的 Y 范围
%ylim(axes1,[559.532573765703 759.532573765703]);
box(axes1,'on');
hold(axes1,'off');
% 设置其余坐标区属性
set(axes1,'FontName','Serif','FontSize',14,'FontWeight','bold','LineWidth',...
    1,'SubtitleFontWeight','bold','TitleFontWeight','bold','XTick',...
    [0 200 400 600 800 1000]);
% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.742738093909763 0.78674610423851 0.146785715614046 0.113571431023734]);

