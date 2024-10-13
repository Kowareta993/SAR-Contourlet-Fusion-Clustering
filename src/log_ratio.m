function [lr] = log_ratio(im1, im2)
    lr = abs(log(im2 + 1) - log(im1 + 1));
    lr = 255.0*(lr - min(lr(:))) ./ (max(lr(:)) - min(lr(:)));
end

% 