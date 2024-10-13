function [diff] = detection(im1, im2, nlevels, method)
    addpath('contourlet_toolbox/')
    %ratio
    lr = log_ratio(im1, im2);
    mr = mean_ratio(im1, im2, 3);
    %ct
    nlevels = 1:nlevels;
    pfilter = 'pkva' ;
    dfilter = 'pkva' ;
    Yl = pdfbdec(lr, pfilter, dfilter, nlevels);
    Ym = pdfbdec(mr, pfilter, dfilter, nlevels);
    %fusion
    Yf = contourlet_fusion(Yl, Ym);
    %cit
    Y = pdfbrec(Yf, pfilter, dfilter);
    FI = uint8(255 .* (Y - min(Y(:))) ./ (max(Y(:)) - min(Y(:))));
    if method == "FCM"
        [~, U] = fcm(reshape(double(FI), [numel(FI) 1]), 2, [2.0 100 1e-5 false]);
        [~,diff] = max(U,[],1);
    elseif method == "FGFCM"
        [~, U] = FGFCM(double(FI), 2, 100);
        [~,diff] = max(U,[],1);
    elseif method == "FNLC"
        [~, U] = FNLC(double(FI), 2, 100);
        [~,diff] = max(U,[],1);
    end
    if(numel(diff(diff == 1)) > numel(diff(diff == 2)))
        diff(diff == 1) = 0;
        diff(diff == 2) = 1;
    else
        diff(diff == 2) = 0;
        diff(diff == 1) = 1;
    end
    diff = reshape(diff, size(im1));
end

