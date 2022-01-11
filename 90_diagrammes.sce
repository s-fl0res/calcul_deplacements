// clear sur les diagrammes
clear eff_norm, clear eff_tran, clear mom_flech
format("v",10)
n = size(liaison,1);
m = size(ij,1);
ma = 0;
somme = 0;

fig_eff_norm = scf(1);
title("Diagramme effort normal");
fig_eff_tran = scf(2);
title("Diagramme effort tranchant");
fig_mom_flech = scf(3);
title("Diagramme moment fléchissant")

//Affichage des membrures

for inc = 1:m
    i = ij(inc,1);
    j = ij(inc,2);
    l = sqrt((x(j,1)-x(i,1))^2 + (x(j,2)-x(i,2))^2);
    somme = somme + l;
    
    coor_x = [x(i,1), x(j,1)];
    coor_y = [x(i,2), x(j,2)];
    
    ma=max(x(i,1), x(j,1),x(i,2), x(j,2),ma);
    for fig=[fig_eff_norm,fig_eff_tran,fig_mom_flech]
        scf(fig);
        plot(coor_x, coor_y,'k--');
        xstring((x(i,1)+ x(j,1))/2,(x(i,2)+ x(j,2))/2,string(inc),0,1)
    end
end

dim_app = somme /(m * 20);
//plot2d(ma+dim_app,ma+dim_app)

//Affichage des appuis fixes, A CORRIGER
for inc = 1 : n
    for fig=[fig_eff_norm,fig_eff_tran,fig_mom_flech]
        scf(fig);
        if liaison(inc) == 1 then
            xfrect(x(inc,1)-dim_app, x(inc,2)+dim_app, 2*dim_app, 2*dim_app);
            gce().background = color("red");
        end
            xstring(x(inc,1)-2*dim_app,x(inc,2)+dim_app,string(inc));
    end
end

g = gca();
g.axes_visible="off";
eff_norm = zeros(100,E);
eff_tran = eff_norm;
mom_flech = eff_norm;
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
        eff_norm(i_s,n) = rni(1);
        eff_tran(i_s,n) = rni(2);
        mom_flech(i_s,n) = rni(3) - rni(2) * s(i_s);
    end
    for ichargement=1:3
        P = ich(n,ichargement);
        a = ech(n,ichargement);
        select tch(n,ichargement)
        case "C1" then
            for i_s = 1:100
                eff_norm(i_s,n) = eff_norm(i_s,n) + 0; // fct de ich et ech
                eff_tran(i_s,n) = eff_tran(i_s,n) - P * s(i_s);//fct de ich et ech
                mom_flech(i_s,n) = mom_flech(i_s,n) + P * s(i_s)^2/2 ; //fct de ich et ech
            end
        case "C2" then
            for i_s = 1:100
                eff_norm(i_s,n) = eff_norm(i_s,n) + 0; // fct de ich et ech
                eff_tran(i_s,n) = eff_tran(i_s,n) - P *(s(i_s)>=a);//fct de ich et ech
                mom_flech(i_s,n) = mom_flech(i_s,n) + P * (s(i_s) - a) * (s(i_s) >=a);//fct de ich et ech
            end
        case "C3" then
            for i_s = 1:100
                eff_norm(i_s,n) = eff_norm(i_s,n) + 0; // fct de ich et ech
                eff_tran(i_s,n) = eff_tran(i_s,n) + 0; //fct de ich et ech
                mom_flech(i_s,n) = mom_flech(i_s,n) + (s(i_s) >= a) * P;//fct de ich et ech
            end
        case "C4" then
            for i_s = 1:100
                eff_norm(i_s,n) = eff_norm(i_s,n) + P*s(i_s);// fct de ich et ech
                eff_tran(i_s,n) = eff_tran(i_s,n) + 0 ;
                mom_flech(i_s,n) = mom_flech(i_s,n) + 0;
            end
        case "C5" then
            for i_s = 1:100
                eff_norm(i_s,n) = eff_norm(i_s,n) - (s(i_s) >= a) * P;// fct de ich et ech
                eff_tran(i_s,n) = eff_tran(i_s,n) + 0;//fct de ich et ech
                mom_flech(i_s,n) = mom_flech(i_s,n) + 0;//fct de ich et ech
            end
        case "T1" then 
            for i_s = 1:100
                eff_norm(i_s,n) = eff_norm(i_s,n) + 0;// fct de ich et ech
                eff_tran(i_s,n) = eff_tran(i_s,n) + 0;//fct de ich et ech
                mom_flech(i_s,n) = mom_flech(i_s,n) + 0;//fct de ich et ech
            end
        case "T2" then
            for i_s = 1:100
                eff_norm(i_s,n) = eff_norm(i_s,n) + 0; // fct de ich et ech
                eff_tran(i_s,n) = eff_tran(i_s,n) + 0; //fct de ich et ech
                mom_flech(i_s,n) = mom_flech(i_s,n) - 2*s*P*Young(n)*J(n)*alpha(n); //fct de ich et ech
            end
        end
    end
end

eff_norm_max = max(abs(eff_norm));
eff_tran_max = max(abs(eff_tran));
mom_flech_max = max(abs(mom_flech));

eff_norm_max = eff_norm_max + 1 * (eff_norm_max == 0)
eff_tran_max = eff_tran_max + 1 * (eff_tran_max == 0)
mom_flech_max = mom_flech_max + 1 * (mom_flech_max == 0)
// Affichage des efforts
for n=1:E
    i = ij(n,1);
    j = ij(n,2);
    // Calcul de l    
    l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
    qn = [(x(j,1) - x(i,1))/l , (x(j,2) - x(i,2))/l, 0;
      -(x(j,2) - x(i,2))/l, (x(j,1) - x(i,1))/l, 0;
      0,                   0,                    1];
    s = linspace(0,l,100);
    scf(fig_eff_norm);
    graph = qn(1:2,1:2)'*[s;eff_norm(:,n)'/eff_norm_max*fact_diagrammes];
    plot(graph(1,:) + x(i,1),graph(2,:) + x(i,2));
    g = gca();
    g.isoview = "on";
    g.tight_limits = "off";
    g.margins = [0.125 0.125 0.125 0.125];
    g.data_bounds = [min(g.data_bounds(1,:)),min(g.data_bounds(1,:));max(g.data_bounds(2,:)),max(g.data_bounds(2,:))];    
    scf(fig_eff_tran);
    graph = qn(1:2,1:2)'*[s;eff_tran(:,n)'/eff_tran_max*fact_diagrammes];
    plot(graph(1,:) + x(i,1),graph(2,:) + x(i,2));
    g = gca();
    g.isoview = "on";
    g.tight_limits = "off";
    g.margins = [0.125 0.125 0.125 0.125];
    g.data_bounds = [min(g.data_bounds(1,:)),min(g.data_bounds(1,:));max(g.data_bounds(2,:)),max(g.data_bounds(2,:))];
    scf(fig_mom_flech);
    graph = qn(1:2,1:2)'*[s;mom_flech(:,n)'/mom_flech_max*fact_diagrammes];
    plot(graph(1,:) + x(i,1),graph(2,:) + x(i,2));
    g = gca();
    g.isoview = "on";
    g.tight_limits = "off";
    g.margins = [0.125 0.125 0.125 0.125];
    g.data_bounds = [min(g.data_bounds(1,:)),min(g.data_bounds(1,:));max(g.data_bounds(2,:)),max(g.data_bounds(2,:))];
end
