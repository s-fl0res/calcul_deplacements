// Ici on regarde les types de chargements pour définir le vecteur R
// On utilise la formule R = sum_{n=1:E} Cn * Rn

R_st_th = zeros(3*N,1);
for n=1:E
    // Initialisation des rn
    rni = zeros(3,1);
    rnj = rni;
    l = ij(n,2) - ij(n,1);
    for i_chargement = 1:3
        select tch(n,i_chargement)
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
                rni = rni + [Young(n)*S(n)*ich(n,ichargement);0;0];
                rnj = rnj + [-Young(n)*S(n)*ich(n,ichargement);0;0];
            case "T2" then
                rni = rni + [0;0;-Young(n)*J(n)*ich(n,ichargement)];
                rnj = rnj + [0;0;Young(n)*J(n)*ich(n,ichargement)];
        end
    end
    // Construction de qn
    // Construction de Cni et Cnj
    Rni = qn' * rni;
    Rnj = qn' * rnj;
    R_st_th = R_st_th + Cni'*Rni +Cnj'*Rnj;
end
