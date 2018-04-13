function m = mape( testY, pred)
    err = abs(pred - testY);
    m = mean(abs(err / testY));
end

