library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("36-10-0222-01", "eng")
df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

selected_sectors <- c(11:16, 38)
filter_conditions  <- sapply(selected_sectors, function(x) grepl(paste0("\\..*\\.", x, "$"), df1$COORDINATE))
filter_conditions <- apply(filter_conditions, 1, any)
df2 <- df1[filter_conditions, ]

df2 <- df2 |> 
  select(Year, GEO, Prices, Estimates, UOM, SCALAR_FACTOR, VALUE) |>
  filter(Prices %in% c("Current prices", "Chained (2017) dollars"))
df3 <- df2
df3 <- df2 |>
  group_by(Year, GEO, Prices) |>
  mutate(GDP = first(VALUE[Estimates == "Gross domestic product at market prices"]),
         Estimate_per_GDP = round(100*VALUE/GDP,1))

# write.csv(df1, "~/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)
write.csv(df2, "C:/Users/MNAJI/StrongerBC-Project/Data/Non_Residential_Investment_1.csv", row.names = FALSE)

