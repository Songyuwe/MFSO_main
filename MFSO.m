
% Intermolecular force search algorithm
% Intermolecular force searcher
% Intermolecular force optimizer


function [BFglobal_score1,BFglobal_pos1,Convergence_curve,K]=MFSO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,Function_name)

tic
BFglobal_pos1=zeros(1,dim);
BFglobal_score1=inf;

fitness=zeros(1,SearchAgents_no);
Positions=initialization(SearchAgents_no,dim,ub,lb);
Convergence_curve=zeros(1,Max_iteration);

Radius=0.05;
p=0.8;
t=0;% Loop counter 
T=1;
% A1=zeros(30,500);
% a=zeros(30,1);b=zeros(30,1);c=zeros(30,1);d=zeros(30,1);
% Main loop
K=zeros(2,500);
k1=0;k2=0;
while t<Max_iteration
      for i=1:size(Positions,1)  
       % Return back the search agents that go beyond the boundaries of the
       % search space 
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;         
       
        % Calculate objective function for each search agent
        fitness(i)=fobj((Positions(i,:))',Function_name);
        
        if fitness(i)<BFglobal_score1 
            BFglobal_score1=fitness(i); 
            BFglobal_pos1=Positions(i,:);
        end
      end
      %%
      [order,index]=sort(fitness);
      [Fworst,~]=max(fitness);
      %%
      BF_fit1=order(1);  BF_fit2=order(2);  
      BF_fit3=order(3);  BF_fit4=order(4);
      BF_pos1=Positions(index(1),:);
      BF_pos2=Positions(index(2),:);
      BF_pos3=Positions(index(3),:);
      BF_pos4=Positions(index(4),:);
      M_center=[BF_pos1;BF_pos2;BF_pos3;BF_pos4];
      Fit_center=[BF_fit1; BF_fit2; BF_fit3; BF_fit4];
      %%
      r0=mean(Fit_center);
      r1=mean(fitness);

      T3=cos((pi/2)*(T/Max_iteration));
      T2=1.6*exp(-4*T/Max_iteration);
      T1=exp(-(1.5*T/Max_iteration).^3);
       
      %%
      for i=1:size(Positions,1)
          Dis=abs(fitness(i)-r0)/(Fworst-r0);
          Rat=fitness(i)/r0;
          Wave=waveSinCos(dim);

          dn=Brown(dim);
          if Dis<=Radius %r=r0
              k2=k2+1;
              R=1.3*rand*(1-T/Max_iteration).^(1/2);
              if (R>0.5) && (rand>0.5) 
                  m=randi([1, 4]);
                  Positions(i,:)=Positions(i,:)-rand*(M_center(m,:)-Positions(i,:))+dn;

              else
%                   k2=k2+1;
                  Pbest(1,:)=Positions(i,:)+Wave.*(BFglobal_pos1-Positions(i,:));
                  Fit=fobj((Pbest(1,:))',Function_name);
                  if Fit<fitness(i)
                      Positions(i,:)=Pbest;
                  end
              end

          elseif (Rat>1) && (Dis>Radius)  %r>r0 引力
              k1=k1+1;
              if fitness(i)<r1
                  A=(r1-fitness(i))/(r1-r0);
              else
                  A=(fitness(i)-r1)/(Fworst-r1);
              end
                  r1=rand();
                  if (fitness(i)>=r1) && (A>p) && (r1>0.5)
                      Positions(i,:)=initialization(1,dim,ub,lb);
                  else
                      v0=T1.*(BFglobal_pos1-Positions(i,:));
                      F0=Wave.*((1-rand*A).*BF_pos1-Positions(i,:))+dn;
                      Positions(i,:)=Positions(i,:)+v0+ T2.*F0;
                  end

          elseif (Rat<=1) && (Dis>Radius) %r>r0 斥力
              k2=k2+1;
                  if fitness(i)>=BFglobal_score1
                      Positions(i,:)=Positions(i,:)+T3*rand().*(BFglobal_pos1-Positions(i,:));
                  end
          end

      end
    t=t+1;    
    T=T+1;
    K(1,t)=k1;K(2,t)=k2;
    k1=0;k2=0;
    Convergence_curve(t)=BFglobal_score1;
    display(['At iteration ', num2str(t), ' the best fitness is ', num2str(BFglobal_score1)]);
end
toc
end

% function o=Levy(d)
% beta=1.5;
% sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
% u=randn(1,d)*sigma;v=randn(1,d);
% step=u./abs(v).^(1/beta);
% o=step;
% end
% 
