
clear x, clear liaison

l=1;
L=1;

// noeud 1
noeud = 1;      // indice du noeud
x(noeud,:) = [0,0]; // coordonnée du noeud
liaison(noeud) = 1; // liaison au noeud 1 (0 si )

// noeud 2
noeud = 2;         // indice du noeud
x(noeud,:) = [l/2,0]; // coordonnée du noeud
liaison(noeud) = 0; // liaison au noeud 1 (0 si )


// noeud 3
noeud = 3;         // indice du noeud
x(noeud,:) = [l,0]; // coordonnée du noeud
liaison(noeud) = 1; // liaison au noeud 1 (0 si )


clear noeud
 
 
