# Makefile pour le projet CY'FEST

# Compilateur
CC=gcc

# Options de compilation
CFLAGS=-Wall -Wextra

# Nom de l'exécutable
TARGET=cyfest

# Fichiers source
SRCS=main.c salle.c reservation.c

# Règle de compilation principale
all: $(TARGET)

# Compilation des fichiers objets
$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

# Nettoyage des fichiers temporaires
clean:
	rm -f $(TARGET)

