LOAD DATA
INFILE '../output/generated_data/sf1/income_band.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.INCOME_BAND
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	ib_income_band_sk,
	ib_lower_bound,
	ib_upper_bound
)