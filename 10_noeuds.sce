format("e",25)
 clear x, clear liaison
 
 // noeud 1
 noeud = 1;          // indice du noeud
 x(noeud,:) = [0,0]; // coordonnée du noeud
 liaison(noeud) = 1; // liaison au noeud 1 (0 si )
 
 // noeud 2
 noeud = 2;
 x(noeud,:) = [5,0] ;
 liaison(noeud) = 1;
 
 // noeud 3
 noeud = 3;
 x(noeud,:) = [9,0];
 liaison(noeud) = 1;
 
 // noeud 4
 noeud = noeud + 1;
 x(noeud,:) = [0,3];
 liaison(noeud) = 0;

 // noeud 5
 noeud = noeud + 1;
 x(noeud,:) = [5,3];
 liaison(noeud) = 0;
 
 // noeud 6
 noeud = noeud + 1;
 x(noeud,:) = [9,3]; 
 liaison(noeud) = 0;
 
  // noeud 4
 noeud = noeud + 1;
 x(noeud,:) = [0,6];
 liaison(noeud) = 0;

 // noeud 5
 noeud = noeud + 1;
 x(noeud,:) = [5,6];
 liaison(noeud) = 0;
 
 // noeud 6
 noeud = noeud + 1;
 x(noeud,:) = [9,6]; 
 liaison(noeud) = 0;
 
 clear noeud
 
 
