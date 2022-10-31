# The_Energy_Generators
Group Project Repo for BUS235A

- The link to your data set

https://www.kaggle.com/datasets/kevinmorgado/us-energy-generation-2001-2022  

https://www.kaggle.com/code/bahadirumutiscimen/major-commodity-prices-data-analysis -> for Oil and Natural Gas  

https://www.kaggle.com/datasets/timmofeyy/-metals-price-changes-within-last-30-years -> for Uranium  

https://ourworldindata.org/grapher/coal-prices?country=~US+Central+Appalachian+coal+spot+price+index+%28BP%29 -> for Coal (may need a different set)  

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

── Data Summary ────────────────────────
                           Values
Name                       comm4 
Number of rows             496774
Number of columns          7     
_______________________          
Column type frequency:           
  character                3     
  numeric                  4     
________________________         
Group variables            None  

── Variable type: character ─────────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable    n_missing complete_rate min max empty n_unique whitespace
1 STATE                    0             1   2   8     0       52          0
2 TYPE OF PRODUCER         0             1  29  48     0        6          0
3 ENERGY SOURCE            0             1   4  30     0       14          0

── Variable type: numeric ───────────────────────────────────────────────────────────────────────────────────────────────────────────
  skim_variable              n_missing complete_rate       mean          sd      p0  p25    p50     p75      p100 hist 
1 ...1                               0             1   18143.      13387.         0 7762 15853   24178      65144 ▇▇▂▁▁
2 YEAR                               0             1    2012.          6.17    2001 2006  2012    2017       2022 ▇▆▆▇▇
3 MONTH                              0             1       6.43        3.46       1    3     6       9         12 ▇▆▅▅▇
4 GENERATION (Megawatthours)         0             1 1393384.   10786846.   -997855 1643 23301. 279204. 421796659 ▇▁▁▁▁




- A discussion of the skim output. Do the values seem reasonable or are there some that aren't what you expected or that don't make sense?

The main data set is relatively clean, there are a few data points that probably need to be removed. For instance in the skim there is negative megawatt hour generation value in the P0 col which does not make sense. It seems the negative values are related to "Pumped Storage". This will need further investigation.

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

At one point with only limited number of rows the original coal price csv was easier to edit by removing the other regions(non-us) than through R parsing.  


