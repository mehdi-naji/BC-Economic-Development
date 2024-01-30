library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)

df1 <- statcan_download_data("36-10-0480-01", "eng")

df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)

selected_sectors <- c(1, 2, 3, 4, 17, 37, 42, 53, 157, 158, 168, 181, 198, 213, 214, 225, 233, 245, 246, 256, 258, 266, 271, 276, 297, 299, 307, 308, 313, 316, 319, 320)
filter_conditions  <- sapply(selected_sectors, function(x) grepl(paste0("\\..*\\.", x, "$"), df1$COORDINATE))
filter_conditions <- apply(filter_conditions, 1, any)
df2 <- df1[filter_conditions, ]


df2$sector_code <- sapply(strsplit(df2$COORDINATE, split = "\\."), function(x) x[3])

df2 <- df2 |>
  mutate(parent = case_when(
    sector_code == 1 ~ "",
    sector_code %in% c(2, 297) ~ "All Industries",
    sector_code %in% c(3,157) ~ "Business Sector Industries",
    sector_code %in% c(4, 17, 37, 42, 53) ~ "Goods-producing Businesses",
    sector_code %in% c(158, 168, 181, 198, 213, 214, 225, 233, 245, 246, 256, 258, 266, 271, 276) ~ "Service-producing Businesses",
    sector_code %in% c(299, 307) ~ "Non-business Sector Industries",
    sector_code %in% c(308, 313, 316, 319, 320) ~ "Government Sector",
    TRUE ~ "NONE"
  ))

df2 <- df2 |> select(Year, GEO, `Labour productivity and related measures`, UOM, Industry, VALUE, parent)

# write.csv(df1, "~/StrongerBC-Project/Data/VA_Exporsts_1.csv", row.names = FALSE)
write.csv(df2, "C:/Users/mehdi/StrongerBC-Project/Data/Labour_Productivity_1.csv", row.names = FALSE)

