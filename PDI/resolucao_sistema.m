x(n) = b(n)/A(n,n);
for k = (n - 1): 1
    s = 0;
    for j = (k + 1):n
        s = s + A(k,j)*x(j);
        x(k) = (b(k) - s)/a(k,k);
    end
end