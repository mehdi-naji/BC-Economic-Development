library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("36-10-0608-01", "eng")
df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)

df1_1 <- df1 |>
  mutate(Industry = `Purchasing industry`,
         Asset_fn = `Asset function`) |>
  filter(
    Year >= 2000,
    GEO == "British Columbia",
    Estimate == "Investment",
    Asset == "Total assets",
    Asset_fn == "All functions",
    Prices == "Constant dollars",
    Industry %in% c("Provincial government (excluding health and educational services)",
                    "Educational services",
                    "Hospitals",
                    "Nursing and residential care facilities")
    ) |>
  select(Year, Industry, VALUE) |>
  group_by(Year) |>
  summarise(VALUE = sum(VALUE))

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Government_Investment_Infrastructure_1.csv", row.names = FALSE)
