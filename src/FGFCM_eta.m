function [eta] = FGFCM_eta(Y, wn)
    [R, C]= size(Y);
    eps = .0000001;
    sigma_2 = zeros([1 R*C]);
    parfor i = 0:R*C-1
        sigma_2(i+1) = sigma2(Y, i, wn) + eps;
    end
    eta = zeros([1 R*C]);
    parfor i = 0:R*C-1
        eta(i+1) = f(Y, i, sigma_2(i+1), wn);
    end
    
end

function [level] = f(im, i, sigma_i2, w)
    [R, C]= size(im);
    xi = mod(i, R);
    yi = floor(i/R);
    r = floor(w/2);
    [x, y] = meshgrid(xi-r:xi+r, yi-r:yi+r);
    x = x';
    y = y';
    mask = x >= 0 & y >= 0 & x < R & y < C;
    idx = y .* R + x;
    idx = idx(mask == 1);
    X = im(idx+1)';
    S = zeros([1 numel(idx)]);
    parfor j = 1:numel(idx)
        S(j) = FGFCM_similarity(im, i, idx(j), sigma_i2, 10, 10);
    end    
    level = sum(S .* X) / sum(S);
end