import os
import sqlite3

import pandas as pd
import pytest


@pytest.fixture(scope="class")
def db_file(request, tmp_path_factory):
    """ Fixture to set up the in-memory database with test data and things"""
    table_names = [dataset.split("_")[2].split(".")[0] for dataset in os.listdir("./tests/resources/data")]

    request.cls.db_dir = tmp_path_factory.mktemp("db_dir")
    request.cls.db_file = os.path.join(request.cls.db_dir, "sqlite.db")

    print("SQLITE DB_DIR: ", os.path.join(request.cls.db_dir, ""))
    print("SQLITE DB_FILE: ", os.path.join(request.cls.db_file, ""))

    request.cls.conn = sqlite3.connect(request.cls.db_file)
    cursor = request.cls.conn.cursor()

    for table in table_names:
        dataset = f"./tests/resources/data/test_data_{table}.csv"
        df = pd.read_csv(dataset)
        df.to_sql(table, request.cls.conn, if_exists="replace", index=False)
        print(df.columns)
        result = cursor.execute(f"SELECT * From {table}").fetchall()
        print(f"Result from {table}:::", result)

    result = cursor.execute("SELECT name FROM sqlite_master WHERE type='table';").fetchall()
    print(result)

    request.cls.conn.commit()
    request.cls.conn.close()
    yield
