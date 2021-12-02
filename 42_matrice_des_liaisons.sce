
N = size(x,1);
L = zeros(3*N,3*(N-sum(liaison)));
k = 1;
for n2 = 1:N
    if liaison(n2) == 0
        L(3*n2-2:3*n2,3*k-2:3*k) = (1-liaison(n2))*eye(3,3);
    end
    k = k + 1 - liaison(n2) ;
end
