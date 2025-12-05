function solvability = checkSolved(A) % verifie si le sudoku est solvable ou non
    R = sum(A,3); % somme les 9 etages de la troisieme dimension en 1

    if all(all(R == 1)) % Cette condition vérifie si tous les éléments du tableau 2D R sont égaux à 1.
        solvability = 1;  % Si c'est le cas, cela signifie que chaque sous-grille 3x3 a exactement un élément non nul, ce qui indique un Sudoku résolu.

    elseif any(any(R == 0)) % cette condition vérifie s'il existe une sous-grille dans laquelle la somme est égale à 0, ce qui indiquerait un Sudoku irrésoluble.
        solvability = -1;

    else     % Si aucune des conditions ci-dessus n'est vraie, le Sudoku est considéré comme partiellement résolu ou ayant plusieurs solutions.
        solvability = 0;
    end
    
end
