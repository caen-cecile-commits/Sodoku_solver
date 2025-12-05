function [x,y,choices] = getChoices(A,M) 
    R = sum(A,3).*not(M); % les cases non vides de M sont ignorées
   
    for z = 1:9 % Cete boucle renvoie les choix possibles d'une case
        i = find(R == z,1);
        if i~=0
            [x,y] = ind2sub([9,9],i); % renvoie les coordonnées
            choices = find(A(x,y,:))'; % les choix possibles sont retournés
            break
        end
    end
end


