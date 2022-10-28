# The_Energy_Generators
Group Project Repo for BUS235A

- The link to your data set

https://www.kaggle.com/datasets/kevinmorgado/us-energy-generation-2001-2022


- The code that you used to load your data into R

  energy <- read_csv("organised_Gen.csv")


- A bullet-point list or table with an entry for each column in your data. For each column, explain in plain English what the data in the column represents (including units, if it is a numeric column).


  # : Row count (numeric) per year
  YEAR : Year (Numeric) energy was generated
  MONTH : Month (Numeric 2001-2022) energy was generated
  STATE : US State (abbreviated) energy was generated
  TYPE OF PRODUCER : List of types of energy producers
  ENERGY SOURCE : List of energy sources
  GENERATION (megawatthours) : Energy generated in megawatthours (Numeric)




- The output of running a skim() on your data.

```{r}
skim(energy)
```
── Data Summary ────────────────────────
                           Values
Name                       energy
Number of rows             496774
Number of columns          7     
_______________________          
Column type frequency:           
  character                3     
  numeric                  4     
________________________         
Group variables            None  





- A discussion of the skim output. Do the values seem reasonable or are there some that aren't what you expected or that don't make sense?





- Any code that you used to check and clean up your data after loading it, such as checking the types of the columns, converting data to the proper type if needed, naming columns, etc.

The start of formatting the price data, sourced from various other data sources then the original energy data set. Pulling in the various csv files in their own formats and making adjustments to a common format with just the data of interest. 

```
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
```


- A discussion of any problems that you encountered during the loading, checking, and cleaning process. Include how you handled any problems and what problems are unresolved.

One of the price data sets does not have the monthly fidelity that the overall energy generation data set has, additionally price may be more dependent on region for coal plants which is not feasible to transport in many cases. There is an unresolved issue of relating the price to the generation. Either the generation will have to be summarized to the year or the yearly price data extrapolated. 


