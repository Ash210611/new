import os
import sqlite3
import sys
import unittest

import pytest
from pyliquibase import Pyliquibase


@pytest.mark.usefixtures("db_file")
class MyTestCase(unittest.TestCase):
    def setUp(self):
        property_file = f'jdbc:sqlite:{os.path.join(self.db_file, "")}'
        changelog_file = "tables/test_property_subs.sql"
        content_str = f"changelogFile: {changelog_file}\n" \
                      f"url: {property_file}"
        with open("tests/resources/liquibase.properties", "w") as f:
            f.write(content_str)

    def test_liquibase(self):
        liquibase = Pyliquibase(
            defaultsFile="tests/resources/liquibase.properties",
            logLevel="INFO")
        liquibase.execute("update")

        with sqlite3.connect(self.db_file) as conn:
            cursor = conn.cursor()
            result = cursor.execute("SELECT name FROM sqlite_master WHERE type='table';").fetchall()
            tags = cursor.execute("select * from databasechangelog;").fetchall()
            print(f"show all the tables: {result}")
            print("TAGS:::", tags)

        liquibase.execute("rollback-count", "10000")
        with sqlite3.connect(self.db_file) as conn:
            cursor = conn.cursor()
            result = cursor.execute("SELECT name FROM sqlite_master WHERE type='table';").fetchall()
            print(f"show all the tables after rollback: {result}")
