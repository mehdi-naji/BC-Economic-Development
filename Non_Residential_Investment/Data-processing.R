library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("36-10-0222-01", "eng")
df2 <- statcan_download_data("36-10-0108-01", "eng")
df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

df2$REF_DATE <- ymd(df2$REF_DATE)
df2$Year <- year(df2$REF_DATE)

### First dataset

selected_sectors <- c(11:16, 38, 9)
filter_conditions  <- sapply(selected_sectors, function(x) grepl(paste0("\\..*\\.", x, "$"), df1$COORDINATE))
filter_conditions <- apply(filter_conditions, 1, any)
df1_2 <- df1[filter_conditions, ]

df1_2 <- df1_2 |> 
  select(Year, GEO, Prices, Estimates, UOM, SCALAR_FACTOR, VALUE) |>
  filter(Prices %in% c("Current prices", "Chained (2017) dollars")) |>
  group_by(Year, GEO, Prices) |>
  mutate(GDP = first(VALUE[Estimates == "Gross domestic product at market prices"]),
         Estimate_per_GDP = round(100*VALUE/GDP,1))

df1_3 <- df1_2 |>
  group_by(Year, GEO, Prices, UOM, SCALAR_FACTOR ) |>
  filter(
    Estimates %in% c("Non-residential structures, machinery and equipment","Intellectual property products")) |>
  summarise(Estimates = "Non-residential Investment",
            VALUE = sum(VALUE), 
            GDP = min(GDP), 
            Estimate_per_GDP = sum(Estimate_per_GDP)
            ) |>
    ungroup() |>
  select(Year, GEO, Prices, Estimates, UOM, SCALAR_FACTOR, VALUE, GDP, Estimate_per_GDP)
               
df1_2<- merge(df1_2, df1_3, all = TRUE)
            
# write.csv(df1, "~/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)
# write.csv(df1_2, "C:/Users/MNAJI/StrongerBC-Project/Data/Non_Residential_Investment_1.csv", row.names = FALSE)

### Second dataset
selected_sectors <- c(4,8,11,21, 28, 29, 32, 42, 43, 50, 51, 52, 53)
selected_sectors <- as.character(selected_sectors)

df2_1 <- df2 |>
  mutate(extension = sub("^.*\\.", "", COORDINATE))

df2_1 <- df2_1 |>
  filter(extension %in% selected_sectors,
         `Seasonal adjustment` == "Seasonally adjusted at annual rates")|>
  select(Year, GEO, Prices, Estimates, UOM, SCALAR_FACTOR, VALUE)

# write.csv(df2_1, "C:/Users/MNAJI/StrongerBC-Project/Data/Non_Residential_Investment_2.csv", row.names = FALSE)

