function [M,solvability] = solveSudoku(M,rlevel)
    global maxrlevel 
    global nIteration

    nIteration = nIteration + 1; % incrémente nIteration à chaque appel de la fonction 
    rlevel = rlevel + 1   % incrmente le niveau de recursion

    if (rlevel > maxrlevel)
        maxrlevel = rlevel
    end
    %% maxrlevel = max(maxrlevel, rlevel + 1)

    A=FillHypothesis(M); 
    solvability=checkSolved(A);

    switch solvability

        case 1 %grille résolue
            [~,~,Z] = meshgrid(1:9);
            M = sum(A.*Z,3);

        case 0 %grille non-resolue, appel de getChoices
            [x,y,choices] = getChoices(A,M);
            for n = choices
                M(x,y) = n;
                [M2,solvability] = solveSudoku(M,rlevel);
                if (solvability == 1)
                    M = M2;
                    return
                end
            end

        case -1 % grille insolvable

    end
end