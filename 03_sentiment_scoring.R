# =============================================================================
# SCRIPT 03: Scoring du sentiment des communications FOMC
# =============================================================================

# Charger les scripts précédents
source("01_load_data.R")
source("02_loughran_mcdonald_dict.R")

# Fonction pour scorer le sentiment d'un texte
dict_sentiment_score <- function(words, pos_dict, neg_dict) {
  n_pos <- sum(words %in% pos_dict)
  n_neg <- sum(words %in% neg_dict)
  score_net <- n_pos - n_neg
  return(list(n_pos = n_pos, n_neg = n_neg, score_net = score_net))
}

# Appliquer le scoring à chaque communication
sentiment_results <- fomc_data %>%
  rowwise() %>%
  mutate(
    Sentiment = list(dict_sentiment_score(Words, lm_positive, lm_negative)),
    Pos_Count = Sentiment$n_pos,
    Neg_Count = Sentiment$n_neg,
    Net_Score = Sentiment$score_net
  ) %>%
  ungroup()

# Sauvegarder les résultats
df_sentiment <- sentiment_results %>%
  select(Date, Release_Date, Type, Text, Pos_Count, Neg_Count, Net_Score)

write.csv(df_sentiment, "fomc_sentiment_scores.csv", row.names = FALSE)

cat("\nScoring terminé! Résultats sauvegardés dans fomc_sentiment_scores.csv\n") 