function res = calAUC(preVal,trueLab)
%calculate the value of AUC
[~,index]=sort(preVal,'descend');
roc_y=trueLab(index);
stack_x=cumsum(roc_y==0)/sum(roc_y==0);
stack_y=cumsum(roc_y==1)/sum(roc_y==1);
res=sum((stack_x(2:length(roc_y),1)-stack_x(1:length(roc_y)-1,1)).*stack_y(2:length(roc_y),1));
end