library(skimr)
library(tidyverse)

comm1 = read_csv("uranium.csv")
clean1 = comm1 %>%
  select(Year, Month, Price_uran) %>%
  filter(year >=2000)

print(clean1)
comm2 = read_csv("coal-prices.csv")
comm3 = read_csv("commodity 2000-2022.csv")
