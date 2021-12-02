clear K, clear K_ana

// Calcul de N et E
N = size(x,1);
E = size(ij,1);

// Initialisation K
K = zeros(3*N,3*N);
K_ana = zeros(3*N,3*N);

// Boucle sur les éléments
for n = 1:E
    // Obtention des données de l'élément
    i = ij(n,1);
    j = ij(n,2);
    l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
    // Construction matrices de connectivité
    Cni = zeros(3,3*N);
    Cni(:,3*i-2:3*i) = eye(3,3);
    Cnj = zeros(3,3*N);
    Cnj(:,3*j-2:3*j) = eye(3,3);
    qn = [(x(j,1) - x(i,1))/l , (x(j,2) - x(i,2))/l, 0;
          -(x(j,2) - x(i,2))/l, (x(j,1) - x(i,1))/l, 0;
          0,                   0,                    1];
    knii = Young(n)/l^3* [S(n)*l^2, 0,        0;
                          0,        12*J(n),  6*J(n)*l;
                          0,        6*J(n)*l,   4*J(n)*l^2];
    knij = Young(n)/l^3* [-S(n)*l^2, 0,        0;
                          0,        -12*J(n),  6*J(n)*l;
                          0,        -6*J(n)*l,   2*J(n)*l^2]; 
    knjj = Young(n)/l^3* [S(n)*l^2, 0,        0;
                          0,        12*J(n),  -6*J(n)*l;
                          0,        -6*J(n)*l,   4*J(n)*l^2];
    Knii = qn'*knii*qn ;
    Knij = qn'*knij*qn;
    Knji = Knij';
    Knjj = qn'*knjj*qn;
    K = K + Cni' * Knii * Cni + Cni' * Knij * Cnj + Cnj' * Knji * Cni + Cnj' * Knjj *Cnj;

    K_ana(1+3*(i-1):3*(i),1+3*(i-1):3*(i)) = K_ana(1+3*(i-1):3*(i),1+3*(i-1):3*(i)) + Knii;
    K_ana(1+3*(j-1):3*(j),1+3*(i-1):3*(i)) =  K_ana(1+3*(j-1):3*(j),1+3*(i-1):3*(i)) + Knji;
    K_ana(1+3*(i-1):3*(i),1+3*(j-1):3*(j)) = K_ana(1+3*(i-1):3*(i),1+3*(j-1):3*(j)) + Knij;
    K_ana(1+3*(j-1):3*(j),1+3*(j-1):3*(j)) = K_ana(1+3*(j-1):3*(j),1+3*(j-1):3*(j)) + Knjj;
end

clear N, clear E, clear i, clear j, clear Cni, clear Cnj, clear qn, clear knii, clear knij, clear knji, clear knjj
