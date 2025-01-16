function [mvad_data,mvad_label] = data_preparation(data,label,Ratios,views)

% for vi = 1:views
%     mvad_data{vi} = [];
% end
% generate multi-view data
data = (data-min(data)).*((max(data)-min(data)+0.00000001).^-1);
L = size(data,1);
attrL = fix((size(data,2)-1)/3)*3;
Ratios1 = Ratios;
Ratios1 = [0.02,0.05,0.08];
anonum1 = fix(L.*Ratios1(1));  % Attribute Anomaly
anonum2 = fix(L.*Ratios1(2));  % Class-Attribute Anomaly
anonum3 = fix(L.*Ratios1(3));  % Class Anomaly
anonum = anonum1+anonum2+anonum3;
mvad_label = zeros(L,1);
attrIndex = datasample(1:attrL, attrL, 'Replace', false);
for vi = 1:views
    mvad_data{vi} = data(:,attrIndex((vi-1)*(attrL./3)+1:vi*(attrL./3)));
end

% generate anomalies
anoIndex = datasample(1:L, anonum, 'Replace', false);
mvad_label(anoIndex) = 1;
anom1 = anoIndex(1:anonum1);
anom2 = anoIndex(anonum1+1:anonum1+anonum2);
anom3 = anoIndex(anonum1+anonum2+1:end);
% Attribute Anomaly
for i = 1:anonum1
    for vi = 1:views
        mvad_data{vi}(anom1(i),:) = rand(1,size(mvad_data{vi},2)); 
    end
end
% Class-Attribute Anomaly
for i = 1:anonum2
    mvad_data{fix(rand*views+1)}(anom2(i),:) = rand(1,size(mvad_data{fix(rand*views+1)},2));
end
% Class Anomaly
for i = 1:anonum3
    n_indx = datasample(1:L, 1, 'Replace', false);
    if label(n_indx) == label(anom3(i))
        i = i-1;
        continue;
    end
    mvad_data{fix(rand*views+1)}(anom3(i),:) = mvad_data{fix(rand*views+1)}(n_indx,:)./(max(mvad_data{fix(rand*views+1)}(n_indx,:))+0.000001);
end

end






