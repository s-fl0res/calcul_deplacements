exec("10_noeuds.sce");           // Chargement noeuds
exec("20_elements.sce");         // Chargement elements
exec("30_matrice_de_raideur.sce");     // Calcul matrice de raideur
exec("41_matrice_des_liaisons.sce");    // Calcul de la matrice de liaison (fichier 41 car le 40 ne marchait pas)
exec("50_conditions_de_chargement.sce"); // Définition des conditions de chargement
exec("60_systemes_de_chargement.sce"); // Définition du vecteur R
exec("70_resolution.sce"); // Résolution de la structure
exec("80_efforts_interieurs.sce");//Calcul des efforts intérieurs à partir des déplacements solution
exec("85_deplacements.sce");
