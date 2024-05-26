# CY'FEST

CY'FEST est un système de gestion des réservations pour des festivals. Il permet aux organisateurs de gérer les salles et les sièges, et aux utilisateurs de réserver des places pour les événements.

## Description

Ce projet vise à simplifier la gestion des réservations pour les festivals en fournissant un outil complet pour la gestion des salles, des sièges, et des réservations.

## Fonctionnalités

Pour les festivaliers :

- voir les salles et les sièges disponibles
- réserver un ou plusieurs sièges avec des catégories différentes selon leur emplacement

Pour les managers :

- créer des salles (nom, nombre de rangées et de sièges, prix des sièges selon les catégories)
- attribuer un concert à une salle
- définir l'heure de fin d'un concert
- modifier les salles
- observer l'état des salles 

## Structure du Projet

- `main.c` : Contient la fonction `main` et le menu principal.
- `salle.c` : Contient les fonctions liées à la gestion des salles.
- `reservation.c` : Contient les fonctions liées à la gestion des réservations.
- `salle.h` : Déclarations des structures et des fonctions utilisées dans `salle.c`.
- `reservation.h` : Déclarations des structures et des fonctions utilisées dans `reservation.c`.

## Compilation

### Prérequis

- Un compilateur C (comme `gcc`).
- `make` pour utiliser le Makefile.

### Utilisation du Makefile

Le Makefile fourni permet de compiler facilement le projet. Pour compiler le projet, exécutez les commandes suivantes dans un terminal :

- `make` : Compile tous les fichiers source et génère l'exécutable principal.
- `make clean` : Supprime les fichiers objets (.o) et l'exécutable pour nettoyer le répertoire de compilation.









   
