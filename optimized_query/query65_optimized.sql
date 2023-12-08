spool &1
timing start t

alter system flush shared_pool;

SELECT s_store_name, i_item_desc, revenue
FROM store, item,
(
  SELECT ss_store_sk, ss_item_sk, revenue,
  AVG(revenue) OVER (PARTITION BY
  ss_store_sk) avgR
  FROM (
    SELECT 
      ss_store_sk, ss_item_sk,
      sum(ss_sales_price) AS revenue
    FROM store_sales, date_dim
    WHERE ss_sold_date_sk = d_date_sk
    AND d_month_seq BETWEEN 1212 AND 1223
    GROUP BY ss_store_sk, ss_item_sk
  ) X
) Y
WHERE revenue <= 0.1 * avgR
AND ss_store_sk = s_store_sk
AND ss_item_sk = i_item_sk
ORDER BY s_store_name, i_item_desc;


timing stop
spool off
exit
