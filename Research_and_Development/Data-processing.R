library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("27-10-0273-01", "eng")
df2 <- statcan_download_data("27-10-0273-02", "eng")
df3 <- statcan_download_data("27-10-0359-01", "eng")

df1$Funder <- substring(df1$Funder, 8, nchar(df1$Funder)) 
df1$Performer <- substring(df1$Performer, 11, nchar(df1$Performer)) 

  
df1$REF_DATE <- ymd(df1$REF_DATE)
df2$REF_DATE <- ymd(df2$REF_DATE)
df3$REF_DATE <- ymd(df3$REF_DATE)

df1$Year <- year(df1$REF_DATE)
df2$Year <- year(df2$REF_DATE)
df3$Year <- year(df3$REF_DATE)

df1 <- df1 |> filter (Prices %in% c("Current prices", "2017 constant prices"))
df2 <- df2 |> filter (Prices %in% c("Current prices", "2017 constant prices"))

df1 <- select(df1, Year, GEO, Funder, Performer, `Science type`, Prices, VALUE)
df2 <- select(df2, Year, GEO, Funder, Performer, `Science type`, Prices, VALUE)
df3 <- select(df3, Year, GEO, VALUE)

# Modal page data
Modal_int <- df1 |>
  filter (GEO == "British Columbia",
          Performer == " business enterprise sector",
          Funder == " total, all sectors",
          `Science type` == "Total sciences",
          Prices == "Current prices") |>
  filter(Year == max(Year)) |>
  pull (VALUE, Year)

Modal_year <- names(Modal_int)
Modal_privateinvestment <- Modal_int[[1]]

Modal_data <- data.frame("Year" = Modal_year, 
                         "PrivateInvestment" = Modal_privateinvestment)

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)




write.csv(df1, "C:/Users/mehdi/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
write.csv(df2, "C:/Users/mehdi/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)
write.csv(df3, "C:/Users/mehdi/StrongerBC-Project/Data/Research_and_Development_3.csv", row.names = FALSE)
write.csv(Modal_data, "C:/Users/mehdi/StrongerBC-Project/Data/Research_and_Development_Modal_data.csv", row.names = FALSE)

