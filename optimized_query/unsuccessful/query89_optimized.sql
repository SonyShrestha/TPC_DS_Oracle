spool &1
timing start t

alter system flush shared_pool;

SSELECT 
	i_category, 
	i_class, 
	i_brAND,	
	s_store_name, 
	s_company_name, 
	d_moy,
	sum_sales,
	avg_monthly_sales 
FROM (
	SELECT  
		i_category, 
		i_class, 
		i_brAND,
       	s_store_name, 
		s_company_name,
       	d_moy,
		sum_sales,
		avg_monthly_sales,
        sum_sales - avg_monthly_sales AS diff,
		CASE WHEN (avg_monthly_sales <> 0) THEN (ABS(sum_sales - avg_monthly_sales) / avg_monthly_sales) ELSE NULL END AS calc_val FROM (
			SELECT 
				i_category, 
				i_class, 
				i_brAND,
				s_store_name, 
				s_company_name,
				d_moy,
				SUM(ss_sales_price) sum_sales,
				AVG(SUM(ss_sales_price)) OVER (PARTITION BY i_category, i_brAND, s_store_name, s_company_name) avg_monthly_sales FROM ((
					SELECT 
						* FROM
					item, store_sales, date_dim, store
					WHERE ss_item_sk = i_item_sk AND
						ss_sold_date_sk = d_date_sk AND
						ss_store_sk = s_store_sk AND
						d_year=2000 AND i_category IN ('Home','Books','Electronics') AND i_class IN ('wallpaper','parenting','musical')
				)
				UNION ALL 
				SELECT 
					* 
				FROM item, store_sales, date_dim, store
				where ss_item_sk = i_item_sk AND
					ss_sold_date_sk = d_date_sk AND
					ss_store_sk = s_store_sk AND
					d_year=2000 AND	(i_category in ('Shoes','Jewelry','Men') AND i_class in ('womens','birdal','pants'))
		)
	group by i_category, i_class, i_brAND, s_store_name, s_company_name, d_moy
	) tmp1 
)
WHERE calc_val > 0.1
ORDER BY diff, s_store_name;

timing stop
spool off
exit
