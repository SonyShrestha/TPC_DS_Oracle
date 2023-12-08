spool &1
timing start t

alter system flush shared_pool;

SELECT 
  * 
FROM (
  SELECT 
    flag,
    count(*) AS value 
  FROM (
    SELECT 
    CASE 
      WHEN time_dim.t_hour = 8 AND time_dim.t_minute >= 30 THEN 1
      WHEN time_dim.t_hour = 9 AND time_dim.t_minute < 30 THEN 2
      WHEN time_dim.t_hour = 9 AND time_dim.t_minute >= 30 THEN 3
      WHEN time_dim.t_hour = 10 AND time_dim.t_minute < 30 THEN 4
      WHEN  time_dim.t_hour = 10 AND time_dim.t_minute >= 30 THEN 5
      WHEN time_dim.t_hour = 11 AND time_dim.t_minute < 30 THEN 6
      WHEN time_dim.t_hour = 11 AND time_dim.t_minute >= 30 THEN 7
      WHEN time_dim.t_hour = 12 AND time_dim.t_minute < 30 THEN 8 
    END AS flag 
    FROM store_sales, household_demographics , time_dim, store
    WHERE 
        ss_sold_time_sk = time_dim.t_time_sk   
        AND ss_hdemo_sk = household_demographics.hd_demo_sk 
        AND ss_store_sk = s_store_sk
        AND (
            (household_demographics.hd_dep_count = 3 AND household_demographics.hd_vehicle_count<=5) OR
            (household_demographics.hd_dep_count = 0 AND household_demographics.hd_vehicle_count<=2) OR
            (household_demographics.hd_dep_count = 1 AND household_demographics.hd_vehicle_count<=3)
        ) 
        AND store.s_store_name = 'ese'
     )
     GROUP BY flag
)
PIVOT (
  SUM (value) AS sum_value FOR (flag) IN (
    1 AS Bucket1,
    2 AS Bucket2,
    3 AS Bucket3,
    4 AS Bucket4,
    5 AS Bucket5,
    6 AS Bucket6,
    7 AS Bucket7,
    8 AS Bucket8
  )
);


timing stop
spool off
exit
