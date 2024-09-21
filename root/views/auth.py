import os

import pymysql
from flask import Blueprint, redirect, url_for, request as req, render_template
from ..templates import Template
from ..ui.renderer import Renderer
from ..manager.user import UserManager as uM
from ..manager.xhr import Xhr as xhr
from .view_util import method
from settings import BASE_PATH
from settings import DATABASE_CONFIG as db
from root.manager.fn import Serializer
import subprocess
import sys

auth = Blueprint("auth", __name__)


@auth.route("authorization", methods=["POST", "GET"])
def welcome():
    user = uM.selected_account()
    if user:
        return redirect(url_for("main.index"))
    if req.form.get("xhr_init") and method("post"):
        return xhr.init_doc("auth")
    temp = Template(category="auth")
    temp.page_config(title="Auth")
    temp.add_data(step=1)
    return temp.render()


@auth.route("/logout", methods=["POST"])
def logout():
    if req.args.get("xhr"):
        return xhr.terminate()
    uM.end_session()
    return redirect(url_for("main.index"))


@auth.route("/start-up", methods=["POST", "GET"])
def start_up():
    user = uM.selected_account()
    tags = [1, 2, 3]
    if not user or not req.args:
        return redirect(url_for("main.index"))
    step = req.args.get("step")
    temp = Template(category="auth", name="start-up")
    temp.page_config(title="Let`s Go !").add_data(step=step)

    return Renderer.from_template(temp, collapse_endbar=True, flags=Renderer.flags(lock=True))


@auth.route("/install", methods=["POST", "GET"])
def install():
    ini_file = BASE_PATH.joinpath("install.py")
    if not ini_file.exists():
        return redirect(url_for("main.index"))
    if req.method == "POST":
        conn = None
        backup_file = BASE_PATH.joinpath("backup.sql")
        sql_file = BASE_PATH.joinpath("sql.sql")

        try:
            # Step 1: Backup the current database
            backup_database(backup_file)

            # Step 2: Connect to the database
            conn = pymysql.connect(
                host=db["host"],
                password=db["password"],
                user=db["user"],
                database=db["db_name"]
            )
            cursor = conn.cursor()

            # Step 3: Drop all tables to empty the database
            drop_all_tables(cursor, conn)

            # Step 4: Execute the new SQL script
            execute_sql_script(cursor, conn, sql_file)

            # Step 5: Check if tables are empty before restoring the backup
            if ensure_tables_empty(cursor):
                # Step 6: Restore the backup, filtering out any data-modifying statements
                restore_backup(backup_file)
            else:
                print("Tables are not empty, skipping restoration.")

            return "Installation and backup restoration completed successfully"

        except Exception as e:
            print(f"Installation failed: {e}")
            return f"Installation failed: {e}"

        finally:
            # Ensure the connection is closed properly
            if conn:
                conn.close()
    config = {
        "css1": url_for("static", filename="stylesheet/theme.css"),
        "css2": url_for("static", filename="stylesheet/style.css"),
    }
    return render_template("install.html", config=config)


# Step 1: Backup current database to a file
def backup_database(backup_file):
    try:
        print("Backing up the current database...")
        cmd = f"mysqldump -u {db['user']} -p{db['password']} -h {db['host']} {db['db_name']} > {backup_file}"
        os.system(cmd)
        print(f"Backup saved to {backup_file}")
    except Exception as e:
        raise Exception(f"Backup failed: {e}")


# Step 2: Drop all tables in the database
def drop_all_tables(cursor, conn):
    print("Dropping all tables...")
    cursor.execute("SET FOREIGN_KEY_CHECKS = 0;")
    cursor.execute("SHOW TABLES;")
    tables = cursor.fetchall()
    for table in tables:
        cursor.execute(f"DROP TABLE IF EXISTS {table[0]};")
    cursor.execute("SET FOREIGN_KEY_CHECKS = 1;")
    conn.commit()
    print("All tables dropped.")


# Step 3: Execute a new SQL script (new installation or changes)
def execute_sql_script(cursor, conn, sql_file):
    print("Executing new SQL script...")
    with sql_file.open("r") as file:
        sql_statements = file.read().split(";")
        for stmt in sql_statements:
            stmt = stmt.strip()
            if stmt:
                try:
                    cursor.execute(stmt)
                    conn.commit()
                except Exception as e:
                    conn.rollback()
                    raise Exception(f"Failed to execute statement: {stmt}. Error: {e}")
    print("SQL script executed successfully.")


# Step 4: Restore the backed-up data
def restore_backup(backup_file):
    try:
        print("Restoring backup data...")
        cmd = f"mysql -u {db['user']} -p{db['password']} -h {db['host']} {db['db_name']} < {backup_file}"
        os.system(cmd)
        print("Backup data restored successfully.")
    except Exception as e:
        raise Exception(f"Backup restoration failed: {e}")


def ensure_tables_empty(cursor):
    print("Ensuring all tables are empty...")
    cursor.execute("SHOW TABLES;")
    tables = cursor.fetchall()
    for table in tables:
        cursor.execute(f"SELECT COUNT(*) FROM {table[0]};")
        count = cursor.fetchone()[0]
        if count > 0:
            print(f"Table {table[0]} is not empty.")
            return False
    print("All tables are empty.")
    return True
