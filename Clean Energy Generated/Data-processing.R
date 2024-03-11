library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("25-10-0015-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)
df1$Month <- month(df1$DATE)

df1 <- df1 |> select(DATE, Year, Month, GEO, `Class of electricity producer`,
                     `Type of electricity generation`, UOM, VALUE )

df2 <- df1 |> 
  group_by(Year, GEO, `Class of electricity producer`, `Type of electricity generation`, UOM) |>
  summarise(VALUE = sum(VALUE))

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df2, "C:/Users/MNAJI/StrongerBC-Project/Data/Clean_Energy_Generated_1.csv", row.names = FALSE)
