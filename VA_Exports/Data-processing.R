library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("12-10-0100-01", "eng")
df2 <- statcan_download_data("36-10-0222-01", "eng")

df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

df2$REF_DATE <- ymd(df2$REF_DATE)
df2$Year <- year(df2$REF_DATE)

df1 <- df1 |> filter (`Value added exports variable` %in% c("Value added exports","Value added in exports, within-province"),
                     `Country Code` == "Total of all countries",
                     Aggregation == "Summary level") |>
  select(Year, GEO, Industry, `Value added exports variable`, VALUE)
# names(df1)[names(df1) == "VALUE"] <- "VA_EXP"


df2 <- df2 |> 
  filter (Prices == "Current prices",
          Estimates == "Gross domestic product at market prices") |>
  select (Year, GEO, VALUE)
names(df2)[names(df2) == "VALUE"] <- "GDP"


dff <- merge(df1, df2, by = c("Year", "GEO"))

# write.csv(df1, "~/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)
write.csv(dff, "C:/Users/MNAJI/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)


