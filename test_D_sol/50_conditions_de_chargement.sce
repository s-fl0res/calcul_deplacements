
clear tch;clear ich;clear ech;

// pour tch : C1 --> 1, ... C5 --> 5, T1 --> -1, T2 --> -2

a = 1/2;
Q = 1;

//poteau 1, chargmeent longitudinal
n=1;
tch(n,:)=["C0","C0","C0"];//Type de chargement
ich(n,:) = [-Q,0,0];// Intensité du chargement (dépend du type)
ech(n,:) = [a,0,0]; // Excentricité du chargement (ce n'a de sens que pour les charges poncuelles) : distance par rapport à l'origin du repère

//poteau 2,chargement longitudinal
n =2;
tch(n,:)=["C2","C0","C0"];
ich(n,:) = [Q,0,0];
ech(n,:) = [a,0,0];



