# 🏡 Statistical Analysis of Stockholm Housing Market  

This project presents a **statistical analysis of housing market data in Stockholm**, focusing on factors that influence housing prices such as **area, region, type, balcony, and rooms**.  

The analysis was carried out in **R** using packages like `dplyr`, `mosaic`, and `DescTools`.  

---

## 📂 Dataset  
- **File:** `dataset03.xlsx`  
- **Variables:**  
  - `STARTING_PRICE` – starting price of housing units  
  - `REGION` – geographic location (Stockholm, Northwest, Northeast, etc.)  
  - `TYPE` – housing type (apartment, villa, etc.)  
  - `BALCONY` – presence of a balcony (Yes/No)  
  - `ROOMS` – number of rooms  
  - `AREA` – size of the property (in square meters)  

---

## 🔍 Analysis Overview  

### 1. Descriptive Statistics  
- Mean starting price: **4,273,799 SEK**  
- Median: **3,495,000 SEK**  
- Skewness: **2.06 (right-skewed)**  
- Outliers: **32 properties** above 9,495,000 SEK  

📊 Histogram & boxplot reveal heavy right-tail distribution.  

---

### 2. Housing Type by Region  
- Apartments dominate in **all regions**, especially in **Stockholm** and **Northwest**.  

---

### 3. Area by Region  
- **Northeast** → highest mean & median housing area  
- **Stockholm** → smaller, more uniform housing sizes  

---

### 4. Correlation: Area vs Price  
- Pearson’s correlation coefficient: **0.62** → moderate positive relationship  

---

### 5. Regression Models  

#### 📈 Simple Linear Regression  
