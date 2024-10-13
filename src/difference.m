close all;
clc;
clear;
%% 

addpath('contourlet_toolbox/')

datasets = {'bern', 'ottawa', 'area-m', 'area-n'};
formats = {'.png', '.png', '.png', '.png'};
%% diff figs


for i = 1:numel(datasets)
    figure;
    dataset = datasets{i};
    im1 = double(im2gray(imread(strcat('dataset/', dataset, '1', formats{i}))));
    im1 = imresize(im1, [256 256], 'bilinear');
    im2 = double(im2gray(imread(strcat('dataset/', dataset, '2', formats{i}))));
    im2 = imresize(im2, [256 256], 'bilinear');
    lr = log_ratio(im1, im2);
    mr = mean_ratio(im1, im2, 3);
    nlevels = [2, 3] ;
    pfilter = 'pkva' ;
    dfilter = 'pkva' ;
    Yl = pdfbdec(lr, pfilter, dfilter, nlevels);
    Ym = pdfbdec(mr, pfilter, dfilter, nlevels);
    Yf = contourlet_fusion(Yl, Ym);
    Y = pdfbrec(Yf, pfilter, dfilter);
    lr = uint8(255 .* (lr - min(lr(:))) ./ (max(lr(:)) - min(lr(:))));
    mr = uint8(255 .* (mr - min(mr(:))) ./ (max(mr(:)) - min(mr(:))));
    Y = uint8(255 .* (Y - min(Y(:))) ./ (max(Y(:)) - min(Y(:))));
    subplot(1, 3, 1);
    imshow(lr);
    title('log-ratio');
    subplot(1, 3, 2);
    imshow(mr);
    title('mean-ratio');
    subplot(1, 3, 3);
    imshow(Y);
    title('counterlet-fusion');
end