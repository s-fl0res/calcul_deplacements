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
clear all
xdel(winsid())
exec("syst_elementaire/10_noeuds.sce");           // Chargement noeuds
exec("syst_elementaire/20_elements.sce");         // Chargement elements
exec("30_matrice_de_raideur.sce");     // Calcul matrice de raideur
K_ana =     [2,0,0,-2,0,0,0,0,0;
             0,96,24,0,-96,24,0,0,0;
             0,24,8,0,-24,4,0,0,0;
             -2,0,0,4,0,0,-2,0,0;
             0,-96,-24,0,192,0,0,-96,24;
             0,24,4,0,0,16,0,-24,4;
             0,0,0,-2,0,0,2,0,0;
             0,0,0,0,-96,-24,0,96,-24;
             0,0,0,0,24,4,0,-24,8];
disp(isequal(K,K_ana))
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
Ktilde_ana =    [4,0,0;
                 0,192,0;
                 0,0,16];
Ktilde = L'*K*L;
disp(isequal(Ktilde,Ktilde_ana))
disp(isequal(L,L_ana))
exec("syst_elementaire/50_conditions_de_chargement.sce"); // Définition des conditions de chargement
exec("60_systemes_de_chargement.sce"); // Définition du vecteur R_st_th
R_ana =[-1/4;
        0;
        0;
        -1/2;
        0;
        0;
        -1/4;
        0;
        0];
disp(isequal(R_st_th,R_ana))
exec("70_resolution.sce"); // Résolution de la structure
D_ana = [0;
         0;
         0;
         1/8;
         0;
         0;
         0;
         0;
         0];
disp(isequal(D_sol,D_ana))
exec("80_efforts_interieurs.sce");//Calcul des efforts intérieurs à partir des déplacements solution
exec("85_deplacements.sce");
fact_deplacements = 1;
fact_diagrammes = 0.5;
exec("90_diagrammes.sce");
exec("95_deformee.sce");
