library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("35-10-0177-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)

df1_1 <- df1 |> 
  filter(Year >= 2000,
         Violations == "Total violent Criminal Code violations [100]",
         Statistics == "Rate, total persons charged per 100,000 population aged 12 years and over") |>
  select(
    Year, GEO , VALUE)

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Occurance_Violent_Crime_1.csv", row.names = FALSE)
