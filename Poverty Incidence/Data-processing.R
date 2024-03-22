library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("11-10-0135-01", "eng")

df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

df1_1 <- df1 |> 
  filter(
    Year >= 2000
  )|>
  mutate(
    PersonsType = `Persons in low income`,
    IncomeLine = `Low income lines`
  ) |>
  select(
    Year,
    GEO,
    PersonsType,
    IncomeLine,
    Statistics,
    VALUE
  )

df1_1 <- na.omit(df1_1)


write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Poverty_Incidence_1.csv", row.names = FALSE)
