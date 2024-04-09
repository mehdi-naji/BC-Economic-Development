library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("11-10-0134-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)


df1 <- df1 |> 
  mutate(Income_concept = `Income concept`) |>
  select(
    Year, GEO, Income_concept, UOM, VALUE
  )

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1, "C:/Users/MNAJI/StrongerBC-Project/Data/Gini_Coefficient_1.csv", row.names = FALSE)
