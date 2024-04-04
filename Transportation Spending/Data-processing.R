library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("11-10-0223-01", "eng")

df1$DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$DATE)


df1_1 <- df1 |> 
  mutate(Category = `Household expenditures, summary-level categories`,
         Quantile = `Before-tax household income quintile`) |>
  filter(Statistic == "Average expenditure per household",
         Quantile == "All quintiles",
         Category %in% c("Total current consumption",
                         "Transportation")
         ) |>
  select(
    Year, GEO, Category, UOM, VALUE
  ) |>
  pivot_wider(names_from = Category, values_from = VALUE) |>
  mutate(Total = `Total current consumption`,
         Transportation = `Transportation` ) |>
  mutate(VALUE = Transportation / Total)

# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Transportation_Expenditure_1.csv", row.names = FALSE)
