spool &1
timing start t
alter system flush shared_pool;
select * from (select  s_store_name
      ,sum(ss_net_profit)
 from store_sales
     ,date_dim
     ,store,
     (select ca_zip
     from (
      SELECT substr(ca_zip,1,5) ca_zip
      FROM customer_address
      WHERE substr(ca_zip,1,5) IN (
                          '89436','30868','65085','22977','83927','77557',
                          '58429','40697','80614','10502','32779',
                          '91137','61265','98294','17921','18427',
                          '21203','59362','87291','84093','21505',
                          '17184','10866','67898','25797','28055',
                          '18377','80332','74535','21757','29742',
                          '90885','29898','17819','40811','25990',
                          '47513','89531','91068','10391','18846',
                          '99223','82637','41368','83658','86199',
                          '81625','26696','89338','88425','32200',
                          '81427','19053','77471','36610','99823',
                          '43276','41249','48584','83550','82276',
                          '18842','78890','14090','38123','40936',
                          '34425','19850','43286','80072','79188',
                          '54191','11395','50497','84861','90733',
                          '21068','57666','37119','25004','57835',
                          '70067','62878','95806','19303','18840',
                          '19124','29785','16737','16022','49613',
                          '89977','68310','60069','98360','48649',
                          '39050','41793','25002','27413','39736',
                          '47208','16515','94808','57648','15009',
                          '80015','42961','63982','21744','71853',
                          '81087','67468','34175','64008','20261',
                          '11201','51799','48043','45645','61163',
                          '48375','36447','57042','21218','41100',
                          '89951','22745','35851','83326','61125',
                          '78298','80752','49858','52940','96976',
                          '63792','11376','53582','18717','90226',
                          '50530','94203','99447','27670','96577',
                          '57856','56372','16165','23427','54561',
                          '28806','44439','22926','30123','61451',
                          '92397','56979','92309','70873','13355',
                          '21801','46346','37562','56458','28286',
                          '47306','99555','69399','26234','47546',
                          '49661','88601','35943','39936','25632',
                          '24611','44166','56648','30379','59785',
                          '11110','14329','93815','52226','71381',
                          '13842','25612','63294','14664','21077',
                          '82626','18799','60915','81020','56447',
                          '76619','11433','13414','42548','92713',
                          '70467','30884','47484','16072','38936',
                          '13036','88376','45539','35901','19506',
                          '65690','73957','71850','49231','14276',
                          '20005','18384','76615','11635','38177',
                          '55607','41369','95447','58581','58149',
                          '91946','33790','76232','75692','95464',
                          '22246','51061','56692','53121','77209',
                          '15482','10688','14868','45907','73520',
                          '72666','25734','17959','24677','66446',
                          '94627','53535','15560','41967','69297',
                          '11929','59403','33283','52232','57350',
                          '43933','40921','36635','10827','71286',
                          '19736','80619','25251','95042','15526',
                          '36496','55854','49124','81980','35375',
                          '49157','63512','28944','14946','36503',
                          '54010','18767','23969','43905','66979',
                          '33113','21286','58471','59080','13395',
                          '79144','70373','67031','38360','26705',
                          '50906','52406','26066','73146','15884',
                          '31897','30045','61068','45550','92454',
                          '13376','14354','19770','22928','97790',
                          '50723','46081','30202','14410','20223',
                          '88500','67298','13261','14172','81410',
                          '93578','83583','46047','94167','82564',
                          '21156','15799','86709','37931','74703',
                          '83103','23054','70470','72008','49247',
                          '91911','69998','20961','70070','63197',
                          '54853','88191','91830','49521','19454',
                          '81450','89091','62378','25683','61869',
                          '51744','36580','85778','36871','48121',
                          '28810','83712','45486','67393','26935',
                          '42393','20132','55349','86057','21309',
                          '80218','10094','11357','48819','39734',
                          '40758','30432','21204','29467','30214',
                          '61024','55307','74621','11622','68908',
                          '33032','52868','99194','99900','84936',
                          '69036','99149','45013','32895','59004',
                          '32322','14933','32936','33562','72550',
                          '27385','58049','58200','16808','21360',
                          '32961','18586','79307','15492')
     intersect
      select ca_zip
      from (SELECT substr(ca_zip,1,5) ca_zip,count(*) cnt
            FROM customer_address, customer
            WHERE ca_address_sk = c_current_addr_sk and
                  c_preferred_cust_flag='Y'
            group by ca_zip
            having count(*) > 10)A1)A2) V1
 where ss_store_sk = s_store_sk
  and ss_sold_date_sk = d_date_sk
  and d_qoy = 1 and d_year = 2002
  and (substr(s_zip,1,2) = substr(V1.ca_zip,1,2))
 group by s_store_name
 order by s_store_name
  ) ;

timing stop
spool off
exit
