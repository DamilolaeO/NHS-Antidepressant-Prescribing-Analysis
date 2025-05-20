 # NHS Antidepressant Prescribing Analysis

## **Overview**

This project explores national and regional antidepressant prescription patterns using NHS data (2021–2024). It was developed in response to a real-world public health challenge and uses R to analyse trends in prescribing **volume**, **cost**, and **drug-level behaviour** over time. The analysis includes data wrangling, interactive visualisation, and summary insight reporting using R Markdown and `highcharter`.

---

## **Objective**

To build awareness around the rise in antidepressant prescribing in England and to support NHS decision-making by uncovering:

* National and regional trends in prescribing volume and cost
* The most prescribed and highest-cost antidepressants
* Monthly trends and seasonal variations
* Drug-level case study insights (e.g. Sertraline)

The findings inform equitable, cost-effective prescribing practices and support data-driven strategies for mental health service delivery.

---

## **Tools Used**

* **Language:** R
* **Libraries:** `tidyverse`, `dplyr`, `tidyr`, `lubridate`, `highcharter`, `knitr`, `scales`, `base R`
* **Reporting Format:** R Markdown (`.Rmd`) knitted to HTML
* **Data Format:** RDS files (`.Rds`) from NHS

---

## **Data Workflow**

### 1. Data Preparation

* Loaded and cleaned two RDS datasets (primary and extension)
* Standardised date formats and grouped data by year, month, region, and drug
* Created summary datasets for total items, total cost, and top drugs

### 2. Exploratory Analysis

* Created interactive bar charts of annual prescribing volume and cost
* Produced tables of regional prescribing statistics using `kable`
* Highlighted discrepancies between high-volume and high-cost drugs

### 3. Longitudinal Trend Analysis

* Generated monthly time series for total items and cost
* Analysed the top 5 most prescribed drugs over time
* Explored seasonal dips and sudden cost shifts

### 4. Drug-Level Case Study

* Focused on Sertraline Hydrochloride: the most prescribed antidepressant
* Calculated and visualised monthly **mean cost per item**
* Identified a **cost dip in 2022**, likely due to pricing policy or generic uptake

---

## **Key Findings**

* Antidepressant item volume increased steadily from 2021–2024
* Total cost **decreased significantly in 2022**, despite rising volumes
* Sertraline and Amitriptyline were the most prescribed drugs; Venlafaxine was high-cost despite lower volume
* Regional differences in prescribing patterns indicate varied cost-efficiency
* Sertraline’s mean cost dipped from 2022 and stabilised, showing price fluctuation

---

## **Visuals Included**

* Interactive bar charts of total prescribing volume and cost
* Tables comparing regional prescribing (items & cost) from 2021–2024
* Horizontal bar charts of top 10 drugs by volume and cost
* Line charts of monthly trends and drug-specific case study (Sertraline)

---

## **Recommendations**

* **Monitor high-volume drugs** like Sertraline for cost-efficiency and pricing shifts
* **Reduce regional variation** by promoting standardised prescribing protocols
* **Encourage use of generics** to manage rising prescribing volumes within budget
* **Integrate prescribing and outcomes data** to inform more targeted interventions
* **Strengthen non-drug mental health support** to reduce medication reliance

---

##  **Business Impact**

This analysis supports NHS strategic planning by:

* Revealing cost-volume mismatches and regional prescribing trends
* Highlighting opportunities to manage rising mental health drug demand efficiently
* Informing data-led policy to improve mental health outcomes while controlling cost
* Advancing public good by ensuring patients receive effective, affordable treatment

---

## **Files in this Repository**

* `NHS1-Mental-health.Rmd`: Full R Markdown analysis script
* `NHS2-Mental-health.html`: Interactive knitted report
* `README.md`: Project documentation


---

## **Acknowledgements**

This project was completed as part of a real-world NHS public health data challenge focused on mental health prescribing.

The data used in this project comes from the NHSBSA Open Data Portal, specifically the Prescription Cost Analysis dataset. This open source dataset provides monthly prescribing data from all GP practices in England and reflects real-world antidepressant prescribing volumes and costs. It is freely shareable and contains no security restrictions.

---

## 👩️‍💻 **Author**

**Damilola Ogungbemi**
MSc Biotechnology | Data Scientist | *Passionate about using data for public good in healthcare and policy*.
