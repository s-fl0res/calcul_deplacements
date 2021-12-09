clear ij, clear S, clear Young, clear J,clear alpha

// initialisation
n = 0 

// élément 1 (poteau 0.3 * 0.3 m2)
n = n + 1
ij(n,:) = [1,4]         // noeuds i et j>i de l'élément
S(n) = 0.3 * 0.3        // section de l'élément
Young(n) = 30e9         // module de Young du matériau (béton armé)
J(n) = (0.3 * 0.3 ^ 3)/12   // moment quadratique
alpha(n) = 0.01;        // Coef expansion thermique

// élément 2 (poteau 0.3 * 0.3 m2)
n = n + 1
ij(n,:) = [2,5]
Young(n) = 30e9
S(n) = 0.3 * 0.3
J(n) = (0.3 * 0.3 ^ 3)/12
alpha(n) = 0.01;

// élément 2 (poteau 0.3 * 0.3 m2)
n = n + 1
ij(n,:) = [3,6]
S(n) = 0.3 * 0.3
Young(n) = 30e9
J(n) = (0.3 * 0.3 ^ 3)/12
alpha(n) = 0.01;

// élément 3 (poteau 0.3 * 0.3 m2)
n = n + 1
ij(n,:) = [3,6] 
S(n) = 0.3 * 0.3
Young(n) = 30e9
J(n) = (0.3 * 0.3 ^ 3)/12
alpha(n) = 0.01;

// élément 4 (poteau 0.3 * 0.3 m2)
n = n + 1
ij(n,:) = [4,7] 
S(n) = 0.3 * 0.3
Young(n) = 30e9
J(n) = (0.3 * 0.3 ^ 3)/12
alpha(n) = 0.01;

// élément 5 (poteau 0.3 * 0.3 m2)
n = n + 1
ij(n,:) = [5,8] 
S(n) = 0.3 * 0.3
Young(n) = 30e9
J(n) = (0.3 * 0.3 ^ 3)/12
alpha(n) = 0.01;

// élément 6 (poteau 0.3 * 0.3 m2)
n = n + 1
ij(n,:) = [6,7] 
S(n) = 0.3 * 0.3
Young(n) = 30e9
J(n) = (0.3 * 0.3 ^ 3)/12

// élément 7 (poutre 0.3 * 0.5 m2)
n = n + 1
ij(n,:) = [4,5] 
S(n) = 0.3 * 0.5
Young(n) = 30e9
J(n) = (0.3 * 0.5 ^ 3)/12
alpha(n) = 0.01;

// élément 8 (poutre 0.3 * 0.5 m2)
n = n + 1
ij(n,:) = [5,6] 
S(n) = 0.3 * 0.5
Young(n) = 30e9
J(n) = (0.3 * 0.5 ^ 3)/12
alpha(n) = 0.01;

// élément 9 (poutre 0.3 * 0.5 m2)
n = n + 1
ij(n,:) = [7,8] 
S(n) = 0.3 * 0.5
Young(n) = 30e9
J(n) = (0.3 * 0.5 ^ 3)/12
alpha(n) = 0.01;

// élément 10 (poutre 0.3 * 0.5 m2)
n = n + 1
ij(n,:) = [8,9] 
S(n) = 0.3 * 0.5
Young(n) = 30e9
J(n) = (0.3 * 0.5 ^ 3)/12
alpha(n) = 0.01;

clear n
