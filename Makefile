# Makefile pour le projet CY'FEST

# Compilateur
CC=gcc

# Nom de l'exécutable
TARGET=cyfest

# Fichiers source
SRCS=main.c
# Règle de compilation principale
all: $(TARGET)

# Compilation des fichiers objets
$(TARGET): $(SRCS)
	$(CC) $(SRCS) -o $(TARGET) 

# Nettoyage des fichiers temporaires
clean:
	rm -f $(TARGET)

