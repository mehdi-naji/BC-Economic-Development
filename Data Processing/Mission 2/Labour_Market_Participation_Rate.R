library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("14-10-0327-02", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)

df1_1 <- df1 |> 
  mutate(Character = `Labour force characteristics`,
         Age = `Age group`) |>
  filter(Year >= 2000,
         Character == "Participation rate",
         Sex == "Both sexes",
         Age == "15 years and over") |>
  select(Year, GEO, VALUE) 

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Labour_Market_Participation_Rate_1.csv", row.names = FALSE)
