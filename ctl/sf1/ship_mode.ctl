LOAD DATA
INFILE '../output/generated_data/sf1/ship_mode.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.SHIP_MODE
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	sm_ship_mode_sk,
	sm_ship_mode_id,
	sm_type,
	sm_code,
	sm_carrier,
	sm_contract
)