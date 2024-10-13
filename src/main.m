close all;
clc;
clear;
%% 

datasets = {'bern', 'ottawa', 'area-m', 'area-n'};
formats = {'.png', '.png', '.png', '.png'};

for i = 1:numel(datasets)
    figure;
    dataset = datasets{i};
    im1 = double(im2gray(imread(strcat('dataset/', dataset, '1', formats{i}))));
    im1 = imresize(im1, [256 256], 'bilinear');
    im2 = double(im2gray(imread(strcat('dataset/', dataset, '2', formats{i}))));
    im2 = imresize(im2, [256 256], 'bilinear');
    gt = double(imbinarize(im2gray(imread(strcat('dataset/', dataset, '3', formats{i}))), 'global'));
    gt = imbinarize(imresize(gt, [256 256], 'bilinear'), 'global');
    FN = zeros([3 1]);
    FP = zeros([3 1]);
    PCC = zeros([3 1]);
    diff = detection(im1, im2, 4, "FCM");
    subplot(1,4,1);
    imshow(diff, []);
    title("FCM");
    [FN(1), FP(1), PCC(1)] = PCC_eval(diff, gt);
    diff = detection(im1, im2, 4, "FGFCM");
    subplot(1,4,2);
    imshow(diff, []);
    title("FGFCM");
    [FN(2), FP(2), PCC(2)] = PCC_eval(diff, gt);
    diff = detection(im1, im2, 4, "FNLC");
    subplot(1,4,3);
    imshow(diff, []);
    title("FNLC");
    [FN(3), FP(3), PCC(3)] = PCC_eval(diff, gt);
    subplot(1,4,4);
    imshow(gt, []);
    title("Ground Truth");
    Method = ["FCM";"FGFCM";"FNLC"];
    table(Method,FN,FP,PCC)
end

