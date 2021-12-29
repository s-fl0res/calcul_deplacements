
exec("10_noeuds.sce");           // Chargement noeuds
exec("20_elements.sce");         // Chargement elements
exec("../30_matrice_de_raideur.sce");     // Calcul matrice de raideur
exec("../40_matrice_des_liaisons.sce");    // Calcul de la matrice de liaison (fichier 41 car le 40 ne marchait pas)
exec("50_conditions_de_chargment.sce"); // Définition des conditions de chargement
exec("../60_systemes_de_chargement.sce"); // Définition du vecteur R
exec("../70_resolution.sce"); // Résolution de la structure

// 3 problèmes :

// KtNum = 2*Ktilde

// RtNum(2) = Rtilde_st_th(2)/2

// RtNum(3) = -Rtilde_st_th(3) 



KtNum = [12*YoungU*J(1)/l^3 + YoungU*S(1)/Ldimension , 0 , 6*YoungU*J(1)/l^2 ; 0 , YoungU*S(1)/l + 12*YoungU*J(1)/Ldimension^3 , 6*YoungU*J(1)/Ldimension^2 ; 6*YoungU*J(1)/Ldimension^2 , 6*YoungU*J(1)/Ldimension^2 , 4*YoungU*J(1)/l + 4*YoungU*J(1)/Ldimension];

RtNum = [0 ; Q*(Ldimension^3-3*Ldimension*a^2+2*a^3)/Ldimension^3 ; Q*a*(Ldimension-a)*(Ldimension-a)/Ldimension^2];

D_soltNum = - inv(KtNum)*RtNum;
D_solNum = L*D_soltNum;

disp("Ktilde exercie 1 :")
disp(KtNum)

disp("Ktilde calculé :")
disp(L'*K*L)

disp("Rtilde exercice 1 :")
disp(RtNum)

disp("Rtilde calculé : ")
disp(L' * R_st_th)


disp("D_solNum exercice 1 :")
disp(D_solNum(4:6))

disp("D_sol calculé :")
disp(D_sol(4:6))

disp("Différence en % vis-à-vis de D_solNum")
disp(abs(D_solNum(4:6) - D_sol(4:6)).*100./D_solNum(4:6))




