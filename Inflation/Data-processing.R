library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



df1 <- statcan_download_data("18-10-0004-01", "eng")
df1$REF_DATE <- ymd(df1$REF_DATE)
df1$Year <- year(df1$REF_DATE)
df1$Month <- month(df1$REF_DATE)
df1_1 <- df1 |> 
  filter (Year >= 2000,
          UOM == "2002=100")|>
  select (Year, Month, GEO, `Products and product groups`, UOM, COORDINATE, VALUE, INDICATOR)
    
write.csv(df1_1, "C:/Users/mehdi/StrongerBC-Project/Data/Price_Index_1.csv", row.names = FALSE)
# write.csv(df1_1, "~/StrongerBC-Project/Data/Price_Index_1.csv", row.names = FALSE)

        
