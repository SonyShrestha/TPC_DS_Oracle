LOAD DATA
INFILE '../output/generated_data/sf1/time_dim.dat'
TRUNCATE
INTO TABLE DW_TPCDS_SF1.TIME_DIM
FIELDS TERMINATED BY "|" OPTIONALLY ENCLOSED BY '"' TRAILING NULLCOLS
(
	t_time_sk,
	t_time_id,
	t_time,
	t_hour,
	t_minute,
	t_second,
	t_am_pm,
	t_shift,
	t_sub_shift,
	t_meal_time
)
