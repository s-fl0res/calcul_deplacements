// Ici on regarde les types de chargements pour définir le vecteur R
// On utilise la formule R = sum_{n=1:E} Cn * Rn
clear Rn_st_th

R_st_th = zeros(3*N,1);
for n=1:E
    // Initialisation des rn
    rni = zeros(3,1);
    rnj = rni;
    // Calcul de l
    i = ij(n,1);
    j = ij(n,2);
    l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
    for ichargement = 1:3
        select tch(n,ichargement)
            case "C1" then
                rni = rni + [0; ich(n,ichargement)*l / 2; ich(n,ichargement)*l^2 / 12]; 
                rnj = rnj + [0; ich(n,ichargement)*l / 2; -ich(n,ichargement)*l^2 / 12];
            case "C2" then
                rni = rni + [0; ich(n,ichargement)/l^3 * (l^3 - 3*l*ech(n,ichargement)^2 + 2*ech(n,ichargement)^3); ich(n,ichargement)/l^2 * ech(n,ichargement)*(l-ech(n,ichargement))^2];
                rnj = rnj + [0; ich(n,ichargement)/l^3 * (l^3 - 3*l*ech(n,ichargement)^2 + 2*ech(n,ichargement)^3); -ich(n,ichargement)/l^2 * ech(n,ichargement)*(l-ech(n,ichargement))^2];
            case "C3" then
                rni = rni + [0; 6*ich(n,ichargement) * ech(n,ichargement)*(l- ech(n,ichargement))/l^3; ich(n,ichargement)/l^2 * (ech(n,ichargement)-l)*(l-3*ech(n,ichargement))];
                rnj = rnj +[0; -6*ich(n,ichargement) * ech(n,ichargement)*(l- ech(n,ichargement))/l^3; ich(n,ichargement)/l^2 * (ech(n,ichargement)-l)*(l-3*ech(n,ichargement))];
            case "C4" then
                rni = rni + [-ich(n,ichargement)*l/2; 0; 0];
                rnj = rnj + [-ich(n,ichargement)*l/2; 0; 0];
            case "C5" then
                rni = rni + [-ich(n,ichargement)/l*(l-ech(n,ichargement)); 0; 0];
                rnj = rnj + [-ich(n,ichargement)/l*(ech(n,ichargement)); 0; 0];
            case "T1" then
                rni = rni + [Young(n)*S(n)*alpha(n)*ich(n,ichargement);0;0];
                rnj = rnj + [-Young(n)*S(n)*alpha(n)*ich(n,ichargement);0;0];
            case "T2" then
                rni = rni + [0;0;-Young(n)*J(n)*alpha(n)*ich(n,ichargement)];
                rnj = rnj + [0;0;Young(n)*J(n)*alpha(n)*ich(n,ichargement)];
        end
    end
    // Construction de qn
    qn = [(x(j,1) - x(i,1))/l , (x(j,2) - x(i,2))/l, 0;
          -(x(j,2) - x(i,2))/l, (x(j,1) - x(i,1))/l, 0;
          0,                   0,                    1];
    // Construction de Cni et Cnj
    Cni = zeros(3,3*N);
    Cni(:,3*i-2:3*i) = eye(3,3);
    Cnj = zeros(3,3*N);
    Cnj(:,3*j-2:3*j) = eye(3,3);
    Rni = qn' * rni;
    Rnj = qn' * rnj;
    R_st_th = R_st_th + Cni'*Rni +Cnj'*Rnj;
end

clear l,clear i,clear j, clear qn, clear Cni, clear Cnj, clear Rni, clear Rnj, clear rni, clear rnj
