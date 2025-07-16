# 📊 FOMC Sentiment Analysis with Loughran-McDonald Dictionary

[![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)](https://www.r-project.org/)
[![JSON](https://img.shields.io/badge/JSON-000000?style=for-the-badge&logo=json&logoColor=white)](https://www.json.org/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/simonpierreboucher02)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

## 🎯 Overview

This repository contains a comprehensive sentiment analysis pipeline for Federal Open Market Committee (FOMC) communications using the Loughran-McDonald financial sentiment dictionary. The analysis processes statements and minutes from FOMC meetings to extract sentiment metrics and trends.

## 📈 Key Metrics

![Total Communications](https://img.shields.io/badge/Total%20Communications-259-blue)
![Total Words](https://img.shields.io/badge/Total%20Words-836,897-green)
![Positive Words](https://img.shields.io/badge/Positive%20Words-347-brightgreen)
![Negative Words](https://img.shields.io/badge/Negative%20Words-2,345-red)
![Sentiment Range](https://img.shields.io/badge/Sentiment%20Range--0.83%20to%200.73-orange)

## 🏗️ Repository Structure

```
FOMC_Lougrhran_mcdonald_sentiment/
├── 📄 communications.json                    # Original FOMC data
├── 📄 communications_with_sentiment.json     # Data with sentiment scores
├── 📄 communications_normalized_sentiment.json # Data with normalized sentiment
├── 📊 fomc_sentiment_scores.csv              # CSV export of sentiment scores
├── 📋 01_load_data.R                         # Data loading and preprocessing
├── 📋 02_loughran_mcdonald_dict.R            # Dictionary preparation
├── 📋 03_sentiment_scoring.R                 # Sentiment scoring
├── 📋 04_merge_sentiment_to_json.R           # JSON enrichment
├── 📋 05_normalized_sentiment_score.R        # Normalized sentiment calculation
└── 📖 README.md                              # This file
```

## 🚀 Quick Start

### Prerequisites

```r
# Required R packages
install.packages(c("jsonlite", "dplyr", "stringr", "lubridate", "readr"))
```

### Installation

```bash
# Clone the repository
git clone https://github.com/simonpierreboucher02/FOMC_Lougrhran_mcdonald_sentiment.git
cd FOMC_Lougrhran_mcdonald_sentiment

# Download the Loughran-McDonald dictionary
# Place Loughran-McDonald_MasterDictionary_1993-2024.csv in the project directory
```

### Usage

```bash
# Run the complete sentiment analysis pipeline
Rscript 03_sentiment_scoring.R

# Generate normalized sentiment scores
Rscript 05_normalized_sentiment_score.R
```

## 📊 Sentiment Analysis Methodology

### Loughran-McDonald Dictionary
- **Positive Words**: 347 financial-specific positive terms
- **Negative Words**: 2,345 financial-specific negative terms
- **Source**: University of Notre Dame SRAF (Software Repository for Accounting and Finance)

### Sentiment Scoring Formula

**Normalized Sentiment Score:**
```
Sentiment Score = (N_positive - N_negative) / (N_positive + N_negative + ε)
```

Where:
- `N_positive`: Count of positive words
- `N_negative`: Count of negative words  
- `ε`: Small constant (ε = 1) to avoid division by zero

**Score Interpretation:**
- **+1.0**: Extremely positive sentiment
- **0.0**: Neutral sentiment
- **-1.0**: Extremely negative sentiment

## 📈 Results Summary

| Metric | Value |
|--------|-------|
| **Total Communications** | 259 |
| **Date Range** | 1993 - 2024 |
| **Document Types** | Statements, Minutes |
| **Average Sentiment** | -0.062 |
| **Sentiment Range** | -0.83 to +0.73 |
| **Standard Deviation** | 0.304 |

## 🔧 Scripts Description

### 01_load_data.R
- Loads and preprocesses FOMC communications from JSON
- Cleans and tokenizes text data
- Handles date formatting and data validation

### 02_loughran_mcdonald_dict.R
- Downloads and prepares the Loughran-McDonald dictionary
- Extracts positive and negative word lists
- Filters relevant financial sentiment terms

### 03_sentiment_scoring.R
- Applies sentiment scoring to each communication
- Calculates positive, negative, and net sentiment counts
- Exports results to CSV format

### 04_merge_sentiment_to_json.R
- Merges sentiment scores with original JSON data
- Creates enriched dataset with sentiment metrics
- Maintains data integrity and structure

### 05_normalized_sentiment_score.R
- Calculates normalized sentiment scores using the provided formula
- Generates additional metrics (raw sentiment, total sentiment words)
- Provides statistical summary of sentiment distribution

## 📊 Output Files

- **`communications_with_sentiment.json`**: Original data enriched with sentiment counts
- **`communications_normalized_sentiment.json`**: Complete dataset with normalized sentiment scores
- **`fomc_sentiment_scores.csv`**: Tabular format for easy analysis

## 🎯 Use Cases

- **Monetary Policy Analysis**: Track sentiment trends in FOMC communications
- **Market Research**: Correlate sentiment with market movements
- **Academic Research**: Study central bank communication patterns
- **Risk Assessment**: Monitor policy uncertainty through sentiment analysis

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Simon Pierre Boucher**
- GitHub: [@simonpierreboucher02](https://github.com/simonpierreboucher02)

## 🙏 Acknowledgments

- **Loughran & McDonald**: For the financial sentiment dictionary
- **University of Notre Dame SRAF**: For maintaining the dictionary
- **Federal Reserve**: For providing FOMC communications data

---

⭐ **Star this repository if you find it useful!** 