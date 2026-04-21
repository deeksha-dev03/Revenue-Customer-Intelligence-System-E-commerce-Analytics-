# Revenue & Customer Intelligence System
**Tech Stack:** SQL -- Python (Pandas, NumPy, Matplotlib, Seaborn) -- Power BI

## Business Problem
E-commerce businesses generate large volumes of transactional data but often lack clear visibility into:
- Revenue drivers
- Customer behavior & retention
- Product performance
- Operational efficiency (delivery performance)
This leads to inefficient marketing spend, poor retention, and missed growth opportunities.
**This project builds an end-to-end analytics system to convert raw data into actionable business insights.**
  

## Objectives
- Analyze revenue trends and seasonality
- Identify high-performing product categories
- Segment customers based on behavior (RFM)
- Evaluate customer retention (repeat vs one-time)
- Measure delivery performance impact


## Dataset
- 100K+ e-commerce transaction records
- Tables: Customers, Orders, Products, Payments, Reviews
- Source: Olist Brazilian E-Commerce – Kaggle
**Note: Original dataset is not uploaded due to size issue.So, cleaned data is uploaded.**


## Approach
### 1. Data Preparation (SQL + Python) 
- Cleaned inconsistent timestamps and handled missing values
- Built structured SQL views: **clean_orders**, **order_features**
- Merged multiple tables into a unified dataset
- Corrected data types and ensured data integrity

### 2. Feature Engineering 
| Feature | Description |
|---|---|
| Order Month | For time-series trend analysis |
| Delivery Time | Days between order and delivery |
| Customer Type | Repeat vs One-time buyer flag |
| CLV | Customer Lifetime Value calculation |

### 3. Analysis Performed 
- Revenue & order trend analysis (monthly/seasonal)
- RFM Segmentation — Recency, Frequency, Monetary scoring
- Customer Lifetime Value (CLV) modeling
- Product & category performance breakdown
- Payment method distribution analysis
- Delivery performance evaluation  

### 4. Dashboard Development 
Built an interactive dashboard in Power BI with:
- Executive Dashboard – KPI overview & trends
- Revenue Analysis – category & product insights
- Customer Intelligence – segmentation & behavior


## Key Insights
- **~72%** of customers made only one purchase, indicating a strong customer retention gap  
- Top **3** product categories contributed **~58%** of total revenue, confirming the Pareto  principle  
- Repeat customers generate **~2.1×** higher revenue per user than one-time buyers  
- Average delivery time is **~12 days**, with a wide range of **3–30 days**, indicating inconsistent logistics performance  
- RFM segmentation identified **~8%** of customers as high-value, contributing approximately **~35–40%** of total revenue  


## Dashboard
### Executive Dashboard
Executive Dashboard(dashboard_images/executive_dashboard.png)

### Revenue Analysis
Revenue Analysis(dashboard_images/revenue_analysis.png)

### Customer Intelligence
Customer Intelligence(dashboard_images/customer_intelligence.png)


## Business Impact
| Area | Insight | Action |
|---|---|---|
| Retention | High one-time buyer rate | Targeted re-engagement campaigns |
| Revenue | Category concentration | Focus inventory & pricing on top SKUs |
| Marketing | RFM-based segments | Personalized campaigns by customer tier |
| Operations | Delivery time variance | Logistics partner performance review |


## Conclusion
This project demonstrates the ability to:
- Translate raw data into business insights
- Apply analytical thinking to real-world problems
- Build scalable analytics workflows
- Communicate insights through interactive dashboards

## How to Run
- Run SQL scripts (ecommerce_analysis.sql) for data extraction and transformation
- Use Python notebook (analysis.ipynb) for EDA and RFM segmentation
- Open Power BI file (dashboard.pbix) to interact with dashboards
