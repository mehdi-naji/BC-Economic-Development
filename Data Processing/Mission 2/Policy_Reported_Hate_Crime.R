library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("??", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)
df1$Month <- month(df1$DATE)

df1_1 <- df1 |> 
  mutate(Measure = `Business dynamics measure`) |>
  filter(Industry == "Business sector industries [T004]",
         str_detect(GEO, "^British")) |>
  # select(
  #   Year, GEO, Industry, Measure, VALUE) |>
  group_by(Year, GEO, Industry, Measure) |>
  summarise(VALUE = sum(VALUE))

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/New_Business_Openings_1.csv", row.names = FALSE)
