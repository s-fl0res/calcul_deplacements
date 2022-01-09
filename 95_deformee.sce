
clear u, clear v, clear phi

format("v",10)

liaisons = size(liaison,1);
m = size(ij,1);
ma = 0;
somme = 0;

fig_deformee = scf(4);

//Affichage des membrures
for inc = 1:m
    i = ij(inc,1);
    j = ij(inc,2);
    l = sqrt((x(j,1)-x(i,1))^2 + (x(j,2)-x(i,2))^2);
    somme = somme + l;
    
    coor_x = [x(i,1), x(j,1)]
    coor_y = [x(i,2), x(j,2)];
    
    ma=max(x(i,1), x(j,1),x(i,2), x(j,2),ma);
    
    plot(coor_x, coor_y,'k');
    xstring((x(i,1)+ x(j,1))/2,(x(i,2)+ x(j,2))/2,string(inc),0,1);
end


dim_app = somme /(m * 20);
plot2d(ma+dim_app,ma+dim_app);

//Affichage des appuis fixes
for inc = 1 : liaisons
    if liaison(inc) == 1 then
        xfrect(x(inc,1)-dim_app, x(inc,2)+dim_app, 2*dim_app, 2*dim_app);
        gce().background = color("red");
    end
        xstring(x(inc,1)-2*dim_app,x(inc,2)+dim_app,string(inc));
end

g = gca();
g.axes_visible="off";

for n=1:E
    // définition de i et j
    i = ij(n,1);
    j = ij(n,2);
    l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
    
    //construction des Cni, Cnj
    Cni = zeros(3,3*N);
    Cni(:,3*i-2:3*i)=eye(3,3);
    Cnj = zeros(3,3*N);
    Cnj(:,3*j-2:3*j)=eye(3,3);
    qn = [(x(j,1) - x(i,1))/l , (x(j,2) - x(i,2))/l, 0;
            -(x(j,2) - x(i,2))/l, (x(j,1) - x(i,1))/l, 0;
            0,                   0,                    1];
    
    //construction des Dni, Dnj, dni, dnj
    Dni = Cni*D_sol;
    Dnj = Cnj*D_sol;
    dni = qn*Dni;
    dnj = qn*Dnj;
 
    //construction des knii, knij
    knii = Young(n)/(l^3)*[S(n)*l^2, 0, 0
                            0,      12*J(n), 6*J(n)*l
                            0,      6*J(n)*l,  4*J(n)*l^2];//cours partie 2
    knij = Young(n)/(l^3)*[-S(n)*l^2,    0,         0;
                            0,      -12*J(n),   6*J(n)*l;                                                        
                            0,      -6*J(n)*l,  2*J(n)*l^2];//cours partie 2
                            
    //construction de rni
    rni = knii*dni+knij*dnj;

    for i_chargement=1:3
        q = ich(n, i_chargement);
        a = ech(n, i_chargement);
        select tch(n,i_chargement)
            case "C1" then
                rni = rni + [0; q*l/2; q*l^2/12];//fct des variables ich et ech et ech
            case "C2" then //case = if
                rni = rni + [0; q/l^3*(l^3-3*l*a^2+2*a^3); q/l^2*a*(l-a)^2];
            case "C3" then //case = if
                rni = rni + [0; 6*q*a*(l-a)/l^3; q/l^2*(a-l)*(l-3*a)];
            case "C4" then //case = if
                rni = rni + [-q*l/2; 0; 0];
            case "C5" then //case = if
                rni = rni + [-q/l*(l-a); 0; 0];
            case "T1" then //case = if
                rni = rni + [Young(n)*S(n)*alpha(n)*q; 0; 0];
            case "T2" then //case = if
                rni = rni + [0; 0; -Young(n)*J(n)*alpha(n)*q];
        end
    end
        
    // Jusqu'ici, c'est pareil que 85_deplacements.sce
    s = linspace(0,l,100);
    u = zeros(100,1);
    v = zeros(100,1);
    phi = zeros(100,1);
    
    for i_s=1:100
        u(i_s) = dni(1) - rni(1)*s(i_s)/(Young(n)*S(n));
        phi(i_s) = dni(3) - rni(3)*s(i_s)/(Young(n)*J(n)) + rni(2)*s(i_s)^2/(2*Young(n)*J(n));
        v(i_s) = dni(2) + dni(3)*s(i_s) - rni(3)*s(i_s)^2/(2*Young(n)*J(n)) + rni(2)*s(i_s)^3/(6*Young(n)*J(n));
    end
    for i_chargement=1:3
        q = ich(n,i_chargement);
        a = ech(n,i_chargement);
        select tch(n, i_chargement)
            case "C1" then 
                for i_s=1:100
                    u(i_s) = u(i_s);
                    phi(i_s) = phi(i_s) - q*(s(i_s)^3/(6*Young(n)*J(n))) ;
                    v(i_s) = v(i_s) - q*(s(i_s)^4/(24*Young(n)*J(n)));
                end
            case "C2" then // fait
                for i_s=1:100
                    u(i_s) = u(i_s);
                    phi(i_s) = phi(i_s) - q*(s(i_s)-a)^2/(2*Young(n)*J(n))*(s(i_s)>=a);
                    v(i_s) = v(i_s) - q*((s(i_s)-a)^3)/(6*Young(n)*J(n))*(s(i_s)>=a);
                end
            case "C3" then // fait
                for i_s = 1:100
                    u(i_s) = u(i_s);
                    phi(i_s) = phi(i_s) - q * (s(i_s)-a)/(Young(n)*J(n)) * (s(i_s)>=a);
                    v(i_s) = v(i_s) - q*(s(i_s)-a)^2/(2*Young(n)*J(n)) * (s(i_s)>=a);
                end
            case "C4" then // fait
                for i_s = 1:100
                    u(i_s) = u(i_s)-q*s(i_s)^2/(2*Young(n)*S(n));
                    phi(i_s) = phi(i_s);
                    v(i_s) = v(i_s);
                end
            case "C5" then // fait
                for i_s = 1:100
                    u(i_s) = u(i_s)-q*(s(i_s)-a)*(s(i_s)>=a)/(Young(n)*S(n));
                    phi(i_s) = phi(i_s);
                    v(i_s) = v(i_s);
                end
            case "T1" then
                for i_s = 1:100
                    u(i_s) = u(i_s)-s(i_s)^2/l*alpha(n)*q;
                    phi(i_s) = phi(i_s);
                    v(i_s) = v(i_s);
                end
            case "T2" then 
                for i_s = 1:100
                    u(i_s) = u(i_s);
                    phi(i_s) = phi(i_s) + alpha(n)*q*s(i_s);
                    v(i_s) = v(i_s) + alpha(n)*q*s(i_s)^2/2;
                end
        end
    end
    graph = qn(1:2,1:2)' * [u'*fact_deplacements + s ;v'*fact_deplacements] + [x(i,1)*ones(1,100);x(i,2)*ones(1,100)];
    plot(graph(1,:), graph(2,:),'b');
end

//Affichage des appuis fixes
for inc = 1 : liaisons
    if liaison(inc) == 1 then
        xfrect(x(inc,1)-dim_app, x(inc,2)+dim_app, 2*dim_app, 2*dim_app);
        gce().background = color("red");
    end
        xstring(x(inc,1)-2*dim_app,x(inc,2)+dim_app,string(inc));
end

g = gca();
g.axes_visible="off";
