# TPC DS
Setup<br/>
1. Unzip file DW_TPC_DS.zip
2. Make sure to have following folder structure.
    - ctl
        - This folder contains all the load scripts for loading data generated from dsdgen into Oracle database.
        - If we are loading data for the scale factor of 1, all scripts should be present inside ctl/sf1 folder.

    - ddl 
        - This folder contains DDL script for creating tables and adding referential integrity.
        - tpcds.sql and tpcds_ri.sql file should be available here.

    - dsgen_output 
        - This folder contains all data and query genearted using dsdgen and dsqgen command resepectively.
        - It contains two subfolder, one for data and another for query.
        - Inside data folder, data generated by dsdgen command should be present in respective scale factor folder in .dat.
        - Inside query folder, query generated by dsqgen command should be present in .sql format.

    - log 
        - Log of executing python script for performing load test, power test and throughput test are stored here. 

    - optimized_query 
        - It contains all the queries optimized by our team.

    - scripts
        - It contains python script for performing load test, power test and throughput test


# Commands
1. To perform load test <br/>
``python .\load_data.py -sf scale_factor -u username -p password -d dsn`` <br/><br/>
Example<br/>
``python .\load_data.py -sf 1 -u system -p XXXXXXX -d localhost/orcl ``<br/>
Note: Make sure .dat files generated from dsdgen is provided inside dsgen_output/data/sf
<br/><br/>

2. To perform power test <br/>
``python .\execute_query.py -sf scale_factor -u username -p password -d dsn -t p -o absolute_folder_path``<br/><br/>
Example<br/>
``python .\execute_query.py -sf 1 -u system -p XXXXXXX -d localhost/orcl -t p -o C:\ULB\Data_Warehouse\Project\TPC_DS``<br/>
<br/><br/>

3. To perform throughput test <br/>
``python .\execute_query.py -sf scale_factor -u username -p password -d dsn -t t -o absolute_folder_path``<br/><br/>
Example<br/>
``python .\execute_query.py -sf 1 -u system -p XXXXXXX -d localhost/orcl -t t -o C:\ULB\Data_Warehouse\Project\TPC_DS``<br/>