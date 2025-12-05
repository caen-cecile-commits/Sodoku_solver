OpenPDF = 1;
Filenum = " s8.pdf"
M = [ 0 2 0 0 0 0 0 4 0;
 1 0 0 0 0 7 5 0 9;
 0 0 0 0 0 0 2 3 0;
 5 0 8 0 0 9 0 0 6;
 0 0 0 1 0 0 4 0 0;
 0 0 4 0 0 3 0 0 0;
 9 5 0 7 0 0 0 1 0;
 0 0 0 0 0 1 9 0 0;
 0 6 0 0 4 0 0 2 0;
];
file = "s8.jpg"

global maxrlevel
maxrlevel = 0;
global nIteration
nIteration = 1;

start = tic;

[S,solvability] = solveSudoku(M,0);

duration = toc(start);

dispSudoku(M, S, file, nIteration, maxrlevel, duration,solvability)
%file et M envoyé par Labview

print(Filenum,'-dpdf')


if OpenPDF 
    open(Filenum)
end


%3 variables a definir 
% M sudoku a resoudre
% File = 's2.pdf'
%file = 's2.jpg'