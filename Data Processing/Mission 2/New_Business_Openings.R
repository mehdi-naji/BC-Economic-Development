library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("33-10-0270-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)


df1_1 <- df1 |> 
  mutate(Measure = `Business dynamics measure`) |>
  filter(str_detect(GEO, "^British")) |>
  select(
    Year, GEO, Industry, Measure, VALUE)

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/New_Business_Openings_1.csv", row.names = FALSE)
