function [eta] = FNLC_eta(Y)
    r = 10;
    s = 2;
    h = 10;
    eta_fgfcm = FGFCM_eta(Y, 3);
    [eta_nl, lambda] = NL_eta(Y, r, h, s);
    eta = (1 - lambda) .* eta_fgfcm + lambda .* eta_nl;
end

