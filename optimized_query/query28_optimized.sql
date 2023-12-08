spool &1
timing start t

alter system flush shared_pool;

SELECT SUM(CASE WHEN flag=1 THEN LP ELSE 0 END) AS B1_LP,
       SUM(CASE WHEN flag=1 THEN CNT ELSE 0 END) AS B1_CNT,
       SUM(CASE WHEN flag=1 THEN CNTD ELSE 0 END) AS B1_CNTD,
       SUM(CASE WHEN flag=2 THEN LP ELSE 0 END) AS B2_LP,
       SUM(CASE WHEN flag=2 THEN CNT ELSE 0 END) AS B2_CNT,
       SUM(CASE WHEN flag=2 THEN CNTD ELSE 0 END) AS B2_CNTD,
       SUM(CASE WHEN flag=3 THEN LP ELSE 0 END) AS B3_LP,
       SUM(CASE WHEN flag=3 THEN CNT ELSE 0 END) AS B3_CNT,
       SUM(CASE WHEN flag=3 THEN CNTD ELSE 0 END) AS B3_CNTD,
       SUM(CASE WHEN flag=4 THEN LP ELSE 0 END) AS B4_LP,
       SUM(CASE WHEN flag=4 THEN CNT ELSE 0 END) AS B4_CNT,
       SUM(CASE WHEN flag=4 THEN CNTD ELSE 0 END) AS B4_CNTD,
       SUM(CASE WHEN flag=5 THEN LP ELSE 0 END) AS B5_LP,
       SUM(CASE WHEN flag=5 THEN CNT ELSE 0 END) AS B5_CNT,
       SUM(CASE WHEN flag=5 THEN CNTD ELSE 0 END) AS B5_CNTD,
       SUM(CASE WHEN flag=6 THEN LP ELSE 0 END) AS B6_LP,
       SUM(CASE WHEN flag=6 THEN CNT ELSE 0 END) AS B6_CNT,
       SUM(CASE WHEN flag=6 THEN CNTD ELSE 0 END) AS B6_CNTD
       FROM (
SELECT flag,avg(ss_list_price) LP
            ,count(ss_list_price) CNT
            ,count(distinct ss_list_price) CNTD FROM (
select ss_list_price, CASE WHEN ss_quantity between 0 and 5
        and (ss_list_price between 11 and 21 
             or ss_coupon_amt between 460 and 1460
             or ss_wholesale_cost between 14 and 34)
             THEN 1
             WHEN ss_quantity between 6 and 10
        and (ss_list_price between 91 and 101
          or ss_coupon_amt between 1430 and 2430
          or ss_wholesale_cost between 32 and 52) THEN 2
          WHEN ss_quantity between 11 and 15
        and (ss_list_price between 66 and 76
          or ss_coupon_amt between 920 and 1920
          or ss_wholesale_cost between 4 and 24) THEN 3
             WHEN ss_quantity between 16 and 20
        and (ss_list_price between 142 and 152
          or ss_coupon_amt between 3054 and 4054
          or ss_wholesale_cost between 80 and 100) THEN 4
          WHEN ss_quantity between 21 and 25
        and (ss_list_price between 135 and 145
          or ss_coupon_amt between 14180 and 15180
          or ss_wholesale_cost between 38 and 58) THEN 5
         when ss_quantity between 26 and 30
        and (ss_list_price between 28 and 38
          or ss_coupon_amt between 2513 and 3513
          or ss_wholesale_cost between 42 and 62) THEN 6
          END AS flag
      from store_sales
      ) GROUP BY flag
);


timing stop
spool off
exit
