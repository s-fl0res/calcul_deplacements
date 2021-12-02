clear L

N = size(x,1)        // quantité de noeuds
L = eye(3*N,3*N)     // initialisation matrice de liaisons

// Initialisation
enleves = 0;
F = [];
n = size(liaison,1);
for i=1:n
    if liaison(i) == 0
        m = [m,i];
    end
end



clear enleves, clear liaison, clear i, clear liaisons
