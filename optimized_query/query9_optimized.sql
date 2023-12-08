spool &1
timing start t

alter system flush shared_pool;

SELECT 
	* 
FROM (
	SELECT 
		bucket, 
	CASE 
		WHEN bucket=1 AND cnt>25437 THEN ss_ext_discount_amt 
		WHEN bucket=2 AND cnt>22746 THEN ss_ext_discount_amt 
		WHEN bucket=3 AND cnt>9387 THEN ss_ext_discount_amt 
		WHEN bucket=4 AND cnt>10098 THEN ss_ext_discount_amt 
		WHEN bucket=5 AND cnt>18213 THEN ss_ext_discount_amt 
		ELSE ss_net_profit END AS value 
	FROM (
		SELECT 
			bucket,
			count(*) cnt,
			avg(ss_ext_discount_amt) ss_ext_discount_amt,
			avg(ss_net_profit) ss_net_profit FROM (
				SELECT 
					ss_ext_discount_amt, 
					ss_net_profit,
					CASE 
						WHEN  ss_quantity BETWEEN 1 AND 20 THEN 1
						WHEN ss_quantity BETWEEN 21 AND 40 THEN 2
						WHEN  ss_quantity BETWEEN 41 AND 60 THEN 3
						WHEN ss_quantity BETWEEN 61 AND 80 THEN 4
						WHEN ss_quantity BETWEEN 81 AND 100 THEN 5 
					END AS bucket 
				FROM  store_sales
			) GROUP BY bucket 
		)
)
PIVOT (SUM (value) AS sum_value FOR(bucket) IN (
	1 AS Bucket1,
	2 AS Bucket2,
	3 AS Bucket3,
	4 AS Bucket4,
	5 AS Bucket5)
);

timing stop
spool off
exit
