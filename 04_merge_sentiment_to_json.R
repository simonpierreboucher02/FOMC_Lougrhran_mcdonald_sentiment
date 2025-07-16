# =============================================================================
# SCRIPT 04: Fusion des scores de sentiment avec le JSON original
# =============================================================================

library(jsonlite)
library(dplyr)
library(readr)
library(lubridate)

# Charger les données originales JSON
cat("Chargement du fichier JSON original...\n")
fomc_json <- fromJSON("communications.json")

# Charger les scores de sentiment
cat("Chargement des scores de sentiment...\n")
sentiment_scores <- read_csv("fomc_sentiment_scores.csv")

# Convertir en dataframe et normaliser les types de données
fomc_df <- as.data.frame(fomc_json) %>%
  mutate(
    Date = as.character(Date),
    Release_Date = as.character(Release_Date),
    Type = as.character(Type),
    Text = as.character(Text)
  )

# Normaliser les types dans sentiment_scores
sentiment_scores <- sentiment_scores %>%
  mutate(
    Date = as.character(Date),
    Release_Date = as.character(Release_Date),
    Type = as.character(Type),
    Text = as.character(Text)
  )

# Fusionner les données
fomc_with_sentiment <- fomc_df %>%
  left_join(sentiment_scores, by = c("Date", "Release_Date", "Type", "Text"))

# Convertir en JSON et sauvegarder
cat("Sauvegarde du fichier JSON avec sentiment...\n")
write_json(fomc_with_sentiment, "communications_with_sentiment.json", pretty = TRUE)

cat("Fichier communications_with_sentiment.json créé avec succès!\n")
cat("Nombre de communications:", nrow(fomc_with_sentiment), "\n")
cat("Colonnes ajoutées: Pos_Count, Neg_Count, Net_Score\n") 