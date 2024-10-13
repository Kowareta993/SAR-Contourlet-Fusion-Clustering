function [Yf] = contourlet_fusion(Yl, Ym)
    Yf = cell(size(Yl));
    % low freq
    Yf{1} = (Yl{1} + Ym{1}) ./ 2;
    % high freq
    for i = 2:numel(Yl)
        Yf{i} = high_fusion(Yl{i}, Ym{i});
%         Yf{i} = Yl{i};
    end
end

function [Yfh] = high_fusion(Yl, Ym)
    Yfh = cell(size(Yl));
    for i = 1:numel(Yl)
        coeff_l = Yl{i};
        coeff_m = Ym{i};
        El = energy(coeff_l);
        Em = energy(coeff_m);
        fusion = zeros(size(coeff_l));
        fusion(El < Em) = coeff_l(El < Em);
        fusion(El >= Em) = coeff_m(El >= Em);
        Yfh{i} = fusion;
    end
end

function [E] = energy(im) 
    [R, C] = size(im);
    E = zeros(size(im));
    w = 1;
    r = floor(w/2);
    parfor x = 0:R*C-1
        i = mod(x, R);
        j = floor(x/R);
        si = max(0, i - r);
        ei = min(i + r, R-1);
        sj = max(0, j - r);
        ej = min(j + r, C-1);
        window = im(si+1:ei+1, sj+1:ej+1);
        E(x+1) = sum(window .^ 2, 'all');
    end
end
    
