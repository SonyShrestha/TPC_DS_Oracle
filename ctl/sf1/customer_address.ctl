LOAD DATA
INFILE '../output/generated_data/sf1/customer_address.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.CUSTOMER_ADDRESS
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	ca_address_sk,
	ca_address_id,
	ca_street_number,
	ca_street_name,
	ca_street_type,
	ca_suite_number,
	ca_city,
	ca_county,
	ca_state,
	ca_zip,
	ca_country,
	ca_gmt_offset,
	ca_location_type	
)

