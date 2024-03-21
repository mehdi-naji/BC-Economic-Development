library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("14-10-0029-01", "eng")
df2 <- statcan_download_data("14-10-0023-01", "eng")
df3 <- statcan_download_data("14-10-0327-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)

df2$DATE <- ymd(df2$REF_DATE)
df2$Year <- year(df2$DATE)

df3$DATE <- ymd(df3$REF_DATE)
df3$Year <- year(df3$DATE)

df1 <- df1 |>
  filter(
    Year >=2000
  ) |>
  mutate(
    Reason = `Reason for part-time work`,
    Age = `Age group`
  ) |>
  select(
    Year, GEO, Reason, Sex, Age, VALUE  
  )

df1_1 <- df1 |>
  filter(
    Sex != "Both sexes",
    Age == "15 years and over",
    GEO %in% c("Canada",
               "Quebec",
               "Alberta",
               "Ontario",
               "British Columbia")  )|>
  mutate( Reason = case_when(
    Reason %in% c(
      "Business conditions, did not look for full-time work in last month",
      "Business conditions, looked for full-time work in last month") ~ "Business conditions",
    Reason %in% c(
      "Could not find full-time work, did not look for full-time work in last month",
      "Could not find full-time work, looked for full-time work in last month") ~ "Could not find full-time work",
    TRUE ~ Reason)
  ) |>
  group_by(Year, GEO, Sex, Age, Reason) |>
  summarise(VALUE = sum(VALUE)) |>
  ungroup() |>
  filter(Reason %in% c(
    "Part-time employment, all reasons",
    "Own illness",
    "Caring for children",
    "Going to school",
    "Personal preference",
    "Could not find full-time work",
    "Business conditions"))





df2_1 <- df2 |>
  filter(
    Year >= 2000,
    `North American Industry Classification System (NAICS)` == "Total, all industries",
  )|>
  mutate(
    Character = `Labour force characteristics`,
    Age = `Age group`
  ) |>
  select(
    Year, GEO, Character, Sex, Age, VALUE  
  )

df2_2 <- df2 |>
    filter(
      Year >= 2000,
      Sex == "Both sexes",
      `Age group` == "15 years and over",
      `North American Industry Classification System (NAICS)` %in% c(
        "Agriculture [111-112, 1100, 1151-1152]",
        "Forestry, fishing, mining, quarrying, oil and gas [21, 113-114, 1153, 2100]",
        "Utilities [22]",
        "Construction [23]",
        "Manufacturing [31-33]",
        "Wholesale and retail trade [41, 44-45]",
        "Transportation and warehousing [48-49]",
        "Finance, insurance, real estate, rental and leasing [52, 53]",
        "Professional, scientific and technical services [54]",
        "Business, building and other support services [55, 56]",
        "Educational services [61]",
        "Health care and social assistance [62]",
        "Information, culture and recreation [51, 71]",
        "Accommodation and food services [72]",
        "Public administration [91]")) |>
  mutate( NAICS =
            case_when(
              `North American Industry Classification System (NAICS)` == "Agriculture [111-112, 1100, 1151-1152]" ~ "Agriculture",
              `North American Industry Classification System (NAICS)` == "Forestry, fishing, mining, quarrying, oil and gas [21, 113-114, 1153, 2100]" ~ "Forestry, fishing, mining",
              `North American Industry Classification System (NAICS)` == "Utilities [22]" ~ "Utilities",
              `North American Industry Classification System (NAICS)` == "Construction [23]" ~ "Construction",
              `North American Industry Classification System (NAICS)` == "AManufacturing [31-33]" ~ "Manufacturing",
              `North American Industry Classification System (NAICS)` == "Wholesale and retail trade [41, 44-45]" ~ "Wholesale and retail trade",
              `North American Industry Classification System (NAICS)` == "Transportation and warehousing [48-49]" ~ "Transportation and warehousing",
              `North American Industry Classification System (NAICS)` == "Finance, insurance, real estate, rental and leasing [52, 53]" ~ "Finance, insurance, real estate",
              `North American Industry Classification System (NAICS)` == "Professional, scientific and technical services [54]" ~ "Professional, scientific and technical services",
              `North American Industry Classification System (NAICS)` == "Business, building and other support services [55, 56]" ~ "Business, building and other support services",
              `North American Industry Classification System (NAICS)` == "Educational services [61]" ~ "Educational services",
              `North American Industry Classification System (NAICS)` == "Health care and social assistance [62]" ~ "Health care and social assistance",
              `North American Industry Classification System (NAICS)` == "Information, culture and recreation [51, 71]" ~ "Information, culture and recreation",
              `North American Industry Classification System (NAICS)` == "Accommodation and food services [72]" ~ "Accommodation and food services",
              `North American Industry Classification System (NAICS)` == "Public administration [91]" ~ "Public administration",
              TRUE ~ "Other"
                  ))|>
  mutate(
    Character = `Labour force characteristics`
  ) |>
  select(
    Year, GEO, Character, NAICS , VALUE  
  )
  

df3_1 <- df3 |>
  filter(
    Year >=2000,
    `Age group` %in% c(
      "15 to 24 years",
      "25 to 29 years",
      "30 to 34 years",
      "35 to 39 years",
      "40 to 44 years",
      "45 to 49 years",
      "50 to 54 years",
      "55 to 59 years",
      "60 to 64 years",
      "65 to 69 years",
      "70 years and over"
      )
  ) |>
  mutate(
    Character = `Labour force characteristics`,
    Age = `Age group`
  ) |>
  select(
    Year, GEO, Character, Age, Sex, VALUE  
  )
# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1,   "C:/Users/MNAJI/StrongerBC-Project/Data/Unemployment_Rate_1.csv", row.names = FALSE)
write.csv(df2_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Unemployment_Rate_2.csv", row.names = FALSE)
write.csv(df2_2, "C:/Users/MNAJI/StrongerBC-Project/Data/Unemployment_Rate_3.csv", row.names = FALSE)
write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Unemployment_Rate_4.csv", row.names = FALSE)
write.csv(df3_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Unemployment_Rate_5.csv", row.names = FALSE)

