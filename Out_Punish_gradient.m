%%目标函数在line 4行可以选择
clear all;clc
syms x1 x2 x; 
f=x1^2+x2^2-x1*x2-10*x1-4*x2+60;%原函数
g1=x1-6;g2=x2-8;g3=x1+x2-11;%约束条件转换函数
e1=0.001;%梯度法最优值收敛精度
e2=0.001;%外点法收敛精度
D=1;%差值
k=1;
A(k)=0;B(k)=0;%A,B分别记录x1,x2点，初始点为[0,0]
r(k)=1;a=2;%r为惩罚因子，a为递增系数
%% 循环
while  D>e2 %罚因子迭代收敛条件
    x1=A(k);x2=B(k);
%判断点在不在可行域内，来选择惩罚函数
if x1-6>0
    u1=1;
else
    u1=0;
end
if x2-8>0
    u2=1;
else
   u2=0;
end
if x1+x2-11>0
    u3=1;
else
    u3=0;
end
%约束问题转换后的新目标函数
F=f+r(k)*u1*g1^2+r(k)*u2*g2^2+r(k)*u3*g3^2;
%梯度法求F的最优解xr
Fx1=diff(F,'x1');Fx2=diff(F,'x2');Fx1x1=diff(Fx1,'x1');Fx1x2=diff(Fx1,'x2');Fx2x1=diff(Fx2,'x1');Fx2x2=diff(Fx2,'x2');%求偏导、海森元素。
for n=1:100 %梯度法求最优值。
F1=subs(Fx1); %求解梯度值和海森矩阵
F2=subs(Fx2);
F11=subs(Fx1x1);
F12=subs(Fx1x2);
F21=subs(Fx2x1);
F22=subs(Fx2x2);
if(double(sqrt(F1^2+F2^2))<=e1) %梯度法最优值收敛条件
A(k+1)=double(x1);B(k+1)=double(x2);
break;
else
X=[x1 x2]'-([F11 F12;F21 F22])\[F1 F2]';
x1=X(1,1);x2=X(2,1);
end
end
D=double(sqrt((A(k+1)-A(k))^2+(B(k+1)-B(k))^2));
r(k+1)=a*r(k);
k=k+1;
end
A(k)
B(k)
double(subs(f))
