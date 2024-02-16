library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)
library(zoo)

df1 <- statcan_download_data("18-10-0004-01", "eng") 
df2 <- statcan_download_data("18-10-0256-01", "eng")
df3 <- statcan_download_data("10-10-0106-01", "eng")

dating <- function(df, column) {
  df[[column]] <- ymd(df[[column]])
  df$Year <- year(df[[column]])
  df$Month <- month(df[[column]])
  df$Month <- sprintf("%02d", df$Month)
  df$YearMonth <- paste(df$Year, df$Month, "01", sep="-")
  df$YearMonth <- as.Date(df$YearMonth, format="%Y-%m-%d")
  df$YearMonth <- format(as.Date(df$YearMonth), "%Y-%m")
  return(df)
}


df1 <- dating(df1, "REF_DATE")
df2 <- dating(df2, "REF_DATE")


df1_1 <- df1|>
  filter (Year >= 2000,
          UOM == "2002=100",
          `Products and product groups` %in% c(
            "All-items",
            "Food",
            "Shelter",
            "Clothing and footwear", 
            "Transportation",
            "Health and personal care",
            "Recreation, education and reading",
            "Goods",
            "Services"))|>
  select (YearMonth, Year, Month, GEO, `Products and product groups`, COORDINATE, VALUE)


df_t1 <- df1|>
  filter (Year >= 2000,
          UOM == "2002=100",
          GEO == "Canada",
          `Products and product groups` %in% c(
            "Services excluding shelter services",
            "Shelter",
            "Goods excluding food purchased from stores and energy",
            "Energy", 
            "Food purchased from stores"))|>
  select (YearMonth, GEO, `Products and product groups`, VALUE) |> 
  group_by(GEO, `Products and product groups`)|>
  arrange(YearMonth) |>
  mutate(Y_o_Y_inf = round((VALUE-lag(VALUE))/lag(VALUE)*100,2)) |>
  ungroup()

# Monthly Inflation
df1_1 <- df1 |> 
  group_by(GEO, `Products and product groups`, COORDINATE)|>
  arrange(YearMonth) |>
  mutate(MnthInf = round((VALUE-lag(VALUE))/lag(VALUE)*100,2)) |>
  ungroup()

# Annualized Monthly Inflation
df1_1 <- df1_1 |> 
  mutate(AnnMnthInf = round(((1+MnthInf/100)^12-1)*100,2))


# Average past 12 month inflation
df1_1 = df1_1 |>
  arrange(YearMonth) |>
  mutate(Y_o_Y_inf = round((VALUE/lag(VALUE,12)-1)*100,2))


df1_2 <- df1_1 |>
  filter(
    GEO == "Canada",
    `Products and product groups` == "All-items")|>
  select(Year, Month, YearMonth, VALUE, MnthInf, AnnMnthInf, AnnInf)

df2_1 <- df2 |> 
  filter(
    Year >= 2000,
    str_detect(`Alternative measures`, "core inflation"),
    str_detect(`Alternative measures`, "year-over-year")) |>
  select(`Alternative measures`, VALUE, Year, Month, YearMonth)
df2_1 <- na.omit(df2_1)

df2_2 <- df2_1 |>
  pivot_wider(names_from = `Alternative measures`, values_from = VALUE)

df3 <- merge(df2_2, df1_2)
colnames(df3) <- c("Year", "Month", "YearMonth", "CoreFactor", "CoreWeighted", "CoreTrim", "Geo", "Products", "Coordinate", "CPI", "MnthInf", "AnnMnthInf", "AnnInf")

write.csv(df1_1, "C:/Users/mehdi/StrongerBC-Project/Data/Price_Index_1.csv", row.names = FALSE)
write.csv(df3, "C:/Users/mehdi/StrongerBC-Project/Data/Core_Inflation_1.csv", row.names = FALSE)
write.csv(df_t1, "C:/Users/mehdi/StrongerBC-Project/Data/tableau_inflation_1.csv", row.names = FALSE)

# write.csv(df1_1, "~/StrongerBC-Project/Data/Price_Index_1.csv", row.names = FALSE)
# write.csv(df3, "~/StrongerBC-Project/Data/Core_Inflation_1.csv", row.names = FALSE)

