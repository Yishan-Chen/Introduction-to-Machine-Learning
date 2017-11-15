%Script that runs the set of necessary experiments

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2; % Variance of stochastic noise

expt_data_med = zeros(length(Q_f),length(N),length(var));

for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
%             expt_data_med(ii,jj,kk) = median(computeOverfitMeasure(Q_f(ii),N(jj),1000,0.5,500));
            expt_data_med(ii,jj,kk) = median(computeOverfitMeasure(Q_f(ii),80,1000,var(kk),500));
%             expt_data_med(ii,jj,kk) = median(computeOverfitMeasure(10,N(jj),1000,var(kk),500));
        end
    end
%     fprintf('.');
end

% figure
% plot(N,expt_data_med(1,:,2),N,expt_data_med(2,:,2),N,expt_data_med(3,:,2),N,expt_data_med(4,:,2));
% legend('Qf=5','Qf=10','Qf=15','Qf=20')
% xlabel('Number of Data Points, N');
% ylabel("Difference of OverfitMeasure");
% title("Mean Difference for Different Level of Target Complexity(var=0.5)");

% figure
% plot(var,expt_data_mat(:,var*2+1));
% xlabel('stochastic noise');
% ylabel("Difference of OverfitMeasure");
% title("Mean Difference for Different target complexity(N=80)");

T5=0:0.5:2;
e4=zeros(1,5);
e5=zeros(1,5);
e6=zeros(1,5);
e7=zeros(1,5);
for k=1:5
    e4(k)=expt_data_med(1,2,k);
    e5(k)=expt_data_med(2,2,k);
    e6(k)=expt_data_med(3,2,k);
    e7(k)=expt_data_med(4,2,k);
end
figure(5)
plot(T5,e4,T5,e5,T5,e6,T5,e7);
legend('Qf=5','Qf=10','Qf=15','Qf=20')
xlabel('Stochastic Noise')
ylabel('Difference of OverfitMeasure')
title('Median Diference for Different Level of Target Complexity(N=80)')

% T6=40:40:120;
% e8=expt_data_med(2,:,1);
% e9=expt_data_med(2,:,2);
% e10=expt_data_med(2,:,3);
% e11=expt_data_med(2,:,4);
% e12=expt_data_med(2,:,5);
% figure(6)
% plot(T6,e8,T6,e9,T6,e10,T6,e11,T6,e12);
% legend('var=0','var=0.5','var=1.0','var=1.5','var=2.0')
% xlabel('Number of training set,N')
% ylabel('Difference of OverfitMeasure')
% title('Median Diference for different Stochastic Noises(Qf=10)')

            