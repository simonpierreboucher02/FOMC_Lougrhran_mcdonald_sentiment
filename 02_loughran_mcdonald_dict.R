# =============================================================================
# SCRIPT 02: Téléchargement et préparation du dictionnaire Loughran-McDonald
# =============================================================================

library(dplyr)
library(readr)
library(stringr)

# Chemin local pour le dictionnaire (doit être déjà présent)
dict_file <- "Loughran-McDonald_MasterDictionary_1993-2024.csv"

if (!file.exists(dict_file)) {
  stop(paste0("Le fichier ", dict_file, " est introuvable. Merci de le placer dans le dossier de travail."))
} else {
  cat("Dictionnaire trouvé localement.\n")
}

# Charger le dictionnaire
lm_dict <- read_csv(dict_file)

# Garder uniquement les colonnes utiles et filtrer les mots positifs/négatifs
lm_sentiment <- lm_dict %>%
  select(Word, Positive, Negative) %>%
  mutate(
    Word = tolower(Word),
    Positive = as.numeric(Positive),
    Negative = as.numeric(Negative)
  ) %>%
  filter(Positive > 0 | Negative > 0)

# Créer deux vecteurs de mots
lm_positive <- lm_sentiment %>% filter(Positive > 0) %>% pull(Word)
lm_negative <- lm_sentiment %>% filter(Negative > 0) %>% pull(Word)

cat("Nombre de mots positifs:", length(lm_positive), "\n")
cat("Nombre de mots négatifs:", length(lm_negative), "\n") 