import pyodbc
import os

def create_connection():
    server = 'LAPTOP-ETQ93KQJ'  # Your server name
    database = 'RENTAL_MOBIL'   # Database name for the rental mobil database

    connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database}'

    try:
        conn = pyodbc.connect(connection_string)
        return conn
    except pyodbc.Error as e:
        print(f'Error: {e}')
        return None