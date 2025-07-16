# =============================================================================
# SCRIPT 01: Chargement et préparation des données FOMC
# =============================================================================

# Charger les packages nécessaires
library(jsonlite)
library(dplyr)
library(stringr)
library(lubridate)

# Fonction pour charger les données JSON
load_fomc_data <- function(file_path = "communications.json") {
  cat("Chargement des données FOMC depuis:", file_path, "\n")
  
  # Lire le fichier JSON
  fomc_data <- fromJSON(file_path)
  
  # Convertir en dataframe
  fomc_df <- as.data.frame(fomc_data)
  
  # Nettoyer les données
  fomc_df <- fomc_df %>%
    mutate(
      Date = as.Date(Date),
      Release_Date = as.Date(Release_Date),
      Type = as.factor(Type),
      Text = as.character(Text)
    ) %>%
    arrange(Date)
  
  cat("Données chargées:", nrow(fomc_df), "communications\n")
  cat("Période:", min(fomc_df$Date), "à", max(fomc_df$Date), "\n")
  cat("Types:", paste(levels(fomc_df$Type), collapse = ", "), "\n")
  
  return(fomc_df)
}

# Fonction pour nettoyer le texte
clean_text <- function(text) {
  # Convertir en minuscules
  text <- tolower(text)
  
  # Supprimer les caractères spéciaux et chiffres
  text <- str_replace_all(text, "[^a-zA-Z\\s]", " ")
  
  # Supprimer les espaces multiples
  text <- str_replace_all(text, "\\s+", " ")
  
  # Supprimer les espaces en début et fin
  text <- str_trim(text)
  
  return(text)
}

# Fonction pour tokeniser le texte
tokenize_text <- function(text) {
  # Diviser en mots
  words <- str_split(text, "\\s+")[[1]]
  
  # Supprimer les mots vides et les mots de moins de 3 caractères
  words <- words[nchar(words) >= 3]
  
  return(words)
}

# Charger les données
fomc_data <- load_fomc_data()

# Nettoyer et tokeniser les textes
fomc_data <- fomc_data %>%
  mutate(
    Clean_Text = sapply(Text, clean_text),
    Words = sapply(Clean_Text, tokenize_text),
    Word_Count = sapply(Words, length)
  )

cat("\nPréparation des données terminée!\n")
cat("Nombre total de mots:", sum(fomc_data$Word_Count), "\n") 