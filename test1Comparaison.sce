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
exec("41_matrice_des_liaisons.sce");

norm(K-K_ana)

K_tilde_verif = K_ana(4:6,4:6);
K_tilde = L'*K*L;

norm(K_tilde - K_tilde_verif)
