library(skimr)
library(tidyverse)

comm1 = read_csv("uranium_and_metals.csv")
clean1 = comm1 %>%
  select(Year, Month, Price_uran) %>%
  filter(Year >=2000)
write_csv(clean1, "uranium.csv")

comm2 = read_csv("coal-prices.csv")
clean2 = comm2 %>%
  select(Year,Price_coal)
write_csv(clean2, "coal.csv")

comm3 = read_csv("commodity 2000-2022.csv")

clean3 = comm3 %>%
  select(Symbol,Date,Close) %>%
  filter(Symbol == "Brent Oil" | Symbol == "Natural Gas") %>%
  pivot_wider(names_from = Symbol, values_from = Close) %>%
  rename(Price_oil = "Brent Oil", Price_natural_gas = "Natural Gas")
print(clean3)
write_csv(clean3, "OilandGas.csv")
  
organised_Gen = read_csv("organised_Gen.csv")
OilandGas = read_csv("OilandGas.csv")
coal = read_csv("coal.csv")
uranium = read_csv("uranium.csv")
skim(organised_Gen)
skim(OilandGas)
skim(coal)
skim(uranium)

