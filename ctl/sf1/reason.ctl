LOAD DATA
INFILE '../output/generated_data/sf1/reason.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.REASON
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	r_reason_sk,
	r_reason_id,
	r_reason_desc
)