function [v, mu] = FNLC(Y, C, max_iters)
    v = rand([1 C]) .* 255;
    v = v ./ sum(v(:));
    mu = zeros([C numel(Y)]);
    eta = FNLC_eta(Y);
    m = 2.0;
    epsilon = 1e-5;
    iter = 0;
    while (true)
        if iter == max_iters
            break;
        end
        parfor i = 1:C
            mu(i, :) = abs(eta-v(i)).^(-2/(m-1));
        end
        mu = mu./ sum(mu);
        vo = v;
        parfor i=1:C
            f = (mu(i, :).^m);
            g = f .* eta;
            v(i) = sum(g) / sum(f);
        end
        if abs(v - vo) < epsilon
           break;
        end
        
        iter = iter + 1;
    end
end


