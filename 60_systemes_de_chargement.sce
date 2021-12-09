// Ici on regarde les types de chargements pour définir le vecteur R
// On utilise la formule R = sum_{n=1:E} Cn * Rn

R_st_th = zeros(3*N,1);
for n=1:E
    // Initialisation des rn
    rni = zeros(3,1);
    rnj = rni;
    for i_chargement = 1:3
        select tch(n,i_chargement)
            case "C1" then
                rni = rni + [0; ich(n,ichargement)*(ij(n,2) - ij(n,1)) / 2; ich(n,ichargement)*(ij(n,2) - ij(n,1))^2 / 12]; 
                rnj = rnj + [0; ich(n,ichargement)*(ij(n,2) - ij(n,1)) / 2; -ich(n,ichargement)*(ij(n,2) - ij(n,1))^2 / 12]
            case "C2" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "C2"
                rnj = rnj + 
            case "C3" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "C3"
                rnj = rnj +
            case "C4" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "C4"
                rnj = rnj +
            case "C5" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "C5"
                rnj = rnj +
            case "C6" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "C6"
                rnj = rnj +
            case "T1" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "T1"
                rnj = rnj +
            case "T2" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "T2"
                rnj = rnj +
            case "T3" then
                rni = rni + // fonction des varibles ich et ech, correspondant au cas "T3"
                rnj = rnj +
        end
    end
    // Construction de qn
    // Construction de Cni et Cnj
    Rni = qn' * rni;
    Rnj = qn' * rnj;
    R_st_th = R_st_th + Cni'*Rni +Cnj'*Rnj;
end
