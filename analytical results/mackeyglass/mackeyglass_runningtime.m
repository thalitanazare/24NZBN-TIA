clear all;
close all;
clc;

num_iter = 50;
normal_time = zeros(1, num_iter);
horner_time = zeros(1, num_iter);

for iter = 1:num_iter
%normal method
tic
format long
x=[0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01];


N=10000;
for k=11:N
x(k)=0.24662*10*x(k-1) - 0.16423*10*x(k-2) + 0.60992*x(k-3) + 0.73012e-1*x(k-5)^2*x(k-10)^2 + 0.38566*x(k-3)*x(k-10) + 0.66999*x(k-1)*x(k-10)^2+ 0.88364*x(k-1)^3- 0.67300*x(k-4)*x(k-10)^2- 0.11929*10*x(k-1)^2 - 0.50451e-1*x(k-4)*x(k-5) - 0.24765*x(k-1)^4 + 0.42081*x(k-4)*x(k-9)*x(k-10)^2- 0.70406*x(k-1)*x(k-10)^3- 0.14089*x(k-5)*x(k-8)^2+ 0.14807*x(k-1)*x(k-7)*x(k-10);
end
 normal_time(iter) = toc;



% plot(x,'k')
% hold on
% 
% filex = fopen('mackeyglass.txt','w');
% fprintf(filex,'%12.15f\n',x);
% fclose(filex);

%Horner's method

tic
format long
x2=[0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01];


% N=10000;
% for k=11:N
% x2(k)=-0.16423*10*x2(k-2) + 0.60992*x2(k-3) - 0.50451e-1*x2(k-4)*x2(k-5) - 0.14089*x2(k-5)*x2(k-8)^2 + x2(k-10)*(+ 0.38566*x2(k-3) + x2(k-10) *(0.73012e-1*x2(k-5)^2 + x2(k-4) *(- 0.67300 + 0.42081* x2(k-9)))) + x2(k-1) *((0.24662*10 + x2(k-10)*(0.14807*x2(k-7)+x2(k-10)*(0.66999+x2(k-10)*(- 0.70406)))) + x2(k-1)*(- 0.11929*10 + x2(k-1) * (0.88364 + x2(k-1) *(- 0.24765))) ); 
% 
% end
% horner_time(iter) = toc;
% end

N=10000;
for k=11:N
x2(k)=-0.16423*10*x2(k-2) + 0.60992*x2(k-3) + 0.73012e-1*x2(k-5)^2*x2(k-10)^2 + 0.38566*x2(k-3)*x2(k-10) - 0.67300*x2(k-4)*x2(k-10)^2 - 0.50451e-1*x2(k-4)*x2(k-5)  + 0.42081*x2(k-4)*x2(k-9)*x2(k-10)^2- 0.14089*x2(k-5)*x2(k-8)^2 + x2(k-1) *((0.24662*10+0.66999*x2(k-10)^2- 0.70406*x2(k-10)^3+ 0.14807*x2(k-7)*x2(k-10)) + x2(k-1)*(- 0.11929*10 + x2(k-1) * (0.88364 + x2(k-1) *(- 0.24765))) ); 
end
horner_time(iter) = toc;
end

 % Calculate mean and standard deviation
normal_mean = mean(normal_time);
normal_std = std(normal_time);
horner_mean = mean(horner_time);
horner_std = std(horner_time);

% Display results
fprintf('Normal method: \n');
fprintf('Mean time: %.15f\n', normal_mean);
fprintf('Standard deviation: %.15f\n', normal_std);
fprintf('\n');
fprintf('Horner''s method: \n');
fprintf('Mean time: %.15f\n', horner_mean);
fprintf('Standard deviation: %.15f\n', horner_std);

% plot(x2,'b')
% hold on
% 
% 
% filex2 = fopen('mackeyglass_horner.txt','w');
% fprintf(filex2,'%12.15f\n',x2);
% fclose(filex2);
