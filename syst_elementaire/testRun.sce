clear all

exec("11_noeuds.sce");           // Chargement noeuds, spécifique au test
exec("21_elements.sce");         // Chargement elements, spécifique au test
exec("30_matrice_de_raideur.sce");     // Calcul matrice de raideur
exec("41_matrice_des_liaisons.sce");    // Calcul de la matrice de liaison (fichier 41 car le 40 ne marchait pas)
exec("51_conditions_de_chargment.sce"); // Définition des conditions de chargement, spécifique au test
exec("60_systemes_de_chargement.sce"); // Définition du vecteur R
exec("70_resolution.sce"); // Résolution de la structure
exec("80_efforts_interieurs.sce");//Calcul des efforts intérieurs à partir des déplacements solution

