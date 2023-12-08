
import cx_Oracle
from os import system,listdir,path
import datetime
import argparse

parser = argparse.ArgumentParser(description='Python Script to perform Load Test')
parser.add_argument('-sf', '--scalefactor', help='Scale Factor', required=True)
parser.add_argument('-u', '--username', help='username', required=True)
parser.add_argument('-p', '--password', help='password', required=True)
parser.add_argument('-d', '--dsn', help='dsn', required=True)

args = parser.parse_args()

def load_data(sf,username,password,dsn,dat_file_path,ctl_file_path):
    for file in listdir(dat_file_path):
        if file.endswith(".dat"):
            table_name = ''.join([i for i in path.splitext(file)[0] if not i.isdigit()]).rstrip('_')
            sqlldr = 'sqlldr userid={user_name}/{password}@{dsn} control={control_path} data={data} log={log}'.format(
                user_name=username, 
                password=password, 
                dsn=dsn, 
                control_path=ctl_file_path+'\\'+table_name+'.ctl', 
                data=dat_file_path+'\\'+table_name+'.dat',
                log='..\\log\\data\\sf'+str(sf)+'\\'+table_name+'.log'
            )
        system(sqlldr)


def execute_sql_file(cursor,sql_file):
    f = open(sql_file)
    full_sql = f.read()
    sql_commands = full_sql.split(';')
    
    for sql_command in sql_commands:
        if len(sql_command.strip('\n').strip(' '))!=0:
            cursor.execute(sql_command)


def create_schema(cursor,sf):
    try:
        query="""
            alter session set "_ORACLE_SCRIPT"=true; 
            create USER DW_TPCDS_SF{sf} IDENTIFIED BY tpcdssf{sf};
            GRANT ALL PRIVILEGES TO DW_TPCDS_SF{sf};
            alter session set current_schema = DW_TPCDS_SF{sf}; 
        """.format(sf=sf)
        for each_query in query.split(';')[:-1]:
            cursor.execute(each_query)
    except Exception as e:
        if str(e).__contains__('conflicts with another user or role name') :
            drop_query="""
                DROP USER DW_TPCDS_SF{sf} CASCADE
            """.format(sf=sf)
            cursor.execute(drop_query)
            create_schema(cursor,sf)


if __name__ == '__main__':
    try:
        sf=str(args.scalefactor)
        username=args.username 
        password=args.password 
        dsn=args.dsn 
        data_file_path='..\dsgen_output\data\sf'+sf
        ctl_file_path='..\ctl\sf'+sf
        connection = cx_Oracle.connect(
            username,
            password,
            dsn
        )
        cursor = connection.cursor()
        start_time=datetime.datetime.now()
        create_schema(cursor,sf)
        execute_sql_file(cursor,'..\\ddl\\tpcds.sql')
        load_data(sf,username,password,dsn, data_file_path, ctl_file_path)
        execute_sql_file(cursor,'..\\ddl\\tpcds_ri.sql')
        end_time=datetime.datetime.now()
        print("\nTotal time taken for loading data is:")
        print((end_time-start_time).total_seconds())
    except cx_Oracle.Error as error:
        print(error)