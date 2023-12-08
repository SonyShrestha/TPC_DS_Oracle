
import cx_Oracle
from os import system,listdir,path
import datetime
import pandas as pd 
import argparse
import random
import multiprocessing
import os
import datetime


parser = argparse.ArgumentParser(description='Python Script to perform Power and Throughput Test')
parser.add_argument('-sf', '--scalefactor', help='Scale Factor', required=True)
parser.add_argument('-u', '--username', help='username', required=True)
parser.add_argument('-p', '--password', help='password', required=True)
parser.add_argument('-d', '--dsn', help='dsn', required=True)
parser.add_argument('-t', '--test', help='p for performing Power Test and t for performing Throughput Test', required=True)
parser.add_argument('-o', '--output_path', help='Absolute output path', required=True)

args = parser.parse_args()

def run_query(username,password,dsn,file_path,thread,sf,output_path):
    df = pd.DataFrame(columns=['query_number','query', 'execution_time(seconds)','start_time','end_time'])
    list_dir = listdir(file_path)
    random.shuffle(list_dir)
    for file_name in list_dir:
        if file_name.endswith(".sql"):
            print("Query being executed: "+file_name)
            full_path = path.join(file_path, file_name)
            start_time=datetime.datetime.now()
            sqlplus = 'sqlplus {user_name}/{password}@{dsn} @{full_path} {output_path}'.format(
                user_name=username, 
                    password=password, 
                    dsn=dsn,
                    full_path=full_path,
                    output_path='..\\log\\query\\sf'+str(sf)+'\\'+file_name.replace('.sql','')+'.log'
            )
            print(sqlplus)
            start_time=datetime.datetime.now()
            system(sqlplus)
            end_time=datetime.datetime.now()
            diff=(end_time-start_time).total_seconds()
            df2 = pd.DataFrame({
                "query_number":[file_name.replace('query','').replace('.sql','')],
                "query":[file_name],
                "execution_time":[diff],
                "start_time":start_time,
                "end_time":end_time
            })
            df=pd.concat([df, df2])
    print(df.sort_values("query_number"))
    output_file_name=output_path+'\\'+datetime.datetime.now().strftime('%Y-%d-%m_%H-%M-%S')+'_DW_Project_thread'+str(thread)+'.xlsx'
    with pd.ExcelWriter(output_file_name, engine='openpyxl', mode='w') as writer:
        df.sort_values("query_number").to_excel(writer, sheet_name='Query_Performace(sf'+sf+')',index=False)


if __name__ == '__main__':
    try:
        sf=str(args.scalefactor)
        username=args.username 
        password=args.password 
        dsn=args.dsn 
        test=args.test 
        output_path=args.output_path 
        query_file_path='..\dsgen_output\query'
        
        if test=='t':
            t1 = multiprocessing.Process(target=run_query, args=(username,password,dsn,query_file_path,1,sf,output_path,))
            t2 = multiprocessing.Process(target=run_query, args=(username,password,dsn,query_file_path,2,sf,output_path,))
            t3 = multiprocessing.Process(target=run_query, args=(username,password,dsn,query_file_path,3,sf,output_path,))
            t4 = multiprocessing.Process(target=run_query, args=(username,password,dsn,query_file_path,4,sf,output_path,))
            t1.start()
            t2.start()
            t3.start()
            t4.start()
            t1.join()
            t2.join()
            t3.join()
            t4.join()
        elif test=='p':
            run_query(username,password,dsn,query_file_path,0,sf,output_path)
    

        
    except cx_Oracle.Error as error:
        print(error)