spool &1
timing start t

alter system flush shared_pool;

SELECT  
  cd_gender,
  cd_marital_status,
  cd_education_status,
  COUNT(*) cnt1,
  cd_purchase_estimate,
  COUNT(*) cnt2,
  cd_credit_rating,
  COUNT(*) cnt3
FROM customer c,customer_address ca,customer_demographics,(
      (
            SELECT 
                  ss_customer_sk customer_sk
            FROM store_sales,date_dim
            WHERE ss_sold_date_sk = d_date_sk AND
                d_year = 1999 AND
                d_moy BETWEEN 1 AND 3
      )
      MINUS
      (
            SELECT ws_bill_customer_sk customer_sk
            from web_sales,date_dim
            WHERE ws_sold_date_sk = d_date_sk AND
                  d_year = 1999 AND
                  d_moy BETWEEN 1 AND 3
      )
      MINUS
      (
            SELECT cs_ship_customer_sk customer_sk 
            from catalog_sales,date_dim
            WHERE cs_sold_date_sk = d_date_sk AND
                  d_year = 1999 AND
                  d_moy BETWEEN 1 AND 3
      )
)
WHERE
      c.c_current_addr_sk = ca.ca_address_sk AND
      ca_state IN ('CO','IL','MN') AND
      cd_demo_sk = c.c_current_cdemo_sk AND
      c.c_customer_sk = customer_sk
GROUP BY cd_gender, cd_marital_status, cd_education_status, cd_purchase_estimate, cd_credit_rating
ORDER BY cd_gender, cd_marital_status, cd_education_status, cd_purchase_estimate, cd_credit_rating;
  
timing stop
spool off
exit
