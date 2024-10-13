function [Sij] = FGFCM_similarity(im, i, j, sigma_i2, lambda_g, lambda_s)
    if i == j
        Sij = 0.0;
    else
        [R, ~] = size(im);
        pi = mod(i, R);
        qi = floor(i/R);
        pj = mod(j, R);
        qj = floor(j/R);
        x = abs(im(pi+1, qi+1) - im(pj+1, qj+1));
        Sij = exp(-double(max(abs(pi - pj), abs(qi - qj))) ./ lambda_s  - x * x ./ (lambda_g .* sigma_i2));
    end
    
end




