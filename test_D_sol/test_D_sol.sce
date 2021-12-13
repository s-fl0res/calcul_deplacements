



exec("11_noeuds.sce");           // Chargement noeuds
exec("21_elements.sce");         // Chargement elements
exec("../30_matrice_de_raideur.sce");     // Calcul matrice de raideur
exec("../41_matrice_des_liaisons.sce");    // Calcul de la matrice de liaison (fichier 41 car le 40 ne marchait pas)
exec("51_conditions_de_chargment.sce"); // Définition des conditions de chargement
exec("../60_systemes_de_chargement.sce"); // Définition du vecteur R
exec("../70_resolution.sce"); // Résolution de la structure

KtNum = [12*E*J(1)/l^3 + E*S(1)/Ldimension , 0 , 6*E*J(1)/l^2 ; 0 , E*S(1)/l + 12*E*J(1)/Ldimension^3 , 6*E*J(1)/Ldimension^2 ; 6*E*J(1)/Ldimension^2 , 6*E*J(1)/Ldimension^2 , 4*E*J(1)/l + 4*E*J(1)/Ldimension];

RtNum = [0 ; Q*(Ldimension^3-3*Ldimension*a+2*a^3)/Ldimension^3 ; Q*a*(Ldimension-a)*(Ldimension-a)/Ldimension^2];

D_solNum = - inv(KtNum)*RtNum




