%__________________________________________

clear all 
clc

SearchAgents_no=30; % Number of search agents
Max_iteration=500;  %最大迭代次数
lb=-100;             %变量下界
ub=100;              %变量上界
dim=10;              %维度 10/20
fobj=str2func('cec22_test_func');  %根据字符向量构造函数句柄
Function_name=3;     %
for i=1:20
[Best_score,Best_pos,Convergence_curve]=MFSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,Function_name);
end
