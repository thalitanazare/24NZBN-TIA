clear all;
close all;
 clc;

num_iter = 50;
normal_time = zeros(1, num_iter);
horner_time = zeros(1, num_iter);

for iter = 1:num_iter
% Normal

   tic
x(1)=5;
y(1)=6;
z(1)=7;
for i = 2:1:6000
    x(i)=0.85919*x(i-1)+0.22489*y(i-1)-0.2833*10^(-2)*x(i-1)*z(i-1)-0.34598*10^(-3)*y(i-1)*z(i-1)-0.12927*10^(-1)-0.69159*10^(-3)*x(i-1)*y(i-1)+0.73257*10^(-3)*x(i-1)^2;
    y(i)=1.109*y(i-1)-0.6713*10^(-2)*y(i-1)*z(i-1)-0.18688*10^(-1)*x(i-1)*z(i-1)+0.54947*x(i-1)-0.33705*10^(-4)*z(i-1)^2+0.67054*10^(-4)*x(i-1)*y(i-1)-0.36965*10^(-3)*x(i-1)^2;
    z(i)=1.0077*z(i-1)+0.93353*10^(-2)*x(i-1)*y(i-1)-0.21708*10^(-2)*z(i-1)^2+0.72469*10^(-2)*x(i-1)^2+0.76919*10^(-2)*y(i-1)^2-0.47834+0.48760*10^(-4)*y(i-1)*z(i-1);
end
 normal_time(iter) = toc;



% Horner's method

    tic
x2(1)=5;
y2(1)=6;
z2(1)=7;
for i = 2:1:6000
    x2(i)=x2(i-1)*(0.85919-0.2833*10^(-2)*z2(i-1)-0.69159*10^(-3)*y2(i-1)+0.73257*10^(-3)*x2(i-1))+y2(i-1)*(0.22489-0.34598*10^(-3)*z2(i-1))-0.12927*10^(-1);
    y2(i)=z2(i-1)*(-0.6713*10^(-2)*y2(i-1)-0.18688*10^(-1)*x2(i-1)-0.33705*10^(-4)*z2(i-1))+x2(i-1)*(0.54947+0.67054*10^(-4)*y2(i-1)-0.36965*10^(-3)*x2(i-1))+1.109*y2(i-1);
    z2(i)=y2(i-1)*(0.93353*10^(-2)*x2(i-1)+0.76919*10^(-2)*y2(i-1)+0.48760*10^(-4)*z2(i-1))+z2(i-1)*(1.0077-0.21708*10^(-2)*z2(i-1))+0.72469*10^(-2)*x2(i-1)^2-0.47834;
end
    horner_time(iter) = toc;
end

% % Calculate mean and standard deviation
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


% figure(1)
% plot(x,'k')
% figure(2)
% plot(y,'k')
% figure(3)
% plot(z,'k')
% figure(4)
% plot3(x,y,z,'k')
% 
% 
% figure(5)
% plot(x2,'k')
% figure(6)
% plot(y2,'k')
% figure(7)
% plot(z2,'k')
% figure(8)
% plot3(x2,y2,z2,'k')
% 
% figure(9)
% plot(x,'k')
% hold on
% plot(x2,'b')