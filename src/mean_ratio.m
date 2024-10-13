function [mr] = mean_ratio(im1, im2, wn)
    [R, C] = size(im1);
    u1 = zeros(size(im1));
    parfor x = 0:R*C-1
        u1(x+1) = local_mean(im1, mod(x, R), floor(x/R), wn);
    end
    u2 = zeros(size(im2));
    parfor x = 0:R*C-1
        u2(x+1) = local_mean(im2, mod(x, R), floor(x/R), wn);
    end
    mr = 1 - min(u1, u2) ./ max(u1, u2);
    mr = 255 * (mr - min(mr(:))) / (max(mr(:)) - min(mr(:)));
    
end

function [u] = local_mean(im, i, j, w)
    si = max(0, floor(i - w/2));
    ei = min(i + floor(w/2), size(im, 1)-1);
    sj = max(0, j - floor(w/2));
    ej = min(j + floor(w/2), size(im, 2)-1);
    window = im(si+1:ei+1, sj+1:ej+1);
    u = mean(window(:));
end