LOAD DATA
INFILE '../output/generated_data/sf1/customer_demographics.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.CUSTOMER_DEMOGRAPHICS
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	cd_demo_sk,
	cd_gender,
	cd_marital_status,
	cd_education_status,
	cd_purchase_estimate,
	cd_credit_rating,
	cd_dep_count,
	cd_dep_employed_count,
	cd_dep_college_count
)
