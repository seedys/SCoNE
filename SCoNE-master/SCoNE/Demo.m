% Demo for SCoNE: Spherical Consistent Neighborhoods Ensemble for Effective and Efficient Multi-View Anomaly Detection
clear;clc;


%% Data preparation
% dataname = ['zoo','parkinsons','wdbc','mnist','AWA','Caltech7','facebook',];
Dataname = 'mnist';
disp(['------------------multi-view data preparation on ',Dataname,' dataset-------------------------']);
load('mnist.mat');

data = fea;
label = gt;

Ratios = [2,5,8]./100; 
views = 3; % 3,6
[mvad_data,mvad_label] = data_preparation(data,label,Ratios,views);
disp('------------------Data preparation finished!');



%% Test time overhead for SCoNE
disp('------------------Test time overhead on SCoNE');
t = 100; psi = 4; k = 3;
tic;
[hash_values] = Hypersphere_hashing(mvad_data, psi, k, t);
anomaly_scores = ones(length(mvad_label),1);
for ni = 1:length(mvad_label)
    temp = ones(1,t*(psi+1));
    for vi = 1:views
        temp = temp.*hash_values{vi}(ni,:);
    end
    anomaly_scores(ni) = sum(temp);
end
disp(['AUC: ',num2str(calAUC(anomaly_scores,1-mvad_label))]);
toc;

disp('------------------SCoNE finished!!');



%% Test AUC result for SCoNE
disp('------------------Test AUC result on SCoNE');
% search for parameters
t = 100; % 200,400
psilist = 2.^[1:1:10];  % psilist = 2.^[1:1:10];
klist = [1, 3, 5, 7, 11, 21, 51, 101];
for pi = 1:length(psilist)
    psi = psilist(pi);
    for ki = 1:length(klist)
        k = klist(ki);
        if k > psi
            break;
        end
        disp('Calculation on current set of parameters:');
        [hash_values] = Hypersphere_hashing(mvad_data, psi, k, t);
        anomaly_scores = ones(length(mvad_label),1);
        for ni = 1:length(mvad_label)
            temp1 = ones(1,t*(psi+1));
            for vi = 1:views
                temp1 = temp1.*hash_values{vi}(ni,:);
            end
            anomaly_scores(ni) = sum(temp1);
        end
        Res(pi,ki) = calAUC(anomaly_scores,1-mvad_label);
        disp(['results: ', num2str(Res(pi,ki))]);
    end
end
disp('------------------SCoNE finished!!');
disp('Final AUC Result(one time): ');
disp(max(max(Res)))


