# =============================================================================
# SCRIPT 05: Calcul du score de sentiment normalisé
# =============================================================================

library(jsonlite)
library(dplyr)
library(readr)

# Charger les données avec sentiment
cat("Chargement des données avec sentiment...\n")
fomc_with_sentiment <- fromJSON("communications_with_sentiment.json")

# Fonction pour calculer le score normalisé
calculate_normalized_sentiment <- function(pos_count, neg_count, epsilon = 1) {
  numerator <- pos_count - neg_count
  denominator <- pos_count + neg_count + epsilon
  return(numerator / denominator)
}

# Calculer le score normalisé
fomc_normalized <- fomc_with_sentiment %>%
  mutate(
    Normalized_Sentiment = calculate_normalized_sentiment(Pos_Count, Neg_Count),
    # Ajouter aussi le score brut pour comparaison
    Raw_Sentiment = Pos_Count - Neg_Count,
    Total_Sentiment_Words = Pos_Count + Neg_Count
  )

# Sauvegarder le résultat
cat("Sauvegarde du fichier JSON avec score normalisé...\n")
write_json(fomc_normalized, "communications_normalized_sentiment.json", pretty = TRUE)

# Afficher quelques statistiques
cat("\nStatistiques du score normalisé:\n")
cat("Score minimum:", min(fomc_normalized$Normalized_Sentiment, na.rm = TRUE), "\n")
cat("Score maximum:", max(fomc_normalized$Normalized_Sentiment, na.rm = TRUE), "\n")
cat("Score moyen:", mean(fomc_normalized$Normalized_Sentiment, na.rm = TRUE), "\n")
cat("Écart-type:", sd(fomc_normalized$Normalized_Sentiment, na.rm = TRUE), "\n")

cat("\nFichier communications_normalized_sentiment.json créé avec succès!\n")
cat("Nouvelles colonnes ajoutées: Normalized_Sentiment, Raw_Sentiment, Total_Sentiment_Words\n") 