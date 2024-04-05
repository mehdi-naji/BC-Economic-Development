library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("13-10-0114-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)


df1_1 <- df1 |> 
  mutate(Age = `Age group`) |>
  filter(Element == "Life expectancy (in years) at age x (ex)") |>
  select(
    Year, GEO, Age, Sex, Element, VALUE)

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Life_Expectancy_1.csv", row.names = FALSE)
