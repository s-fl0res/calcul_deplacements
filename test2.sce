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
exec("42_matrice_des_liaisons.sce");    // Calcul matrice des liaisons
exec("50_conditions_de_chargement.sce"); // Conditions de chargement de la structure
exec("60_systemes_de_chargement.sce");   // Calcul des efforts de la structure
exec("70_systemes_de_chargement.sce");   // Resolution de la structure

//// Matrices de connectivité
//N = size(x,1);
//C33 = zeros(3,3*N);
//C33(:,3*3-2:3*3) = eye(3,3);
//C35 = zeros(3,3*N);
//C35(:,3*5-2:3*5) = eye(3,3);
//
//// Bloc 3-3
//K33 = C33*K*C33'
//
//// Bloc 3-5
//K35 = C33*K*C35'
//
//// Bloc 5-3
//K53 = C35*K*C33'
//
//// Bloc 5-5
//K55 = C35*K*C35'
//
//K_tilde = L' * K * L;
//
//K_tilde_verif = K_ana(13:15,13:15)

norm(K_tilde - K_tilde_verif)
