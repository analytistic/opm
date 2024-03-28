%%  定义函数和初始化
f = @(x)cos(x);        % 所求函数
a = 0;b = 2*pi;        % 初始搜索区间
Theta_error = 0.001;   % 收敛精度
r = (sqrt(5)-1)/2;     % 给r赋值0.618

%%算法部分
a1 = b - r*(b-a);  
a2 = a + r*(b-a);
y1 = feval(f,a1);
y2 = feval(f,a2);
stepNum = 0;           % 迭代次数初始化
%循环部分         
while abs((b-a)/b) >= Theta_error || abs((y2-y1)/y2) >= Theta_error
    stepNum = stepNum + 1;
    if y1 >= y2
        a = a1;
        a1 = a2;
        y1 = y2;
        a2 = a+r*(b-a);
        y2 = feval(f,a2);
    else
        b = a2;
        a2 = a1;
        y2 = y1;
        a1 = b - r*(b-a);
        y1 = feval(f,a1);
    end
end
   
%% 输出
x_opt = (a+b)/2
y_opt = feval(f,x_opt)
fprintf('程序经过%d次迭代得到函数极小值点为%d ',stepNum,x_opt)

%% 绘制函数图像
x = 0:0.01:2*pi;
y = cos(x);
plot(x,y)
hold on
plot(x_opt,y_opt,'r*') % 在图像中标出极小值点
