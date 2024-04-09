library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("11-10-0135-01", "eng")

df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

df1_1 <- df1 |> 
  filter(
    Year >= 2000
  )|>
  mutate(
    PersonsType = `Persons in low income`,
    IncomeLine = `Low income lines`
  ) |>
  select(
    Year,
    GEO,
    PersonsType,
    IncomeLine,
    Statistics,
    VALUE
  )

df1_1 <- na.omit(df1_1)


df1_2 <- df1_1 |>
  filter(
    PersonsType %in% c(
      "Males",
      "Males, under 18 years" ,
      "Males, 18 to 64 years" ,
      "Males, 65 years and over",
      "Females",
      "Females, under 18 years" , 
      "Females, 18 to 64 years" ,
      "Females, 65 years and over"
    )
  )

df1_2 <- df1_2 |>
  mutate(
    Sex = case_when(
      PersonsType %in% c("Males", "Males, under 18 years", "Males, 18 to 64 years", "Males, 65 years and over") ~ "Males",
      PersonsType %in% c("Females", "Females, under 18 years", "Females, 18 to 64 years", "Females, 65 years and over")  ~ "Females",
      .default = "ERROR"
    ),
    Age = case_when(
      PersonsType %in% c("Males", "Females")  ~ "All ages",
      PersonsType %in% c("Males, under 18 years",    "Females, under 18 years")    ~ "under 18 years",
      PersonsType %in% c("Males, 18 to 64 years",    "Females, 18 to 64 years")    ~ "18 to 64 years",
      PersonsType %in% c("Males, 65 years and over", "Females, 65 years and over") ~ "65 years and over",
      .default = "ERROR"
    ))|>
      select(
        Year,
        GEO,
        Sex,
        Age,
        IncomeLine,
        Statistics,
        VALUE
    )


write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Poverty_Incidence_1.csv", row.names = FALSE)
write.csv(df1_2, "C:/Users/MNAJI/StrongerBC-Project/Data/Poverty_Incidence_2.csv", row.names = FALSE)
