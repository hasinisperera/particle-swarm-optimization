function[] = Assignment()
clc;
clear;
x1 = -3:3;
x2 = -3:3;
y = 20+exp(1)-20.*exp(-0.2.*((0.5.*(x1.^x1+x2.^x2)).^0.5)-exp(0.5.*(cos(2.*pi.*x1))+cos(2.*pi.*x2)));
plot3(x1,x2,y);
grid on;
hold on
%---------------------Parameters-----------------
Lb = -5;
Ub = 5;
n = 15;
w = 1; c1 = 2; c2 = 2;
iterations = 30;

%--------------------Initialization------------------
[x1] = init_Particles1(n,Lb,Ub);% Generate initial Partcles
[x2] = init_Particles2(n,Lb,Ub);
[v] = init_Velocities(n);% Generate initial Velocities

y = 20+exp(1)-20.*exp(-0.2.*((0.5.*(x1.^x1+x2.^x2)).^0.5)-exp(0.5.*(cos(2.*pi.*x1))+cos(2.*pi.*x2)));

plot3(x1,x2,y,'*');
hold on;

%--------------Init fitness and init pBest, gBest Partcles
fitnessVal = y;
pBest1 = x1;
pBest2 = x2;
pBest_fitness = fitnessVal;

[gBest_val idGbest] = min(fitnessVal);
gBest1 = x1(idGbest);
gBest2 = x2(idGbest);

plot3(gBest1,gBest2,gBest_val,'-s','MarkerSize',10,'MarkerFaceColor','r');
hold on;


%-----------Start iterations---------------

for i = 1:iterations%stooping criteria
x1 = -3:3;
x2 = -3:3;
y = 20+exp(1)-20.*exp(-0.2.*((0.5.*(x1.^x1+x2.^x2)).^0.5)-exp(0.5.*(cos(2.*pi.*x1))+cos(2.*pi.*x2)));
plot3(x1,x2,y);
grid on;
hold on;
    for j = 1:n % for each particle
        v1(j) = w*v(j) +  c1*rand()*(pBest1(j)-x1(j))+c2*rand()*(gBest1-x1(j));
        v2(j) = w*v(j) +  c1*rand()*(pBest2(j)-x2(j))+c2*rand()*(gBest2-x2(j));
        x1(j) = x1(j) + v1(j);
        x2(j) = x2(j) + v2(j);
        
        if  x1(j) < Lb
             x1(j) = Lb;
        elseif  x1(j)> Ub
             x1(j) = Ub;
        end
        
        if  x2(j) < Lb
             x2(j) = Lb;
        elseif  x2(j)> Ub
             x2(j) = Ub;
        end
                
        fitness(j) = 20+exp(1)-20*exp(-0.2*(0.5*(x1(j).^x1(j)+x2(j).^x2(j)).^0.5)-exp(0.5*(cos(2*pi*x1(j)))+cos(2*pi*x2(j))));
        y(j) = 20+exp(1)-20*exp(-0.2*(0.5*(x1(j).^x1(j)+x2(j).^x2(j)).^0.5)-exp(0.5*(cos(2*pi*x1(j)))+cos(2*pi*x2(j))));
         
        if(fitness(j)< pBest_fitness(j))
            pBest_fitness(j) = fitness(j);
            pBest1(j) = x1(j); 
            pBest2(j) = x2(j); 
        end
        
        if(fitness(j)< gBest_val)
            gBest_val = fitness(j);
            gBest1 = x1(j);
            gBest2 = x2(j);
        end
    end
  plot3(gBest1,gBest2,gBest_val,'-s','MarkerSize',10,'MarkerFaceColor','r')
  plot3(x1,x2,y,'o','MarkerSize',6,'MarkerFaceColor','b')
  drawnow;
  hold off
end

gBest1
gBest2
gBest_val
%---------------Sub functions---------------

function [x1] = init_Particles1(n,Lb,Ub)
 x1 = Lb +(Ub-Lb).*rand(1,n);

 function [x2] = init_Particles2(n,Lb,Ub)
 x2 = Lb +(Ub-Lb).*rand(1,n);
 
function [v] = init_Velocities(n)
     v(1,n) = 0;
