// Resolution de la structure
clear D_sol
Rtilde_st_th = L' * R_st_th;
Ktilde = L'*K*L;
Dtilde_sol = -inv(Ktilde) * Rtilde_st_th;
D_sol = L*Dtilde_sol;
clear Rtilde_st_th,clear Ktilde,clear Dtilde_sol
