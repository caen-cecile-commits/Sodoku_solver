function A = FillHypothesis(M)
    A = ones(9,9,9); % on crée une matrice 3D 9x9x9, remplie de 1
    for x = 1:9 
        for y = 1:9
            if M(x,y) > 0 % on regarde si l'élèment de la matrice M, qui représente le sudoku de départ, possède une valeure
                val = M(x,y); 
                A(x,:,val) = 0; % empeche d'avoir la même valeur sur la ligne x
                A(:,y,val) = 0; % empeche d'avoir la même valeur sur la colonne y
                A(x,y,:) = 0; % empeche d'avoir une autre valeur sur la position (x,y)
                A(3*ceil(x/3)-(0:2),3*ceil(y/3)-(0:2),val)=0; %% empeche d'avoir la même valeur dans le carré 3x3 contenant la valeur
                A(x,y,val) = 1; % met un 1 à l'emplacement exact de la valeur
                
            end
        end
    end   
end

