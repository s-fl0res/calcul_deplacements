// SCRIPT DE DISCRÉTISATION SOLLICITATION B
// Pour tester une nouvelle structure, svp créer un nouveau dossier avec
// seulement les fichiers :
//
// * 10_noeuds.sce
// * 20_elements.sce
// * 50_conditions_de_chargement.sce
//
// et dans le script ne modifier que le chemin d'accès à ces fichiers
// Comme ça, une fois testé, tout autre fichier essentiel à la resolution
// peut rester tranquillement inchangé dans le dossier principal.

format("e",10)
clear all
close(winsid())
exec("10_noeuds.sce");           // Chargement noeuds
exec("20_elements.sce");         // Chargement elements
exec("30_matrice_de_raideur.sce");     // Calcul matrice de raideur
exec("40_matrice_des_liaisons.sce");    // Calcul de la matrice de liaison
exec("sollicitation_B/50_conditions_de_chargement.sce"); // Définition des conditions de chargement
exec("60_systemes_de_chargement.sce"); // Définition du vecteur R_st_th
exec("70_resolution.sce"); // Résolution de la structure
exec("80_efforts_interieurs.sce");//Calcul des efforts intérieurs à partir des déplacements solution
exec("85_deplacements.sce");
fact_deplacements = 10^2;
fact_diagrammes = 1;
exec("90_diagrammes.sce");
exec("95_deformee.sce");
