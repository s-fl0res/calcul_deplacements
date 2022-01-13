
clear tch;clear ich;clear ech;

// pour tch : C1 --> 1, ... C5 --> 5, T1 --> -1, T2 --> -2

kN = 10^3;
//poteau 1, chargmeent longitudinal
n=1;
i = ij(n,1);
j = ij(n,2);
// Calcul de l    
l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
tch(n,:)=["C1","C5","C0"];//Type de chargement
ich(n,:) = [2.25*kN,-14.10*kN,0];// Intensité du chargement (dépend du type)
ech(n,:) = [0,l,0]; // Excentricité du chargement (ce n'a de sens que pour les charges poncuelles) : distance par rapport à l'origin du repère

//poteau 2,chargement longitudinal
n =2;
i = ij(n,1);
j = ij(n,2);
// Calcul de l    
l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
tch(n,:)=["C1","C5","C0"];
ich(n,:) = [2.25*kN,-18.31*kN,0];
ech(n,:) = [0,l,0];

n =3;
i = ij(n,1);
j = ij(n,2);
// Calcul de l    
l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
tch(n,:)=["C1","C5","C0"];
ich(n,:) = [2.25*kN,-10.77*kN,0];
ech(n,:) = [0,l,0];

n =4;
i = ij(n,1);
j = ij(n,2);
// Calcul de l    
l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
tch(n,:)=["C1","C5","C0"];
ich(n,:) = [2.25*kN,-11.51*kN,0];
ech(n,:) = [0,l,0];

n =5;
i = ij(n,1);
j = ij(n,2);
// Calcul de l    
l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
tch(n,:)=["C1","C5","C0"];
ich(n,:) = [2.25*kN,-15.71*kN,0];
ech(n,:) = [0,l,0];

n =6;
i = ij(n,1);
j = ij(n,2);
// Calcul de l    
l = sqrt((x(j,1) - x(i,1))^2 + (x(j,2) - x(i,2))^2);
tch(n,:)=["C1","C5","C0"];
ich(n,:) = [2.25*kN,-10.77*kN,0];
ech(n,:) = [0,l,0];

n =7;
tch(n,:)=["C1","C1","C0"];
ich(n,:) = [3.75*kN,3.758*kN,0];
ech(n,:) = [0,0,0];

n =8;
tch(n,:)=["C1","C1","C0"];
ich(n,:) = [3.75*kN,1.743*kN,0];
ech(n,:) = [0,0,0];

n =9;
tch(n,:)=["C1","C1","C0"];
ich(n,:) = [3.75,2.464,0]*kN;
ech(n,:) = [0,0,0];


n =10;
tch(n,:)=["C1","C1","C0"];
ich(n,:) = [3.75,1.743,0]*kN;
ech(n,:) = [0,0,0];

