import json
import pathlib

import pymysql


def backup_mysql_to_json(connection, output_file: pathlib.PosixPath):
    try:
        with connection.cursor() as cursor:
            cursor.execute("SHOW TABLES;")
            tables = cursor.fetchall()

            backup_data = {}

            for (table_name,) in tables:
                cursor.execute(f"SELECT * FROM {table_name}")
                rows = cursor.fetchall()

                cursor.execute(f"SHOW COLUMNS FROM {table_name}")
                columns = [col[0] for col in cursor.fetchall()]

                table_data = [dict(zip(columns, row)) for row in rows]

                backup_data[table_name] = table_data

            with output_file.open('w') as json_file:
                json.dump(backup_data, json_file, indent=4)

    finally:
        return


def restore_json_to_mysql(connection, input_file: pathlib.PosixPath):
    try:
        with connection.cursor() as cursor:
            with input_file.open('r') as json_file:
                backup_data = json.load(json_file)

            for table_name, table_data in backup_data.items():
                if not table_data:
                    continue

                columns = table_data[0].keys()

                column_names = ', '.join(columns)
                placeholders = ', '.join(['%s'] * len(columns))
                insert_query = f"INSERT INTO {table_name} ({column_names}) VALUES ({placeholders})"

                for row in table_data:
                    cursor.execute(insert_query, tuple(row.values()))

            connection.commit()

    finally:
        return
