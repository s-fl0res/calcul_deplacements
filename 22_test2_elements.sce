clear ij, clear S, clear Young, clear J

// initialisation
n = 0;

// paramètres 
E = 1;
Section = 1;
Moment = 1;

// élément 1
n = n + 1;
ij(n,:) = [1,5];
S(n) = Section;
Young(n) = E;
J(n) = Moment;

// élément 2
n = n + 1;
ij(n,:) = [2,5];
S(n) = Section;
Young(n) = E;
J(n) = Moment;

// élément 3
n = n + 1;
ij(n,:) = [3,5];
S(n) = Section;
Young(n) = E;
J(n) = Moment;

// élément 4
n = n + 1;
ij(n,:) = [4,5];
S(n) = Section;
Young(n) = E;
J(n) = Moment;

clear n, clear E, clear Section, clear Moment
