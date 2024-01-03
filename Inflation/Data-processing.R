library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("18-10-0004-01", "eng") 

df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

df1$Month <- month(df1$REF_DATE)
df1$Month <- sprintf("%02d", df1$Month)
df1$YearMonth <- paste(df1$Year, df1$Month, "01", sep="-")
df1$YearMonth <- as.Date(df1$YearMonth, format="%Y-%m-%d")
df1$YearMonth <- format(as.Date(df1$YearMonth), "%Y-%m")


df1 <- df1|>
  filter (Year >= 2000,
          UOM == "2002=100")|>
  select (YearMonth, GEO, `Products and product groups`, COORDINATE, VALUE)

df1 <- df1[order(df1$YearMonth), ]

df1_1 <- df1 |> 
  group_by(GEO, `Products and product groups`, COORDINATE)|>
  arrange(YearMonth) |>
  mutate(inflation = round((VALUE-lag(VALUE))/lag(VALUE)*100,2))

write.csv(df1_1, "C:/Users/mehdi/StrongerBC-Project/Data/Price_Index_1.csv", row.names = FALSE)
# write.csv(df1_1, "~/StrongerBC-Project/Data/Price_Index_1.csv", row.names = FALSE)

        
