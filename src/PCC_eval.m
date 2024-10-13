function [fn, fp, pcc] = PCC_eval(Y, GT) %computing PCC for Y considering groud truth GT
    tp = numel(Y(Y == 1 & GT == 1));
    tn = numel(Y(Y == 0 & GT == 0));
    fp = numel(Y(Y == 1 & GT == 0));
    fn = numel(Y(Y == 0 & GT == 1));
    pcc = (tp + tn) / (tp + tn + fp + fn);
end

