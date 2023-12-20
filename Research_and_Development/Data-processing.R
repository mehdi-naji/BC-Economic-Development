library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)


# GDP ----
df1 <- statcan_download_data("27-10-0273-01", "eng")
df2 <- statcan_download_data("27-10-0273-02", "eng")

df1$REF_DATE <- ymd(df1$REF_DATE)
df2$REF_DATE <- ymd(df2$REF_DATE)

df1$Year <- year(df1$REF_DATE)
df2$Year <- year(df2$REF_DATE)

df1 <- select(df1, Year, GEO, Funder, Performer, `Science type`, Prices, VALUE)
df2 <- select(df2, Year, GEO, Funder, Performer, `Science type`, Prices, VALUE)

write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

