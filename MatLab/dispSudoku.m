function  dispSudoku(Initial, Solution, file, NBiterations, recLevel, duration,solvability)
    if solvability==-1
        Solution=Initial;
        text(-0.5, -1, "Erreur: le sudoku n'est pas résolvable", 'FontSize',15,'Color','r','FontWeight','bold');
        set(gca,'visible','off')  %masquer les axes
    InitialStr = num2str(Initial(:),'%d'); % convertir en string les tableaux initiaux en int
    SolutionStr = num2str(Solution(:),'%d'); % convertir en string les tableaux initiaux en int
    [x ,y]= meshgrid(1:9);  % on crée les indices de x et y
    x = x-0.5; % on les décale au centre de la case
    y=y-0.5; % on les décale au centre de la case
    xi=x; %on stoke la valeur dans une autre variable
    yi=y;  %on stoke la valeur dans une autre variable
    xi(Initial(:)==0)= []; %on vide les valeur tu tableau initiale dans lesquelles il y a des 0
    yi(Initial(:)==0)= []; %on vide les valeur tu tableau initiale dans lesquelles il y a des 0
    InitialStr(Initial(:)==0)=[]; %on vide les cases correspondante de InitialStr pour qu'ils fassent tous la meme taille 

    hold on  % pour que les plots se superposent 
    colormap([1,1,1;.9,.9,.9]); %on crée les couleurs des cases
    imagesc(0.5,0.5,Initial>0); %on assigne cette couleur aux cases dont on a les valeur initiale 

    x(Initial(:)> 0) = []; % on vide les valeurs du tableau initiale qui sont superieurs à 0 
    y(Initial(:)> 0) = []; % on vide les valeurs du tableau initiale qui sont superieurs à 0
    SolutionStr(Initial(:)> 0) = []; % on vide les cases correspondante de InitialStr pour qu'ils fassent tous la meme taille 

    hstrings = text(xi, yi, InitialStr, ...
        'HorizontalAlignment','center','FontSize',20,'FontWeight','bold'); % formalisme pour l'écriture dans la case pour les chiffres fournit initialement

    hstrings = text(x, y, SolutionStr(:), ...
        'HorizontalAlignment','center','FontSize',16,'Color',[0.3 0.3 0.3], 'FontAngle','italic'); % formalisme pour l'écriture dans la case pour les chiffres trouvés par le programme

    for k = 1 : 8
        plot([0,0]+k,[0,9], 'k', 'LineWidth',0.8) %vertical
        plot([0,9],[0,0]+k, 'k', 'LineWidth',0.8) %horizontal
    end

    for k = 0 : 3 : 9 
        plot([0,0]+k,[0,9], 'k', 'LineWidth',0.8) %vertical
        plot([0,9],[0,0]+k, 'k', 'LineWidth',0.8) %horizontal
    end

    %%  CrtDate = datetime('now'); % création de la date
    %%  text(0, -.5, file, 'fontsize',16,'FontWeight','bold', 'Color',[0 0 1] )
    %%  text(6.2, -.3, sprintf('%s',CrtDate)) 
    %%  text(0.0, 9.35, sprintf(['#iterations = %d,  deepest recursion level = %d,' ...
    %%      '   duration = %f [s]'],NBiterations,recLevel, duration))

    text(0,-0.35,file,'Color','b','FontSize',14) % police d'ecriture du frontsize
    text(0,9.35,"#iterations =" +NBiterations+ ",",'FontSize',6) % nbre iteration
    text(3,9.35,"deepest recursion level =" +recLevel+ ",",'FontSize',6)   % affichage du niveau de la plus profonde recursion
    text(7,9.35,"duration =" +duration+ "[s]",'FontSize',6) % affichage du temps pour trouver les solutions
    creationDateTime = datetime('now', 'Format', 'dd-MMMM-yyyy HH:mm:ss'); % affichage de l'heure
    CharDateTime=char(creationDateTime); % creation de la date 
    text(6,-0.2, CharDateTime,'FontSize',6) % affichage de la date 

    hold off
    axis square % jhbfgbbgbbbg
    set(gca, 'Ydir', 'reverse') % inverse l'axe des y

    % pour cacher les axes
    else
    set(gca,'visible','off')  %masquer les axes
    InitialStr = num2str(Initial(:),'%d'); % convertir en string les tableaux initiaux en int
    SolutionStr = num2str(Solution(:),'%d'); % convertir en string les tableaux initiaux en int
    [x ,y]= meshgrid(1:9);  % on crée les indices de x et y
    x = x-0.5; % on les décale au centre de la case
    y=y-0.5; % on les décale au centre de la case
    xi=x; %on stoke la valeur dans une autre variable
    yi=y;  %on stoke la valeur dans une autre variable
    xi(Initial(:)==0)= []; %on vide les valeur tu tableau initiale dans lesquelles il y a des 0
    yi(Initial(:)==0)= []; %on vide les valeur tu tableau initiale dans lesquelles il y a des 0
    InitialStr(Initial(:)==0)=[]; %on vide les cases correspondante de InitialStr pour qu'ils fassent tous la meme taille 

    hold on  % pour que les plots se superposent 
    colormap([1,1,1;.9,.9,.9]); %on crée les couleurs des cases
    imagesc(0.5,0.5,Initial>0); %on assigne cette couleur aux cases dont on a les valeur initiale 

    x(Initial(:)> 0) = []; % on vide les valeurs du tableau initiale qui sont superieurs à 0 
    y(Initial(:)> 0) = []; % on vide les valeurs du tableau initiale qui sont superieurs à 0
    SolutionStr(Initial(:)> 0) = []; % on vide les cases correspondante de InitialStr pour qu'ils fassent tous la meme taille 

    hstrings = text(xi, yi, InitialStr, ...
        'HorizontalAlignment','center','FontSize',20,'FontWeight','bold'); % formalisme pour l'écriture dans la case pour les chiffres fournit initialement

    hstrings = text(x, y, SolutionStr(:), ...
        'HorizontalAlignment','center','FontSize',16,'Color',[0.3 0.3 0.3], 'FontAngle','italic'); % formalisme pour l'écriture dans la case pour les chiffres trouvés par le programme

    for k = 1 : 8
        plot([0,0]+k,[0,9], 'k', 'LineWidth',0.8) %vertical
        plot([0,9],[0,0]+k, 'k', 'LineWidth',0.8) %horizontal
    end

    for k = 0 : 3 : 9 
        plot([0,0]+k,[0,9], 'k', 'LineWidth',0.8) %vertical
        plot([0,9],[0,0]+k, 'k', 'LineWidth',0.8) %horizontal
    end

    %%  CrtDate = datetime('now'); % création de la date
    %%  text(0, -.5, file, 'fontsize',16,'FontWeight','bold', 'Color',[0 0 1] )
    %%  text(6.2, -.3, sprintf('%s',CrtDate)) 
    %%  text(0.0, 9.35, sprintf(['#iterations = %d,  deepest recursion level = %d,' ...
    %%      '   duration = %f [s]'],NBiterations,recLevel, duration))

    text(0,-0.35,file,'Color','b','FontSize',14) % police d'ecriture du frontsize
    text(0,9.35,"#iterations =" +NBiterations+ ",",'FontSize',6) % nbre iteration
    text(3,9.35,"deepest recursion level =" +recLevel+ ",",'FontSize',6)   % affichage du niveau de la plus profonde recursion
    text(7,9.35,"duration =" +duration+ "[s]",'FontSize',6) % affichage du temps pour trouver les solutions
    creationDateTime = datetime('now', 'Format', 'dd-MMMM-yyyy HH:mm:ss'); % affichage de l'heure
    CharDateTime=char(creationDateTime); % creation de la date 
    text(6,-0.2, CharDateTime,'FontSize',6) % affichage de la date 

    hold off
    axis square % jhbfgbbgbbbg
    set(gca, 'Ydir', 'reverse') % inverse l'axe des y
    end
end