function [sigma_i2] = sigma2(im, i, w)
    [R, C] = size(im);
    pi = mod(i, R);
    qi = floor(i/R);
    si = max(0, floor(pi - w/2));
    ei = min(pi + floor(w/2), R-1);
    sj = max(0, qi - floor(w/2));
    ej = min(qi + floor(w/2), C-1);
    window = im(si+1:ei+1, sj+1:ej+1);
    s = abs(im(pi+1, qi+1) - window(:));
    sigma_i2 = mean(s .^ 2);
end
