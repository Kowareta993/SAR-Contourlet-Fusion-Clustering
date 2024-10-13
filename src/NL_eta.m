function [eta, lambda] = NL_eta(Y, r, h, s)
    [R, C]= size(Y);
    [y, x] = meshgrid(1:2*r+1, 1:2*r+1);
    y = y - r - 1;
    x = x - r - 1;
    mask = x.^2 + y.^2 <= r.^2;
    eta = zeros([1 R*C]);
    lambda = zeros([1 R*C]);
    im = padarray(Y, [r r], 0, 'both');
    im = parallel.pool.Constant(im);
    parfor i = 0:R*C-1
        xi = mod(i, R);
        yi = floor(i/R);
        [eta(i+1), lambda(i+1)]= f(im, (yi+r)*(R+2*(r))+xi+r, mask, r, h, s);
    end
    
    
end

function [level, lambda] = f(Y, i, mask, r, h, s)
    im = Y.Value;
    [R, ~]= size(im);
    xi = mod(i, R);
    yi = floor(i/R);
    W = zeros(2*r + 1);
    X = im(xi-r+1:xi+r+1, yi-r+1:yi+r+1);
    parfor x = 0:(2*r+1)*(2*r+1)-1
        p = xi - r + mod(x, 2*r+1);
        q = yi - r + floor(x / (2*r+1));
        if mask(x+1)
            W(x+1) = exp(-PPB_similarity(im, i , q*R + p, s)/h);
        end
    end
    lambda = sort(W(:), 'descend');
    lambda = sum(lambda(1:2*r)) / (2*r);
    W = W ./ sum(W(:));
    level = sum(X .* W, 'all');
end