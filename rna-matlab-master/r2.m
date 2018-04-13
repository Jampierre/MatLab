function r2 = r2( actual, pred )
    c = corrcoef([actual' pred']);
    r = c(1,2);
    r2 = r^2;
end

