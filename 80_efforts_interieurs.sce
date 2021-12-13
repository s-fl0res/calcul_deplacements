// Script de calcul des efforts intérieurs à partir des déplacements solution
// On se place dans 5 sections dans la poutre
// On calcule la contribution des déplacements puis du chargement


//Ouverture du fichier resultats.txt
[fd,err] = mopen("efforts_interieurs.txt","w");
for n=1:E
    i = ij(n,1);
    j = ij(n,2);
    // Calcul de l    
    l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
    // Construction des variables Cni et Cnj
    Cni = zeros(3,3*N);
    Cni(:,3*i-2:3*i) = eye(3,3);
    Cnj = zeros(3,3*N);
    Cnj(:,3*j-2:3*j) = eye(3,3);
    qn = [(x(j,1) - x(i,1))/l , (x(j,2) - x(i,2))/l, 0;
      -(x(j,2) - x(i,2))/l, (x(j,1) - x(i,1))/l, 0;
      0,                   0,                    1];
    Dni = Cni * D_sol;
    Dnj = Cnj * D_sol;
    dni = qn * Dni;
    dnj = qn * Dnj;
    // Construction des variables knii et knij
    Knii = Cni * K * Cni';
    Knij = Cni * K * Cnj';
    knii = qn' * Knii * qn;
    knij = qn' * Knij * qn;
    // rni = knii * dni + knij * dnj + rni_charge1 + rni_charge2 + rni_charge3
    rni = knii * dni;
    // Au noeud : seul les deux premieres composantes contribuent.
    s = [0,l/4,l/2,3*l/4,l];
    // Contribution des déplacements
    for i_s = 1:5
        eff_norm(i_s) = rni(1);
        eff_tran(i_s) = rni(2);
        mom_flech(i_s) = rni(3) - rni(2)*s(i_s);
    end
    for ichargement=1:3
        P = ich(n,ichargement);
        a = ech(n,ichargement);
        select tch(n,ichargement)
        case "C1" then
            for i_s = 1:5
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) - P * s(i_s);//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + P * s(i_s)^2/2 - eff_tran(1) * s(i_s); //fct de ich et ech
            end
        case "C2" then
            for i_s = 1:5
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) - P *(s(i_s)>=a);//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + P * (s(i_s) - a) * (s(i_s) >=a);//fct de ich et ech
            end
        case "C3" then
            for i_s = 1:5
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0; //fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) - eff_tran(1) * s(i_s) + (s(i_s) >= a) * P;//fct de ich et ech
            end
        case "C4" then
            for i_s = 1:5
                eff_norm(i_s) = eff_norm(i_s) - P*s(i_s);// fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0 ;
                mom_flech(i_s) = mom_flech(i_s) + 0;
            end
        case "C5" then
            for i_s = 1:5
                eff_norm(i_s) = eff_norm(i_s) - (s(i_s) >= a) * P;// fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0;//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + 0;//fct de ich et ech
            end
        case "T1" then
            for i_s = 1:5
                eff_norm(i_s) = eff_norm(i_s) - 2*s(i_s)/l *Young(n)*S(n) * alpha(n) * P;// fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0;//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + 0;//fct de ich et ech
            end
        case "T2" then
            for i_s = 1:5
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0; //fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) - 2*s(i_s)*J(n)*alpha(n); //fct de ich et ech
            end
        end
    // Ecrire effort normal, effort tranchant, mom_flech, sur l'élément en sorite dans "resultats.txt"
    mfprintf(fd,"element %i \n", n);
    write(fd,"0\t L/4 \t L/2 \t 3L/4 \t L\n");
    write(fd,eff_norm);
    write(fd,eff_tran);
    write(fd,mom_flech);
    mclose(fd);
    end
end
