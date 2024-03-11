library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("36-10-0608-01", "eng")

df2 <- df1 |>
  filter(
    Estimate == "Investment",
    Asset == "Total assets" ) |>
  select(
    REF_DATE, GEO, Prices, `Purchasing industry`, `Asset function`, VALUE  
  )

df2$DATE <- ymd(df2$REF_DATE)
df2$Year <- year(df2$DATE)

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df2, "C:/Users/MNAJI/StrongerBC-Project/Data/Government_Investment_Infrastructure_1.csv", row.names = FALSE)
