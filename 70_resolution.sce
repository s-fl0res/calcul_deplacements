// Resolution de la structure

Rtilde_st_th = L' * R_st_th;
Ktilde = L'*K*L;
Dtilde_sol = -inv(Ktilde) * Rtilde_st_th;
D_sol = L*Dtilde_sol;
