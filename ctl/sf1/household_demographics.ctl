LOAD DATA
INFILE '../output/generated_data/sf1/household_demographics.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.HOUSEHOLD_DEMOGRAPHICS
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	hd_demo_sk,
	hd_income_band_sk,
	hd_buy_potential,
	hd_dep_count,
	hd_vehicle_count
)