
#load data
data = readRDS("STEP_UP_REGIONAL_ANTIDEPRESSANTS.Rds")
head(data, n=20)
tail(data, n=20)
summary(data)

# Load libraries
library(dplyr)
library(tidyr)


#DATA_AGGREGATION


#how many drugs?=32
data %>% 
  select(DRUG) %>% 
  distinct()

#How many regions? = 7
data %>% 
  select(REGION) %>% 
  distinct()

# what region has prescribed the most anti-depressant?
data %>% 
  group_by(REGION) %>% 
  summarise(Total_prescription = sum(ITEMS)) %>% 
  ungroup() %>% 
  arrange(desc(Total_prescription))

# QUESTION 1: Nationally, calculate the top 10 prescribed anti-depressants across the whole time frame, sorted from biggest from smallest.

data %>% 
  group_by(DRUG) %>% 
  summarise(ITEMS = sum(ITEMS)) %>% 
  ungroup() %>% 
  top_n(10, ITEMS) %>% 
  arrange(desc(ITEMS))

# Question 2: Calculate the monthly national cost of Mirtazapine prescribing 

data %>% 
  filter(DRUG == "Mirtazapine") %>% 
  group_by(YM,DRUG) %>% 
  summarise(TOTAL_COST = sum(COST)) %>%
  ungroup() %>% 
  print(n=50)

#Question 3: What is the annual spend of Sertraline hydrochloride prescribing 
#in the Midlands region?

data %>% 
  filter(DRUG == "Sertraline hydrochloride", REGION == "MIDLANDS") %>% 
  group_by(YEAR,DRUG,REGION) %>% 
  summarise(TOTAL_COST = sum(COST)) %>%
  ungroup()

# Question 4: Create a (pivoted) table that shows the cost of anti-depressant prescribing per region per year?

data %>% 
  group_by(YEAR, REGION) %>% 
  summarise(COST = sum(COST)) %>% 
  ungroup() %>% 
  pivot_wider(names_from = REGION, values_from = COST) 

#Contrast of Volume vs Cost by Drug:
data %>%
  group_by(DRUG) %>%
  summarise(total_items = sum(ITEMS),
            total_cost = sum(COST)) %>%
  arrange(desc(total_items))



#DATA_VISUALISATION

library(highcharter)

# Question 1: Create a horizontal bar chart of the top 5 most prescribed drugs in 2024, arranged in order.

# Data
df_bar = data %>% 
  filter(YEAR == 2024) %>% 
  group_by(DRUG) %>% 
  summarise(ITEMS = sum(ITEMS)) %>% 
  ungroup() %>% 
  top_n(5, ITEMS) %>% 
  arrange(ITEMS)
# Chart
hchart(df_bar, "bar", hcaes(DRUG, ITEMS)) %>% 
  hc_yAxis(title = list(text = "Total number of items")) %>% 
  hc_xAxis(title = list(text = "Drug name")) %>% 
  hc_title(text = "The top 5 nationally prescribed antidepressants in 2024")

# Question 2: Create a vertical bar chart showing the total annual cost of Sertraline hydrochloride prescribing in the NORTH EAST region.

# Data
df_column = data %>% 
  filter(
    REGION == "NORTH EAST AND YORKSHIRE",
    DRUG == "Sertraline hydrochloride"
  ) %>% 
  group_by(YEAR) %>% 
  summarise(COST = sum(COST)) %>% 
  ungroup()
# Chart
hchart(df_column, "column", hcaes(YEAR, COST)) %>% 
  hc_yAxis(title = list(text = "Cost in millions (£)")) %>% 
  hc_xAxis(title = list(text = "Year")) %>% 
  hc_title(text = "The annual prescribing cost of sertraline hydrochloride in the North East & Yorkshire region")

# Question 3: Create a line chart of the nationally monthly cost (rounded to the nearest pound) of escitalopram.

# Data
df_line = data %>% 
  filter(DRUG == "Escitalopram") %>% 
  group_by(YM) %>% 
  summarise(COST = round(sum(COST))) %>% 
  ungroup()
# chart
hchart(df_line, "line", hcaes(YM, COST)) %>% 
  hc_yAxis(min = 0, title = list(text = "Cost (£)")) %>% 
  hc_xAxis(title = list(text = "Year-month")) %>% 
  hc_title(text = "The national monthly prescribing cost of escitalopram")


#4: National monthly prescribing volume trend
df_monthly_items = data %>%
  group_by(YM) %>%
  summarise(ITEMS = sum(ITEMS)) %>%
  ungroup()
#Chart
hchart(df_monthly_items, "line", hcaes(YM, ITEMS)) %>%
  hc_yAxis(title = list(text = "Items prescribed")) %>%
  hc_xAxis(title = list(text = "Year-Month")) %>%
  hc_title(text = "National monthly prescribing volume trend")





#DATA_METRICS_AND_INSIGHTS


extension_data = readRDS("EXTENSION_STEP_UP_REGIONAL_ANTIDEPRESSANTS.Rds")

# Question 1: For context, create a monthly line chart showing total national prescribing cost
extension_data %>% 
  group_by(YM) %>%
  summarise(COST = sum(COST)) %>% 
  ungroup() %>% 
  hchart("line", hcaes(YM, COST)) %>% 
  hc_yAxis(min = 0) %>% 
  hc_yAxis(title = list(text = "Cost (£)")) %>% 
  hc_xAxis(title = list(text = "Year-month")) %>% 
  hc_title(text = "The national monthly total prescribing cost from January 2021 until December 2024")

# Question 2: Create *annual* summary statistics, for the min, Q1, median, Q3 and maximum national monthly prescribing cost (i.e. all drugs across all regions)
extension_data %>% 
  group_by(YEAR, YM) %>%
  summarise(COST = sum(COST)) %>% 
  ungroup() %>% 
  group_by(YEAR) %>% 
  summarise(
    min = min(COST),
    Q1 = quantile(COST, 0.25),
    median = median(COST),
    Q3 = quantile(COST, 0.75),
    max = max(COST)
  ) %>% 
  ungroup()

# Question 3: create a grouped boxplot that shows the above information (4 boxplots, 1 per year)

# Data
box = extension_data %>% 
  group_by(YM, YEAR) %>% 
  summarise(COST = sum(COST)) %>% 
  ungroup()
# Chart
hcboxplot(x = box$COST, var = box$YEAR) %>% 
  hc_yAxis(title = list(text = "Cost (£)")) %>% 
  hc_xAxis(title = list(text = "Year")) %>% 
  hc_title(text = "The distribution of monthly national prescribing costs per year, from 2021 to 2024")

# Question 4: calculate the annual *mean* monthly total national prescribing cost and display in a vertical barchart
extension_data %>% 
  group_by(YEAR, YM) %>%
  summarise(COST = sum(COST)) %>% 
  ungroup() %>% 
  group_by(YEAR) %>% 
  summarise(COST = mean(COST)) %>% 
  ungroup() %>% 
  hchart("column", hcaes(YEAR, COST)) %>% 
  hc_yAxis(title = list(text = "Mean monthly prescribing cost (£)")) %>% 
  hc_xAxis(title = list(text = "Year")) %>% 
  hc_title(text = "The national mean monthly prescribing cost across all prescribing, from 2021 to 2024")

# Question 5: Create a monthly line chart, which shows what percentage of *national* prescribing is from the '02: Cardiovascular System' BNF_CHAPTER.
extension_data %>% 
  mutate(CARDIO_COST = ifelse(BNF_CHAPTER == "02: Cardiovascular System", COST, 0)) %>% 
  group_by(YM) %>% 
  summarise(
    COST = sum(COST),
    CARDIO_COST = sum(CARDIO_COST)
  ) %>% 
  ungroup() %>% 
  mutate(CARDIO_PCT = round(100 * CARDIO_COST / COST, 2)) %>% 
  hchart("line", hcaes(YM, CARDIO_PCT)) %>% 
  hc_yAxis(min = 0, title = list(text = "Percentage of prescribing (%)")) %>% 
  hc_xAxis(title = list(text = "Year-month")) %>% 
  hc_title(text = "The percentage of prescribing cost from the Cardiovascular System BNF Chapter out of all prescribing cost, in England from January 2021 to December 2024")
