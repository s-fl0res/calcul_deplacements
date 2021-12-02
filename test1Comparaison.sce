// Paramètres
l = 1;
L = 1;
E = 1;
Section = 1;
Moment = 1;

// Calcul de la structure
exec("11_noeuds.sce");           // Chargement noeuds
exec("21_elements.sce");         // Chargement elements
exec("31_matrice_de_raideur.sce");     // Calcul matrice de raideur

norm(K-K_ana)

