clear ij, clear S, clear Young, clear J

//initialisations
n = 0;
E = 1;
S = 1;
Ji = 1;
alph = 1;

//element 1 (poteau 0.3x0.3 m2)
n = n + 1;
ij(n,:) = [1,2];
S(n) = S;
Young(n) = E;
J(n) = Ji;
alpha(n) = alph;
//element 2 (poteau 0.3x0.3 m2)
n = n + 1;
ij(n,:) = [2,3];
S(n) = S;
Young(n) = E;
J(n) = Ji;
alpha(n) = alph;
clear n,clear E,clear Ji
