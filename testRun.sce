// SCRIPT DE TEST POUR LA ROUTINE DE DISCRÉTISATION
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
exec("syst_elementaire/10_noeuds.sce");           // Chargement noeuds
exec("syst_elementaire/20_elements.sce");         // Chargement elements
exec("30_matrice_de_raideur.sce");     // Calcul matrice de raideur
K_ana =     [1,0,0,-1,0,0,0,0,0;
             0,12,6,0,-12,6,0,0,0;
             0,6,4,0,-6,2,0,0,0;
             -1,0,0,2,0,0,-1,0,0;
             0,-12,-6,0,24,0,0,-12,6;
             0,6,2,0,0,8,0,-6,2;
             0,0,0,-1,0,0,1,0,0;
             0,0,0,0,-12,-6,0,12,-6;
             0,0,0,0,6,2,0,-6,4];
exec("40_matrice_des_liaisons.sce");    // Calcul de la matrice de liaison
L_ana = [0,0,0;
        0,0,0;
        0,0,0;
        1,0,0;
        0,1,0;
        0,0,1;
        0,0,0;
        0,0,0;
        0,0,0];
Ktilde_ana =    [2,0,0;
                 0,24,0;
                 0,0,8];
Ktilde = L'*K*L;
exec("syst_elementaire/50_conditions_de_chargement.sce"); // Définition des conditions de chargement
exec("60_systemes_de_chargement.sce"); // Définition du vecteur R_st_th
R_ana =[0;
        1/2;
        1/12;
        0;
        1;
        0;
        0;
        1/2;
        -1/12]; 
exec("70_resolution.sce"); // Résolution de la structure
D_ana = [0;
         0;
         0;
         0;
         -1/24;
         0;
         0;
         0;
         0];
exec("80_efforts_interieurs.sce");//Calcul des efforts intérieurs à partir des déplacements solution
//exec("85_deplacements.sce");
