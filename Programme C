#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#define BUFF_TAILLE 1000

typedef struct {
    int reservation; // 1 pour reserve, 0 pour non reserve
} Siege;

typedef struct {
    int nbrSiege; // Nombre de sieges dans la rangee
    Siege* tabSiege; // Tableau de sieges
    char categorie; // 'A', 'B', 'C' ou 'F' pour fosse
    float prixCategorie; // Prix de la categorie
} Rangee;

typedef struct {
    char nom[BUFF_TAILLE]; // Nom de la salle
    int nbrRangee; // Nombre de rangees dans la salle
    Rangee* tabRangee; // Tableau de rangees
    float prixA, prixB, prixC; // Prix des categories de sieges
    struct tm heureFin; // Heure de fin du concert
} Salle;

typedef struct {
    char nomArtist[200]; // Nom de l'artiste
    struct tm heureFin; // Heure de fin du concert
    Salle salle; // Salle attribuee au concert
} Concert;

void vide_buffer() {
    // Fonction pour vider le buffer d'entree standard
    while (getchar() != '\n');
}

void ecrireSalleFichiers(char* projet, Salle salle) {
    // Fonction pour ecrire les details d'une salle dans un fichier
    FILE* fic = fopen(projet, "w"); // Ouverture du fichier en mode ecriture
    if (fic == NULL) {
        perror("Erreur"); // Affichage de l'erreur si l'ouverture echoue
        exit(1);
    }

    // Ecriture des details de la salle dans le fichier
    fprintf(fic, "%s\n", salle.nom);
    fprintf(fic, "%d\n", salle.nbrRangee);

    for (int i = 0; i < salle.nbrRangee; i++) {
        fprintf(fic, "%d %c\n", salle.tabRangee[i].nbrSiege, salle.tabRangee[i].categorie);
    }

    for (int i = 0; i < salle.nbrRangee; i++) {
        for (int j = 0; j < salle.tabRangee[i].nbrSiege; j++) {
            fprintf(fic, "%d ", salle.tabRangee[i].tabSiege[j].reservation);
        }
        fprintf(fic, "\n");
    }

    fprintf(fic, "%f %f %f\n", salle.prixA, salle.prixB, salle.prixC);

    // Ecriture de l'heure de fin
    fprintf(fic, "%d %d %d %d %d %d\n", salle.heureFin.tm_sec, salle.heureFin.tm_min, salle.heureFin.tm_hour,
        salle.heureFin.tm_mday, salle.heureFin.tm_mon + 1, salle.heureFin.tm_year + 1900);

    fclose(fic); // Fermeture du fichier
}

Salle lireSalleFichier(const char* nomFichier) {
    // Fonction pour lire les details d'une salle depuis un fichier
    Salle salle;
    FILE* fp = fopen(nomFichier, "r");
    if (fp == NULL) {
        perror("Erreur lors de l'ouverture du fichier");
        exit(1);
    }

    fscanf(fp, "%s", salle.nom);
    fscanf(fp, "%d", &salle.nbrRangee);
    salle.tabRangee = malloc(salle.nbrRangee * sizeof(Rangee));
    //salle.tabRangee = malloc(salle.nbrRangee * 2* sizeof(Rangee));
    
    for (int i = 0; i < salle.nbrRangee; i++) {
        fscanf(fp, "%d %c", &salle.tabRangee[i].nbrSiege, &salle.tabRangee[i].categorie);
        salle.tabRangee[i].tabSiege = malloc(salle.tabRangee[i].nbrSiege * sizeof(Siege));
        printf("%c",salle.tabRangee[i].categorie);
        for (int j = 0; j < salle.tabRangee[i].nbrSiege; j++) {
            fscanf(fp, "%d", &salle.tabRangee[i].tabSiege[j].reservation);
        }
    }

    fscanf(fp, "%f %f %f", &salle.prixA, &salle.prixB, &salle.prixC);
    fscanf(fp, "%d %d %d %d %d %d", &salle.heureFin.tm_sec, &salle.heureFin.tm_min, &salle.heureFin.tm_hour,
        &salle.heureFin.tm_mday, &salle.heureFin.tm_mon, &salle.heureFin.tm_year);
    salle.heureFin.tm_year -= 1900;
    salle.heureFin.tm_mon -= 1;

    fclose(fp);
    return salle;
}

void afficherSalles() {
    // Fonction pour afficher les details de plusieurs salles
    int nbrSalles;
    char projet[256];
    Salle salle;

    // Demander a l'utilisateur le nombre de salles a afficher
    printf("Combien de salles voulez-vous afficher ? ");
    scanf("%d", &nbrSalles);

    for (int i = 0; i < nbrSalles; i++) {
        printf("Veuillez entrer le nom de la salle %d comme suit: ./nomsalle.txt : ", i + 1);
        scanf("%s", projet);

        salle = lireSalleFichier(projet);

        printf("               SCENE              \n");
        printf("----------------------------------\n");
        printf("Nom de la salle: %s\n", salle.nom);
        printf("Rangees et sieges:\n");

        for (int j = 0; j < salle.nbrRangee; j++) {
          printf("R %d ", j + 1);
          printf(" %c ", salle.tabRangee[j].categorie);
            for (int k = 0; k < salle.tabRangee[j].nbrSiege; k++) {
    

                if (salle.tabRangee[j].tabSiege[k].reservation == 1) {
                    printf("X ");
                } else {
                    printf("0 ");
                }
            }
            printf("\n");
        }

        printf("\nCategories et prix:\n");
        printf("Categorie A: %.2f €\n", salle.prixA);
        printf("Categorie B: %.2f €\n", salle.prixB);
        printf("Categorie C: %.2f €\n", salle.prixC);

        printf("Heure de fin du concert: %02d:%02d:%02d le %d-%02d-%02d\n", salle.heureFin.tm_hour, salle.heureFin.tm_min, salle.heureFin.tm_sec,
               salle.heureFin.tm_year + 1900, salle.heureFin.tm_mon + 1, salle.heureFin.tm_mday);

        // Liberer la memoire allouee
        for (int j = 0; j < salle.nbrRangee; j++) {
            free(salle.tabRangee[j].tabSiege);
        }
        free(salle.tabRangee);
    }
}

Salle creationSalle() {
    // Fonction pour creer une nouvelle salle
    Salle a;
    int catA, catB;
    printf("Veuillez entrer le nom de la salle : ");
    scanf("%s", a.nom);
    printf("Combien de rangees voulez-vous ? ");
    scanf("%d", &a.nbrRangee);

    a.tabRangee = malloc(a.nbrRangee * sizeof(Rangee)); // Allocation dynamique de memoire pour les rangees
    if (a.tabRangee == NULL) {
        printf("L'allocation du tableau de rangees a echoue\n");
        exit(1);
    }

    for (int i = 0; i < a.nbrRangee; i++) {
        printf("Veuillez entrer le nombre de sieges pour la rangee %d : ", i + 1);
        scanf("%d", &a.tabRangee[i].nbrSiege);
        a.tabRangee[i].tabSiege = malloc(a.tabRangee[i].nbrSiege * sizeof(Siege)); // Allocation dynamique de memoire pour les sieges
        if (a.tabRangee[i].tabSiege == NULL) {
            printf("L'allocation des sieges a echoue\n");
            exit(1);
        }
        for (int j = 0; j < a.tabRangee[i].nbrSiege; j++) {
            a.tabRangee[i].tabSiege[j].reservation = 0; // Initialisation de tous les sieges comme non reserves
        }
    }

    do {
        printf("Veuillez entrer le nombre de rangees pour la categorie A : ");
        scanf("%d", &catA);
        printf("Veuillez entrer le nombre de rangees pour la categorie B : ");
        scanf("%d", &catB);

        if (catA + catB > a.nbrRangee) {
            printf("Erreur : Le nombre total de rangees pour les categories A et B ne peut pas depasser le nombre total de rangees (%d).\n", a.nbrRangee);
        }
    } while (catA + catB > a.nbrRangee);

        printf("Veuillez entrer le prix des sieges de categorie A : ");
        scanf("%f", &a.prixA);
        printf("Veuillez entrer le prix des sieges de categorie B : ");
        scanf("%f", &a.prixB);
        printf("Veuillez entrer le prix des sieges de categorie C : ");
        scanf("%f", &a.prixC);

    for (int i = 0; i < catA; i++) {
        a.tabRangee[i].categorie = 'A';
        a.tabRangee[i].prixCategorie = a.prixA;
    }
    for (int i = catA; i < catB + catA; i++) {
        a.tabRangee[i].categorie = 'B';
        a.tabRangee[i].prixCategorie = a.prixB ;
    }
    for (int i = catB + catA; i < a.nbrRangee; i++) {
        a.tabRangee[i].categorie = 'C';
        a.tabRangee[i].prixCategorie = a.prixC;
    }


    printf("Votre salle a ete creee avec succes\n");
    char buff[BUFF_TAILLE];
    snprintf(buff, sizeof(buff), "./%s.txt", a.nom); // Creer un fichier pour la salle
    FILE* fp = fopen(buff, "w");
    if (!fp) {
        printf("La creation du fichier contenant votre salle a rencontre un probleme\n");
    } else {
        printf("Le fichier contenant votre salle a ete cree avec succes\n");
        ecrireSalleFichiers(buff, a);
        fclose(fp);
    }
    return a;
}

struct tm insertTime() {
    // Fonction pour inserer l'heure de fin du concert
    struct tm userTime = {0};
    printf("Veuillez entrer l'heure (hh), le jour (dd), le mois (mm) et l'annee (aaaa) du concert : ");
    scanf("%d %d %d %d", &userTime.tm_hour, &userTime.tm_mday, &userTime.tm_mon, &userTime.tm_year);
    userTime.tm_min = 0;
    userTime.tm_sec = 0;
    userTime.tm_year -= 1900; // Ajuster l'annee pour la structure tm
    userTime.tm_mon -= 1; // Ajuster le mois pour la structure tm
    return userTime;
}

Concert attribution() {
    // Fonction pour attribuer une salle a un concert
    Concert a;
    int x;
    char buff[BUFF_TAILLE];
    printf("Veuillez entrer le nom de la salle que vous voulez attribuer au concert comme suit: ./nomsalle.txt : ");
    scanf("%s", buff);
    FILE* fp = fopen(buff, "r");
    if (!fp) {
        printf("Le nom de salle que vous avez entre n'existe pas. Voulez-vous creer une nouvelle salle (1) ou reessayer (2) ? ");
        scanf("%d", &x);
        while (x != 1 && x != 2) {
            printf("Vous avez entre une mauvaise valeur. Veuillez reessayer (1 pour creer une nouvelle salle, 2 pour reessayer) : ");
            scanf("%d", &x);
        }
        if (x == 1) {
            creationSalle();
            return attribution();
        } else {
            return attribution();
        }
    } else {
        fread(&a.salle, sizeof(Salle), 1, fp);
        fclose(fp);
        printf("Veuillez entrer le nom de l'artiste : ");
        scanf("%s", a.nomArtist);
      
        a.heureFin = insertTime();
        fp = fopen(buff, "a");
        fprintf(fp, "Nom de l'artiste : %s\n", a.nomArtist);
        fprintf(fp, "Heure de fin : %d:%d:%d %d/%d/%d\n", a.heureFin.tm_hour, a.heureFin.tm_min, a.heureFin.tm_sec, a.heureFin.tm_mday, a.heureFin.tm_mon + 1, a.heureFin.tm_year + 1900);
        fclose(fp);
    }
    return a;
}

Salle fosseConcert(Salle a) {
    // Fonction pour ajouter une fosse dans une salle
    int x;
    printf("Voulez-vous ajouter une fosse (1 pour oui, 2 pour non) ? ");
    scanf("%d", &x);
    while (x != 1 && x != 2) {
        printf("Vous avez entre une mauvaise valeur. Veuillez reessayer (1 pour oui, 2 pour non) : ");
        scanf("%d", &x);
    }
    if (x == 1) {
        for (int i = 0; i < a.nbrRangee; i++) {
            if (a.tabRangee[i].categorie == 'A') {
                a.tabRangee[i].categorie = 'F';
                a.tabRangee[i].nbrSiege *= 2; // Doubler le nombre de sieges pour la fosse
            }
        }
    }
    return a;
}

int compareTime(struct tm userTime) {
    // Fonction pour comparer le temps du concert avec le temps actuel
    time_t userTimeT = mktime(&userTime); // Conversion en time_t pour comparaison
    time_t currentTime;
    time(&currentTime); // Obtention du temps actuel
    double difference = difftime(userTimeT, currentTime); // Difference en secondes
    if (difference > 0) {
        printf("Le concert n'a pas encore commence\n");
        return 0;
    } else {
        printf("Le concert est termine\n");
        return 1;
    }
}

Salle modifSalle() {
    // Fonction pour modifier une salle existante
    Concert c;
    int x, catA, catB;
    char buff[BUFF_TAILLE];
    printf("Veuillez entrer le nom de la salle que vous voulez modifier comme suit: ./nomsalle.txt : ");
    scanf("%s", buff);
    FILE* fp = fopen(buff, "r");
    if (!fp) {
        printf("Le nom de salle que vous avez entre est errone. Veuillez reessayer comme suit: ./nomsalle.txt : ");
        scanf("%s", buff);
        fp = fopen(buff, "r");
        if (!fp) {
            printf("Le fichier de salle n'a pas pu etre ouvert.\n");
            exit(1);
        }
    }
    fread(&c.salle, sizeof(Salle), 1, fp);
    fclose(fp);
    printf("Voulez-vous modifier le nombre de rangees des categories A et B (1 pour oui, 2 pour non) ? ");
    scanf("%d", &x);
    while (x != 1 && x != 2) {
        printf("Vous avez entre une mauvaise valeur. Veuillez reessayer (1 pour oui, 2 pour non) : ");
        scanf("%d", &x);
    }
    if (x == 1) {
        for (int i = 0; i < c.salle.nbrRangee; i++) {
            if (c.salle.tabRangee[i].categorie == 'F') {
                c.salle.tabRangee[i].nbrSiege /= 2; // Reduire le nombre de sieges pour la fosse
            }
        }
        printf("Veuillez entrer le nombre de rangees pour la categorie A : ");
        scanf("%d", &catA);
        printf("Veuillez entrer le nombre de rangees pour la categorie B : ");
        scanf("%d", &catB);
        while (catA + catB > c.salle.nbrRangee) {
            printf("Erreur : Le nombre total de rangees pour les categories A et B ne peut pas depasser le nombre total de rangees (%d).\n", c.salle.nbrRangee);
            printf("Veuillez entrer le nombre de rangees pour la categorie A : ");
            scanf("%d", &catA);
            printf("Veuillez entrer le nombre de rangees pour la categorie B : ");
            scanf("%d", &catB);
        }
        for (int i = 0; i < catA; i++) {
            c.salle.tabRangee[i].categorie = 'A';
        }
        for (int i = catA; i < catB + catA; i++) {
            c.salle.tabRangee[i].categorie = 'B';
        }
        for (int i = catB + catA; i < c.salle.nbrRangee; i++) {
            c.salle.tabRangee[i].categorie = 'C';
        }
    }
    c.salle = fosseConcert(c.salle);
    printf("Voulez-vous modifier le prix des places (1 pour oui, 2 pour non) ? ");
    scanf("%d", &x);
    while (x != 1 && x != 2) {
        printf("Vous avez entre une mauvaise valeur. Veuillez reessayer (1 pour oui, 2 pour non) : ");
        scanf("%d", &x);
    }
    if (x == 1) {
        printf("Veuillez entrer le prix des sieges de categorie A : ");
        scanf("%f", &c.salle.prixA);
        printf("Veuillez entrer le prix des sieges de categorie B : ");
        scanf("%f", &c.salle.prixB);
        printf("Veuillez entrer le prix des sieges de categorie C : ");
        scanf("%f", &c.salle.prixC);
    }
    c.heureFin = insertTime();
    ecrireSalleFichiers(buff, c.salle);
    return c.salle;
}

void ratioSiege() {
    // Fonction pour afficher le ratio des sieges reserves par rapport au nombre total de sieges
    int totalSieges = 0;
    int siegesReserves = 0;
    Salle s;
    char buff[BUFF_TAILLE];
    printf("Veuillez entrer le nom de la salle de concert souhaitee pour effectuer le ratio comme suit: ./nomsalle.txt : ");
    scanf("%s", buff);
    FILE* fp = fopen(buff, "r");
    if (!fp) {
        printf("Le nom de salle que vous avez entre est errone. Veuillez reessayer comme suit: ./nomsalle.txt : ");
        scanf("%s", buff);
        fp = fopen(buff, "r");
        if (!fp) {
            printf("Le fichier de salle n'a pas pu etre ouvert.\n");
            exit(1);
        }
    }
    fread(&s, sizeof(Salle), 1, fp);
    for (int i = 0; i < s.nbrRangee; i++) {
        Rangee* r = &(s.tabRangee[i]);
        totalSieges += r->nbrSiege;
        for (int j = 0; j < r->nbrSiege; j++) {
            if (r->tabSiege[j].reservation) {
                siegesReserves++;
            }
        }
    }
    if (totalSieges == 0) {
        printf("Aucun siege disponible.\n");
    } else {
        printf("Le ratio sieges reserves / nombre total de sieges est : %f\n", (float)siegesReserves / totalSieges);
    }
    fclose(fp);
}

void afficherSallesDisponibles() {
    // Fonction pour afficher les salles disponibles avec des concerts non termines
    printf("Salles disponibles avec des concerts non termines :\n");
    int numSalles;
    char nomFichier[BUFF_TAILLE];

    // Demander a l'utilisateur le nombre de salles a verifier
    printf("Combien de salles voulez-vous verifier ? ");
    scanf("%d", &numSalles);

    for (int i = 0; i < numSalles; i++) {
        printf("Veuillez entrer le nom de la salle %d comme suit: ./nomsalle.txt : ", i + 1);
        scanf("%s", nomFichier);

        Salle salle = lireSalleFichier(nomFichier);
        time_t maintenant;
        time(&maintenant);
        if (difftime(mktime(&salle.heureFin), maintenant) > 0) {
            printf("Salle : %s\n", salle.nom);
        }
    }
}

void afficherPlanSalle(Salle salle) {
    // Fonction pour afficher le plan de la salle
    for (int i = 0; i < salle.nbrRangee; i++) {
        printf("Rangee %d - Categorie %c:\n", i + 1, salle.tabRangee[i].categorie);
        for (int j = 0; j < salle.tabRangee[i].nbrSiege; j++) {
            if (salle.tabRangee[i].tabSiege[j].reservation == 0) {
                printf("[Libre] ");
            } else {
                printf("[Res.] ");
            }
        }
        printf("\n");
    }
}

void reserverSieges(Salle* salle) {
    // Fonction pour reserver des sieges dans une salle
    int rangee, siege, nbrReservations = 0;
    float prixTotal = 0.0;
    char choix;

    do {
        printf("Veuillez entrer le numero de la rangee a reserver : ");
        scanf("%d", &rangee);
        if (rangee < 1 || rangee > salle->nbrRangee) {
            printf("Rangee invalide.\n");
            continue;
        }

        printf("Veuillez entrer le numero du siege a reserver : ");
        scanf("%d", &siege);
        if (siege < 1 || siege > salle->tabRangee[rangee - 1].nbrSiege) {
            printf("Siege invalide.\n");
            continue;
        }

        if (salle->tabRangee[rangee - 1].tabSiege[siege - 1].reservation == 1) {
            printf("Ce siege est deja reserve.\n");
        } else {
            salle->tabRangee[rangee - 1].tabSiege[siege - 1].reservation = 1;
            nbrReservations++;
            switch (salle->tabRangee[rangee - 1].categorie) {
            case 'A':
                prixTotal += salle->prixA;
                break;
            case 'B':
                prixTotal += salle->prixB;
                break;
            case 'C':
                prixTotal += salle->prixC;
                break;
            case 'F':
                prixTotal += salle->prixA; // Supposition : meme prix que categorie A
                break;
            }
        }

        printf("Voulez-vous reserver un autre siege ? (o/n) : ");
        vide_buffer();
        choix = getchar();
    } while (choix == 'o' || choix == 'O');

    printf("Nombre total de sieges reserves : %d\n", nbrReservations);
    printf("Prix total des places reservees : %.2f\n", prixTotal);
}

void festivalier() {
    // Mode Festivalier
    char nomSalle[BUFF_TAILLE];
    printf("Mode Festivalier :\n");

    afficherSallesDisponibles();

    printf("Veuillez entrer le nom de la salle dans laquelle vous souhaitez reserver comme suit: ./nomsalle.txt : ");
    scanf("%s", nomSalle);

    Salle salle = lireSalleFichier(nomSalle);

    time_t maintenant;
    time(&maintenant);
    if (difftime(mktime(&salle.heureFin), maintenant) > 0) {
        printf("Plan de la salle %s :\n", salle.nom);
        afficherPlanSalle(salle);
        reserverSieges(&salle);
        ecrireSalleFichiers(nomSalle, salle);
    } else {
        printf("Le concert dans cette salle est termine.\n");
    }
}

void manager() {
    // Mode Manager
    int choix;
    do {
        printf("Mode Manager :\n");
        printf("1. Creer une salle\n");
        printf("2. Attribuer une salle a un concert\n");
        printf("3. Modifier une salle\n");
        printf("4. Afficher les salles\n");
        printf("5. Afficher le ratio sieges reserves / nombre total de sieges\n");
        printf("0. Retour au menu principal\n");
        printf("Votre choix : ");
        scanf("%d", &choix);
        vide_buffer();
        switch (choix) {
        case 1:
            creationSalle();
            break;
        case 2:
            attribution();
            break;
        case 3:
            modifSalle();
            break;
        case 4:
            afficherSalles();
            break;
        case 5:
            ratioSiege();
            break;
        case 0:
            return;
        default:
            printf("Choix non valide. Veuillez reessayer.\n");
        }
    } while (choix != 0);
}

void menuPrincipal() {
    // Menu principal pour choisir le mode
    int choix;
    int verif;
    do {
        printf("Entrez 1 pour acceder au mode manager\n");
        printf("Entrez 2 pour acceder au mode festivalier\n");
        printf("Quel mode voulez-vous ? ");
        verif = scanf("%d", &choix);
        vide_buffer();
        switch (choix) {
        case 1:
            printf("Vous pouvez a tout moment entrer 0 pour revenir a ce menu.\n");
            manager();
            break;
        case 2:
            printf("Vous pouvez a tout moment entrer 0 pour revenir a ce menu.\n");
            festivalier();
            break;
        default:
            printf("Choix non valide. Veuillez reessayer.\n");
        }
    } while (choix != 1 && choix != 2 || verif != 1);
}

int main() {
    // Fonction principale
    menuPrincipal();
    return 0;
}

  

	
