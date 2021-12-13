clear u, clear v, clear phi

resultats = mopen('resultats.txt','w')

for n=1:E
    //construction des Cni, Cnj
    Cni = zeros(3,3*N)
    Cni(:,3*i-2:3*i)=eye(3,3)
    Cnj = zeros(3,3*N)
    Cnj(:,3*j-2:3*j)=eye(3,3)
    
    //construction des Dni, Dnj, dni, dnj
    Dni = Cni*D_sol
    Dnj = Cnj*D_sol
    dni = qn*Dni
    dnj = qn*Dnj
    
    //construction des knii, knij
    knii = Young(n)/(l^3)*[S(n)*l^2, 0, 0
                            0,      12*J(n), 6*J(n)*l
                            0,      6*J(n)*l,  4*J(n)*l^2]//cours partie 2
    knij = Young(n)/(l^3)*[-S(n)*l^2,    0,         0;
                            0,      -12*J(n),   6*J(n)*l;                                                        
                            0,      -6*J(n)*l,  2*J(n)*l^2]//cours partie 2
                            
    //construction de rni
    rni = knii*dni+knij*dnj
    i = ij(n,1)
    j = ij(n,2)
    l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2) 
    for i_chargement=1:3
        q = ich(n, i_chargement)
        a = ech(n, i_chargement)
        select tch(n,i_chargement)
            case "C1" then
                rni = rni + [0; q*l/2; q*l^2/12]//fct des variables ich et ech
                rnj = rnj + [0; q*l/2; -q*l^2/12]//fct des variables ich et ech
            case "C2" then //case = if
                rni = rni + [0; q/l^3*(l^3-3*l*a^2+2*a^3); q/l^2*a*(l-a)^2]
                rnj = rnj + [0; q/l^3*a^2*(3*l-2*a); -q/l^2*a^2*(l-a)]
            case "C3" then //case = if
                rni = rni + [0; 6*q*a*(l-a)/l^3; q/l^2*(a_l)*(l-3*a)]
                rnj = rnj + [0; -6*q*a*(l-a)/l^3; q/l^2*a*(2*l-3*a)]
            case "C4" then //case = if
                rni = rni + [-q*l/2; 0; 0]
                rnj = rnj + [-q*l/2; 0; 0]
            case "C5" then //case = if
                rni = rni + [-q/l*(l-a); 0; 0]
                rnj = rnj + [-q/l*a; 0; 0]
            case "T1" then //case = if
                rni = rni + [Young(n)*S(n)*alpha(n)*q; 0; 0]
                rnj = rnj + [-Young(n)*S(n)*alpha(n)*q; 0; 0]
            case "T2" then //case = if
                rni = rni + [0; 0; -Young(n)*J(n)*alpha(n)*q]
                rnj = rnj + [0; 0; Young(n)*J(n)*alpha(n)*q]
            end
        end
        s = [0, l/4, l/2, 3*l/4, l]
        u = zeros(5,1)
        v = zeros(5,1)
        phi = zeros(5,1)
        for i_s=1:5
            u(i_s) = dni(1) + rni(1)*s(i_s)/(Young(n)*S)
            phi(i_s) = dni(3) - rni(3)*s(i_s)/(Young(n)*J(n))+ rni(2)*s(i_s)^2/(2*Young(n)*J(n))
            v(i_s) = dni(2) + dni(3)*s(i_s) - rni(3)*s(i_s)^2/(2*Young(n)*J(n))+ rni(2)*s(i_s)^3/(6*Young(n)*J(n))
        end
        for i_chargement=1:3
            select tch(n, i_chargement)
                case "C2" then 
                    for i_s=1:5
                        u(i_s) = u(i_s)
                        phi(i_s) = phi(i_s) - q*(s(i_s)^2/2 - a*s(i_s))/(Young(n)*J(n))
                        v(i_s) = v(i_s) - q*(s(i_s)^3/6 - a*s(i_s)^2/2)/(Young(n)*J(n))
                    end
                end
            end
        end
    r = ['Element', n;
            'S', s(1), s(2), s(3), s(4), s(5);
            'u', u(1), u(2), u(3), u(4), u(5);
            'v', v(1), v(2), v(3), v(4), v(5);
            'phi', phi(1), phi(2), phi(3), phi(4), phi(5)]
    write(resultats, r )  
