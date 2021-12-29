clear x, clear liaison

// Initialisation
noeud = 0;

//noeud 1
noeud = noeud + 1; 
x(noeud, :) = [L,0];
liaison(noeud) = 1;

//noeud 2
noeud = noeud + 1;
x(noeud, :) = [2*L,l];
liaison(noeud) = 1;

//noeud 3
noeud = noeud + 1 ;
x(noeud, :) = [L,2*l];
liaison(noeud) = 1;

//noeud 4
noeud = noeud + 1;
x(noeud, :) = [0,l];
liaison(noeud) = 1;

//noeud 5
noeud = noeud + 1;
x(noeud, :) = [L,l];
liaison(noeud) = 0;

clear noeud, clear l, clear L
