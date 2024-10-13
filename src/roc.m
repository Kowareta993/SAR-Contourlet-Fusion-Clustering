close all;
clc;
clear;
%% 

addpath('contourlet_toolbox/')

datasets = {'bern', 'ottawa', 'area-m', 'area-n'};
formats = {'.png', '.png', '.png', '.png'};
%% roc plots

figure;
for i = 1:numel(datasets)
    dataset = datasets{i};
    im1 = double(im2gray(imread(strcat('dataset/', dataset, '1', formats{i}))));
    im1 = imresize(im1, [256 256], 'bilinear');
    im2 = double(im2gray(imread(strcat('dataset/', dataset, '2', formats{i}))));
    im2 = imresize(im2, [256 256], 'bilinear');
    gt = double(imbinarize(im2gray(imread(strcat('dataset/', dataset, '3', formats{i}))), 'global'));
    gt = imbinarize(imresize(gt, [256 256], 'bilinear'), 'global');
    lr = log_ratio(im1, im2);
    mr = mean_ratio(im1, im2, 3);
    nlevels = [1, 2, 3, 4, 5] ;
    pfilter = 'pkva' ;
    dfilter = 'pkva' ;
    Yl = pdfbdec(lr, pfilter, dfilter, nlevels);
    Ym = pdfbdec(mr, pfilter, dfilter, nlevels);
    Yf = contourlet_fusion(Yl, Ym);
    Y = pdfbrec(Yf, pfilter, dfilter);
    lr = uint8(255 .* (lr - min(lr(:))) ./ (max(lr(:)) - min(lr(:))));
    mr = uint8(255 .* (mr - min(mr(:))) ./ (max(mr(:)) - min(mr(:))));
    Y = uint8(255 .* (Y - min(Y(:))) ./ (max(Y(:)) - min(Y(:))));
    th = 0.01:0.01:.99;
    images = {lr mr Y};
    r = ceil(numel(datasets) / 2);
    c = ceil(numel(datasets) / r);
    subplot(r, c, i);
    title(strcat('ROC of', " ", dataset))
    hold on;
    for j = 1:numel(images)
        tpr = zeros(size(th));
        fpr = zeros(size(th));
        for t = 1:numel(th)
            im = im2bw(im2double(images{j}), th(t));
            tp = numel(im(im == 1 & gt == 1));
            fn = numel(im(im == 0 & gt == 1));
            tpr(t) = tp / (tp + fn);
            fp = numel(im(im == 1 & gt == 0));
            tn = numel(im(im == 0 & gt == 0));
            fpr(t) = fp / (fp + tn);
        end
        [fpr, indices] = sort(fpr);
        tpr = tpr(indices);
        plot(fpr, tpr);
    end
    hold off;
    xlabel('FP rate');
    ylabel('TP rate')
    legend('log-ratio', 'mean-ratio', 'counterlet');
end
%% auc plots

figure;
lvls = 5;
for i = 1:numel(datasets)
    dataset = datasets{i};
    im1 = double(im2gray(imread(strcat('dataset/', dataset, '1', formats{i}))));
    im1 = imresize(im1, [256 256], 'bilinear');
    im2 = double(im2gray(imread(strcat('dataset/', dataset, '2', formats{i}))));
    im2 = imresize(im2, [256 256], 'bilinear');
    gt = double(imbinarize(im2gray(imread(strcat('dataset/', dataset, '3', formats{i}))), 'global'));
    gt = imbinarize(imresize(gt, [256 256], 'bilinear'), 'global');
    lr = log_ratio(im1, im2);
    mr = mean_ratio(im1, im2, 3);
    pfilter = 'pkva' ;
    dfilter = 'pkva' ;
    area = zeros([1 numel(2:lvls)]);
    time = zeros([1 numel(2:lvls)]);
    for lvl = 2:lvls
        tic;
        nlevels = 1:lvl ;
        Yl = pdfbdec(lr, pfilter, dfilter, nlevels);
        Ym = pdfbdec(mr, pfilter, dfilter, nlevels);
        Yf = contourlet_fusion(Yl, Ym);
        Y = pdfbrec(Yf, pfilter, dfilter);
        Y = uint8(255 .* (Y - min(Y(:))) ./ (max(Y(:)) - min(Y(:))));
        th = 0.01:0.01:.99;
        tpr = zeros(size(th));
        fpr = zeros(size(th));
        for t = 1:numel(th)
            im = im2bw(im2double(Y), th(t));
            tp = numel(im(im == 1 & gt == 1));
            fn = numel(im(im == 0 & gt == 1));
            tpr(t) = tp / (tp + fn);
            fp = numel(im(im == 1 & gt == 0));
            tn = numel(im(im == 0 & gt == 0));
            fpr(t) = fp / (fp + tn);
        end
        [fpr, indices] = sort(fpr);
        tpr = tpr(indices);
        area(lvl-1) = trapz(fpr, tpr);
        time(lvl-1) = toc;
    end
    r = ceil(numel(datasets) / 2);
    c = ceil(numel(datasets) / r);
    subplot(r, c, i);
    title(strcat('Area of', " ", dataset))
    plot(2:lvls, area);
    ylabel('Area')
    yyaxis right
    plot(2:lvls, time);
    ylabel('Time')
    xlabel('nlevels');
    title(dataset);
end