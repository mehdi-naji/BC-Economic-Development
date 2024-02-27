# RnD----


load_RnD1 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

load_RnD2 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_3.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}


load_VAEX <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/VA_Exporsts_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}