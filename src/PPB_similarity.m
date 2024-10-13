function [Sip] = PPB_similarity(Y, i, p, s)
    [R, ~] = size(Y);
    im = padarray(Y, [s s], 0, 'both');
    xi = mod(i, R);
    yi = floor(i/R);
    xp = mod(p, R);
    yp = floor(p/R);
    Ai = im(xi+1:xi+2*s+1, yi+1:yi+2*s+1);
    Ap = im(xp+1:xp+2*s+1, yp+1:yp+2*s+1);
    Ai(Ai == 0) = 1;
    Ap(Ap == 0) = 1;
    l = log(Ai./Ap + Ap./Ai);
    Sip = sum(l(:));
end




