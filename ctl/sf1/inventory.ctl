LOAD DATA
INFILE '../output/generated_data/sf1/inventory.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.INVENTORY
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	inv_date_sk,
	inv_item_sk,
	inv_warehouse_sk,
	inv_quantity_on_hand
)