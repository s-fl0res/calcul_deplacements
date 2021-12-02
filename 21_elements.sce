clear ij, clear S, clear Young, clear J

//initialisations
n = 0;
E = 1;
S = 1;
J = 1;

//element 1 (poteau 0.3x0.3 m2)
n = n + 1;
ij(n,:) = [1,2];
S(n) = S;
Young(n) = E;
J(n) = J;

//element 2 (poteau 0.3x0.3 m2)
n = n + 1;
ij(n,:) = [2,3];
S(n) = S;
Young(n) = E;
J(n) = J;
