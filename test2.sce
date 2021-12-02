// Paramètres
l = 1;
L = 1;
E = 1;
Section = 1;
Moment = 1;

// Calcul de la structure
exec("12_test2_noeuds.sce");           // Chargement noeuds
exec("22_test2_elements.sce");         // Chargement elements
exec("30_matrice_de_raideur.sce");     // Calcul matrice de raideur

// Matrices de connectivité
N = size(x,1);
C33 = zeros(3,3*N);
C33(:,3*3-2:3*3) = eye(3,3);
C35 = zeros(3,3*N);
C35(:,3*5-2:3*5) = eye(3,3);

// Bloc 3-3
K33 = C33*K*C33'
