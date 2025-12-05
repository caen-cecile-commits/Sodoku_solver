// Pierre-Louis PETER n°363161
// Cécile CAEN n°361560
// Balthazar BOLZE n°361471




#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include <stdint.h>               // for int16_t on windows
#pragma warning(disable : 4996)   //conversion de visual studio code vers visual studio





//initialisation


#define DigitBitmapHeight 24    // hauteur du chiffre (bitmap) en nombre de pixel
#define DigitBitmapWidth 16     //largeur du chiffre (bitmap) en nombre de pixel

int16_t DigitBitmap[9][DigitBitmapHeight] =
{
    {0, 0, 96, 224, 224, 992, 4064, 4064, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 224, 0, 0},
    {0, 0, 496, 2044, 4092, 7710, 7182, 14350, 14351, 14, 30, 60, 124, 496, 2016, 3968, 7680, 7168, 14336, 16382, 16382, 16382, 0, 0},
    {0, 0, 992, 4088, 8188, 7196, 14350, 14350, 14350, 28, 252, 504, 508, 30, 14, 14, 14350, 14350, 14350, 15422, 8188, 4080, 0, 0},
    {0, 0, 56, 120, 120, 248, 504, 440, 952, 1848, 3640, 3640, 7224, 14392, 14392, 16383, 16383, 56, 56, 56, 56, 56, 0, 0 },
    {0, 0, 4092, 4092, 4092, 3072, 7168, 7168, 7168, 8176, 8184, 8188, 7198, 14, 14, 15, 14, 14350, 14350, 15932, 8188, 4080, 0, 0},
    {0, 0, 496, 2044, 4092, 7710, 7182, 7174, 14336, 14832, 15352, 16380, 15902, 15374, 14350, 14343, 14343, 14350, 7182, 7708, 4092, 2032, 0, 0},
    {0, 0, 16382, 16383, 16383, 14, 28, 28, 56, 112, 112, 224, 224, 448, 448, 960, 896, 896, 1920, 1792, 1792, 1792, 0, 0, },
    {0, 0, 992, 4088, 8188, 7198, 7182, 14350, 7182, 7196, 4092, 4088, 8188, 15390, 14350, 14350, 14350, 14350, 15374, 7710, 8188, 2040, 128, 0, },
    {0, 0, 992, 4088, 8188, 7196, 14350, 14350, 14350, 14350, 14350, 15390, 7742, 8190, 2030, 14, 14, 14364, 14364, 7224, 8184, 4080, 0, 0, }
};




//fonction 1 GetDigitBitmap :  La fonction lit le digitBitmap du chiffre concerné à la ligne l et va effectuer une opération binaire pour connaître l'état au pixel lxc, 0 ou 1.
unsigned char GetDigitBitmapBit(short digit, int l, int c) {
    return ((DigitBitmap[digit - 1][l] & (1 << (15 - c))) == (1 << (15 - c)));
}                   //digit 1-9 pour ligne de digitBitmap       l entre 0 et 23           c entre 0 et 15



//fonction 2  GetCellBit lit le pixel de la cellule et retourne son état binaire, 0 ou 1.

unsigned char GetCellBit(unsigned char* cell, int Width, int line, int col) {
    return cell[Width * line + col];
}    // cell=tableau      Width=44       line 0-43     col 0-43





//début du main

int main(int argc, const char* argv[]) {

    //initialisation du fichier cell avec les cellulles contenant les chiffres (vient de labview)
    unsigned char* cell;


    //controle des arguments donner en meme tps qu'on lance le programme / lecture et validation des parametres
    if (argc != 12) {
        fprintf(stderr, "arguments that you have entered are wrong ! \ntry again \n");
        return -1;
    } // nombre d'arguments est égale à 12 + emplacement pour fichier : 11

    int liste_ratio[10];
    for (int i = 0; i <= 9; i++) {
        liste_ratio[i] = atoi(argv[i + 2]);             //on transforme le tab de char donnée comme argument  en tab d'entier
        if ((liste_ratio[i] < 0) || (liste_ratio[i] > 100)) {
            fprintf(stderr, "Valeurs des ratios non-contenues entre 0 et 100!");  // verification de la cohérence des ratios
            return -1;
        }
    }


    //creation des fichiers et initialisation des erreures
    FILE* f_in, * f_out;
    f_in = fopen(argv[1], "rb");
    f_out = fopen("CellValue.txt", "w+");

    if (f_in == NULL) { perror("Erreur 1lors de l'ouverture\n"); return -1; }
    if (f_out == NULL) { perror("Erreur 2lors de l'ouverture\n"); return -1; }

    int L = 0;
    int H = 0;
    size_t a = 0;
    size_t b = 0;
    a = fread(&L, sizeof(unsigned int), 1, f_in);  //on veut lire la premiere valeur de f_in et la stocker dans la variable L, a est égale au nombre d'élement lu
    b = fread(&H, sizeof(unsigned int), 1, f_in);  //on veut lire la valeur suivante de f_in (la deuxième) et la stocker dans la variable de H, b est égale au nombre d'élement lu

    //on vérifie que le bon nombre d'éelement a ete lu par fread
    if (a != 1) {
        fprintf(stderr, "erreur dans la lecture de la largeur\n");
        return -1;
    }
    //on vérifie que le bon nombre d'éelement a ete lu par fread
    if (b != 1) {
        fprintf(stderr, "erreur dans la lecture de la hauteur\n");
        return -1;
    }
    // verifier que L et H sont bien compris respectivement entre 16 et 100 et entre 24 et 100 
    if (L < 16 || L>100) {
        fprintf(stderr, "L n'est pas compris entre 16 et 100 \n");
        return -1;
    }
    if (H < 24 || H>100) {
        fprintf(stderr, "H n'est pas compris entre 24 et 100 \n");
        return -1;
    }

    //mise en place de la mémoire dynamique (réserver le nombre de place nécéssaire pour mettre le fichier cell)
    cell = malloc((L * H + 1) * sizeof(unsigned char));

    if (cell == NULL) {
        fprintf(stderr, "erreur de memoire\n");       // test verification fichier cell contient qqch
        return -1;
    }


    size_t d = 0;
    d = fread(cell, sizeof(unsigned char), (L * H + 1), f_in);      //on stock dans cell les L*H+1 élements suivants de f_in

    // verif qu'on a lu le bon nbre de pixel
    if (d < L * H) {
        fprintf(stderr, "erreur dans la lecture des éléments\n");       // on a pas lu assez d'element dans le fichier
        return -1;
    }

    if (d == L * H + 1) {
        fprintf(stderr, " warning : il y a trop d'éléments\n");       // warning trop d'éléments
    }



    float check = 0;
    float ratiob = 0;
    int nb = 0;                             //initialisations des variables 
    float ratio = 0;
    float best_ratio = 0;

    // check 98% pixel blanc avec if else 
    for (int i = 0; i < L; i++) {
        for (int j = 0; j < H; j++) {

            if (GetCellBit(cell, L, i, j) == 0) {
                check++;
            }
        }
    }



    ratiob = (check / (L * H)) * 100.0;   //calcul du ratio


    if (ratiob >= liste_ratio[0]) {
        fprintf(f_out, "d: '0' , %f\n", ratiob);         //si 98% des pixels sont blancs la case est considérée blanche et on écrit 0 dans f_out
        return 0;
    }



    else {



        // balade dans sudoku

        for (short digit = 1; digit <= 9; digit++) {

            int tmax = 0;                                             //meilleur comptabilité pour chaque chiffre

            for (int col = 0; col < (L - 16); col++) {

                for (int line = 0; line < (H - 24); line++) {

                    int t1 = 0;                                     //total de comptabilité dans la case 24*16

                    for (int c = 0; c < 16; c++) {

                        for (int l = 0; l < 24; l++) {

                            if (GetDigitBitmapBit(digit, l, c) == GetCellBit(cell, L, (line + l), (col + c))) {  //test de la compatibilité entre le bitmap et la partie étudié de la cellulle 
                                t1++;
                            }
                        }
                    }

                    if (tmax <= t1) {   //on affecte a tmax la meilleure compabilitée
                        tmax = t1;
                    }

                }
            }
            // ratio
            ratio = (tmax / (24.0 * 16.0)) * 100.0;  //calcule du ratio

            if (ratio >= liste_ratio[digit]) {   //teste si le ratio obtenue est plus grand que le seuil minimal donné en argument
                if (ratio > best_ratio) {
                    best_ratio = ratio;            //permet de garder le meilleur ratio
                    nb = digit;
                }
            }

        }
    }



    fprintf(f_out, "d: '%d', %f\n", nb, best_ratio); // écrire dans f_out le chiffre de la case et le ratio correspondant

    free(cell); //liberation de la memoire
    fclose(f_in);            //fermeture des fichiers 
    fclose(f_out);

    //if (f_in == NULL) { perror("Erreur 3lors de la fermeture\n"); return -1; } 
    //if (f_out == NULL) { perror("Erreur 4lors de la fermeture\n"); return -1; } 

    return 0; // verifier les return voir qd on doit mettre return 0 et return -1
}

