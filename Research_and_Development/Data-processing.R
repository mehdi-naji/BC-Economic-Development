library(statcanR)
library(dplyr)
library(tidyverse)
library(lubridate)
library(stringr)



# GDP ----
df1 <- statcan_download_data("27-10-0273-01", "eng")
df2 <- statcan_download_data("27-10-0273-02", "eng")

df1$REF_DATE <- ymd(df1$REF_DATE)
df2$REF_DATE <- ymd(df2$REF_DATE)

df1$Year <- year(df1$REF_DATE)
df2$Year <- year(df2$REF_DATE)

df1 <- df1 |> filter (Prices %in% c("Current prices", "2012 constant prices"))
df2 <- df2 |> filter (Prices %in% c("Current prices", "2012 constant prices"))

df1 <- select(df1, Year, GEO, Funder, Performer, `Science type`, Prices, VALUE)
df2 <- select(df2, Year, GEO, Funder, Performer, `Science type`, Prices, VALUE)


df1 |> 
  mutate(
    Funder_color = case_when(
      str_detect(Funder, "total") ~ 1,
      str_detect(Funder, "provincial governments") ~ 2,
      str_detect(Funder, "business enterprise") ~ 3,
      str_detect(Funder, "private non-profit") ~ 4,
      str_detect(Funder, "federal government") ~ 5,
      str_detect(Funder, "provincial research organizations") ~ 6,
      str_detect(Funder, "higher education") ~ 7,
      str_detect(Funder, "foreign sector") ~ 8,
      TRUE ~ NA_real_),
    Performer_color = case_when(
      str_detect(Performer, "total") ~ 1,
      str_detect(Performer, "provincial governments") ~ 2,
      str_detect(Performer, "business enterprise") ~ 3,
      str_detect(Performer, "private non-profit") ~ 4,
      str_detect(Performer, "federal government") ~ 5,
      str_detect(Performer, "provincial research organizations") ~ 6,
      str_detect(Performer, "higher education") ~ 7,
      TRUE ~ NA_real_)
  )
# write.csv(df1, "~/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
# write.csv(df2, "~/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)

write.csv(df1, "C:/Users/mehdi/StrongerBC-Project/Data/Research_and_Development_1.csv", row.names = FALSE)
write.csv(df2, "C:/Users/mehdi/StrongerBC-Project/Data/Research_and_Development_2.csv", row.names = FALSE)


