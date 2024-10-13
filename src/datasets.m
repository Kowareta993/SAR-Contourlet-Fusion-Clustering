close all;
clc;
clear;
%% 

ds = {'bern', 'ottawa', 'area-m', 'area-n'};
formats = {'.png', '.png', '.png', '.png'};

for i = 1:numel(ds)
    figure;
    dataset = ds{i};
    im1 = double(im2gray(imread(strcat('dataset/', dataset, '1', formats{i}))));
    im1 = imresize(im1, [256 256], 'bilinear');
    im2 = double(im2gray(imread(strcat('dataset/', dataset, '2', formats{i}))));
    im2 = imresize(im2, [256 256], 'bilinear');
    gt = double(imbinarize(im2gray(imread(strcat('dataset/', dataset, '3', formats{i}))), 'global'));
    gt = imbinarize(imresize(gt, [256 256], 'bilinear'), 'global');
    subplot(1, 3, 1);
    imshow(im1, []);
    subplot(1, 3, 2);
    imshow(im2, []);
    subplot(1, 3, 3);
    imshow(gt, []);
end