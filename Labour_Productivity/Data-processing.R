library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("36-10-0480-01", "eng")

df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

selected_sectors <- c(1, 2, 3, 4, 17, 37, 42, 53, 157, 158, 168, 181, 198, 213, 214, 225, 233, 245, 246, 256, 258, 266, 271, 276, 290, 297, 293, 294, 299, 307, 308, 313, 316, 319, 320)
filter_conditions  <- sapply(selected_sectors, function(x) grepl(paste0("\\..*\\.", x, "$"), df1$COORDINATE))
filter_conditions <- apply(filter_conditions, 1, any)
df2 <- df1[filter_conditions, ]


df2$sector_code <- sapply(strsplit(df2$COORDINATE, split = "\\."), function(x) x[3])

df2 <- df2 |>
  mutate(
    parent = case_when(
      sector_code == 1 ~ "",
      sector_code %in% c(2, 297) ~ "All industries",
      sector_code %in% c(3,157) ~ "Business sector industries",
      sector_code %in% c(4, 17, 37, 42, 53) ~ "Goods-producing businesses",
      sector_code %in% c(158, 168, 181, 198, 213, 214, 225, 233, 245, 246, 256, 258, 266, 271, 276) ~ "Service-producing businesses",
      sector_code %in% c(299, 307) ~ "Non-business sector industries",
      sector_code %in% c(308, 313, 316, 319, 320) ~ "Government sector [GS00]",
      TRUE ~ "NONE"))

df2 <- df2 |>
  group_by(Year, GEO, `Labour productivity and related measures`) |>
  mutate(
    measure = `Labour productivity and related measures`,
    parent_val = case_when(
      sector_code == 1 ~ VALUE[Industry == "All industries"],
      sector_code %in% c(2, 297) ~ VALUE[Industry == "All industries"],
      sector_code %in% c(3,157) ~ VALUE[Industry =="Business sector industries"],
      sector_code %in% c(4, 17, 37, 42, 53) ~ VALUE[Industry =="Goods-producing businesses"],
      sector_code %in% c(158, 168, 181, 198, 213, 214, 225, 233, 245, 246, 256, 258, 266, 271, 276) ~ VALUE[Industry =="Service-producing businesses"],
      sector_code %in% c(299, 307) ~ VALUE[Industry =="Non-business sector industries"],
      sector_code %in% c(308, 313, 316, 319, 320) ~ VALUE[Industry =="Government sector [GS00]"],
      TRUE ~ 0)) |>
  ungroup()

df2 <- df2 |> select(Year, GEO, measure , UOM, Industry, VALUE, parent, parent_val)

df2 <- df2 |> 
  group_by(GEO, measure, UOM, Industry) |>
  arrange(Year) |>
  mutate(Y1_growth = ((VALUE / lag(VALUE, n=1))-1)*100,
         Y3_growht = ((VALUE / lag(VALUE, n=3))-1)*100,
         Y5_growth = ((VALUE / lag(VALUE, n=5))-1)*100) |>
  ungroup()


# write.csv(df1, "~/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)
write.csv(df2, "C:/Users/MNAJI/StrongerBC-Project/Data/Labour_Productivity_1.csv", row.names = FALSE)
