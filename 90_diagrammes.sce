// clear sur les diagrammes
clear eff_norm, clear eff_tran, clear mom_flech, clear graph
ma = 0;
somme = 0;
for inc = 1:E
    i = ij(inc,1);
    j = ij(inc,2);
    l = sqrt((x(j,1)-x(i,1))^2 + (x(j,2)-x(i,2))^2);
    somme = somme + l;
    
    coor_x = [x(i,1), x(j,1)]
    coor_y = [x(i,2), x(j,2)]
    
    ma=max(x(i,1), x(j,1),x(i,2), x(j,2),ma)
    
    plot(coor_x, coor_y);
    xstring((x(i,1)+ x(j,1))/2,(x(i,2)+ x(j,2))/2,string(inc),0,1)
end


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
    knii = Young(n)/l^3* [S(n)*l^2, 0,        0;
                          0,        12*J(n),  6*J(n)*l;
                          0,        6*J(n)*l,   4*J(n)*l^2];
    knij = Young(n)/l^3* [-S(n)*l^2, 0,        0;
                          0,        -12*J(n),  6*J(n)*l;
                          0,        -6*J(n)*l,   2*J(n)*l^2]; 
    // rni = knii * dni + knij * dnj + rni_charge1 + rni_charge2 + rni_charge3
    rni = knii * dni + knij * dnj;
    //rnj = knji * dni + knjj * dnj;
    for ichargement = 1:3
        select tch(n,ichargement)
            case "C1" then
                rni = rni + [0; ich(n,ichargement)*l / 2; ich(n,ichargement)*l^2 / 12];
                //rnj = rnj + [0; ich(n,ichargement)*l / 2; -ich(n,ichargement)*l^2 / 12];
            case "C2" then
                rni = rni + [0; ich(n,ichargement)/l^3 * (l^3 - 3*l*ech(n,ichargement)^2 + 2*ech(n,ichargement)^3); ich(n,ichargement)/l^2 * ech(n,ichargement)*(l-ech(n,ichargement))^2];
            case "C3" then
                rni = rni + [0; 6*ich(n,ichargement) * ech(n,ichargement)*(l- ech(n,ichargement))/l^3; ich(n,ichargement)/l^2 * (ech(n,ichargement)-l)*(l-3*ech(n,ichargement))];
            case "C4" then
                rni = rni + [-ich(n,ichargement)*l/2; 0; 0];
            case "C5" then
                rni = rni + [-ich(n,ichargement)/l*(l-ech(n,ichargement)); 0; 0];
            case "T1" then
                rni = rni + [Young(n)*S(n)*alpha(n)*ich(n,ichargement);0;0];
            case "T2" then
                rni = rni + [0;0;-Young(n)*J(n)*alpha(n)*ich(n,ichargement)];
        end
    end
    // Au noeud : seul les deux premieres composantes contribuent.
    s = linspace(0,l,100);
    // Contribution des déplacements
    for i_s = 1:100
        eff_norm(i_s) = rni(1);
        eff_tran(i_s) = rni(2);
        mom_flech(i_s) = rni(3) - rni(2) * s(i_s);
    end
    for ichargement=1:3
        P = ich(n,ichargement);
        a = ech(n,ichargement);
        select tch(n,ichargement)
        case "C1" then
            for i_s = 1:100
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) - P * s(i_s);//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + P * s(i_s)^2/2 ; //fct de ich et ech
            end
        case "C2" then
            for i_s = 1:100
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) - P *(s(i_s)>=a);//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + P * (s(i_s) - a) * (s(i_s) >=a);//fct de ich et ech
            end
        case "C3" then
            for i_s = 1:100
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0; //fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + (s(i_s) >= a) * P;//fct de ich et ech
            end
        case "C4" then
            for i_s = 1:100
                eff_norm(i_s) = eff_norm(i_s) + P*s(i_s);// fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0 ;
                mom_flech(i_s) = mom_flech(i_s) + 0;
            end
        case "C5" then
            for i_s = 1:100
                eff_norm(i_s) = eff_norm(i_s) - (s(i_s) >= a) * P;// fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0;//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + 0;//fct de ich et ech
            end
        case "T1" then
            for i_s = 1:100
                eff_norm(i_s) = eff_norm(i_s) - 2*s(i_s)/l *Young(n)*S(n) * alpha(n) * P;// fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0;//fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) + 0;//fct de ich et ech
            end
        case "T2" then
            for i_s = 1:100
                eff_norm(i_s) = eff_norm(i_s) + 0; // fct de ich et ech
                eff_tran(i_s) = eff_tran(i_s) + 0; //fct de ich et ech
                mom_flech(i_s) = mom_flech(i_s) - 2*s*P*Young(n)*J(n)*alpha(n); //fct de ich et ech
            end
        end
    end
    graph = [s;eff_norm'];
    plot(graph(1,:) + x(i,1),graph(2,:) + x(i,2))
    
    // Au moment de l'affichage, il faut définir l'échelle. max() sur toute la
    // structure par exemple. 
    
end
