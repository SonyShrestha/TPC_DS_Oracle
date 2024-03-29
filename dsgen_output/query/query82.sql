spool &1
timing start t
alter system flush shared_pool;
select * from (select  i_item_id
       ,i_item_desc
       ,i_current_price
 from item, inventory, date_dim, store_sales
 where i_current_price between 30 and 30+30
 and inv_item_sk = i_item_sk
 and d_date_sk=inv_date_sk
 and d_date between to_date('2002-05-30', 'YYYY-MM-DD') and (to_date('2002-05-30', 'YYYY-MM-DD') +  60)
 and i_manufact_id in (437,129,727,663)
 and inv_quantity_on_hand between 100 and 500
 and ss_item_sk = i_item_sk
 group by i_item_id,i_item_desc,i_current_price
 order by i_item_id
  ) ;

timing stop
spool off
exit
