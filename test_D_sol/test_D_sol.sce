

E = 1;
J = 1;
L = 1;
l = 1;
a = l/2;
S = 1;
Q = 1;

Kt = [12*E*J/l^3 + E*S/L , 0 , 6*E*J/l^2 ; 0 , E*S/l + 12*E*J/L^3 , 6*E*J/L^2 ; 6*E*J/L^2 , 6*E*J/L^2 , 4*E*J/l + 4*E*J/L];

Rt = [0 ; Q*(L^3-3*L*a+2*a^3)/L^3 ; Q*a*(L-a)*(L-a)/L^2];

D_sol = - inv(Kt)*Rt




