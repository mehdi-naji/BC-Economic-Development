library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("12-10-0100-01", "eng")

df <- df1

df$REF_DATE <- ymd(df$REF_DATE)

df$Year <- year(df$REF_DATE)

dff <- df |> filter (`Value added exports variable` == "Value added exports",
                     `Country Code` == "Total of all countries",
                      Aggregation == "Summary level") |>
             select(Year, GEO, `Country Code`, Industry, VALUE)

# write.csv(df1, "~/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)
write.csv(dff, "C:/Users/MNAJI/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)


