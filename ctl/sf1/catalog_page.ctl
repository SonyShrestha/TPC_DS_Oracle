LOAD DATA
INFILE '../output/generated_data/sf1/catalog_page.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.CATALOG_PAGE
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	cp_catalog_page_sk,
	cp_catalog_page_id,
	cp_start_date_sk,
	cp_end_date_sk,
	cp_department,
	cp_catalog_number,
	cp_catalog_page_number,
	cp_description,
	cp_type 
)
