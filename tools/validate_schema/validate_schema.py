#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Validate that the DINA collections database schema conforms
with the specifications.
"""

# TODO
# Validate:
# [x] table name
# [ ] ordinal position
# [x] column name
# [ ] is nullable
# [x] datatype (including size)
# [ ] unique constraint
# [ ] default value
# [ ] primary key
# [x] foreign key constraint
# [ ] column comment (i.e. the description)
#
# Include system and schema in "referenced_fullname" and "REFERENCED_FULLNAME"

import argparse
import getpass
import sys

import numpy as np
import pandas
import pandasvalidation as pv
import pymysql



__author__ = 'Markus Englund'
__license__ = 'AGPL-3.0'
__version__ = '0.2.0'


TABLES_PATH = '../../dictionary/collections-dictionary-tables.csv'
COLUMNS_PATH = '../../dictionary/collections-dictionary-columns.csv'


def get_schema_info(user, host, password, db, info_table):
    """
    Return a pandas DataFrame with information about the
    implemented database schema.

    Parameters
    ----------
    user : str
        Username for the database.
    host : str
        Database host.
    password : str
        Password for the database.
    db : str
        Name of the database
    info_table : str'
        Name of the information table: 'columns' or 'key_column_usage'.
    """
    connection = pymysql.connect(
        host=host, user=user, password=password, db=db,)
    sql = """SELECT *
        FROM information_schema.{info_table}
        WHERE
            table_schema = '{db}'
        ORDER BY
            table_name, ordinal_position
        """.format(info_table=info_table, db=db)
    frame = pandas.read_sql(sql, connection)
    connection.close()
    if info_table == 'columns' or 'key_column_usage':
        frame['COLUMN_FULLNAME'] = (
            frame.TABLE_NAME.fillna('') + '.' +
            frame.COLUMN_NAME.fillna(''))
    if info_table == 'key_column_usage':
        frame['REFERENCED_FULLNAME'] = (
            frame.REFERENCED_TABLE_NAME.fillna('') + '.' +
            frame.REFERENCED_COLUMN_NAME.fillna(''))
    return frame


def get_tables_spec(path, version_added):
    """Return a pandas DataFrame with table specifications."""
    tables_spec = pandas.read_csv(path, dtype=str)
    added_tables = tables_spec[
        tables_spec.version_added == version_added]
    return added_tables


def get_columns_spec(path, version_added):
    """Return a pandas DataFrame with column specifications."""
    columns_spec = pandas.read_csv(path, dtype=str)
    columns_spec['column_fullname'] = (
        columns_spec.table_name.fillna('') + '.' +
        columns_spec.column_name.fillna(''))
    columns_spec['referenced_fullname'] = (
        columns_spec.referenced_table.fillna('') + '.' +
        columns_spec.referenced_column.fillna(''))
    added_columns = columns_spec[
        columns_spec.version_added == version_added]
    return added_columns


def print_message(msg, items):
    """
    Print output message.

    Parameters
    ----------
    msg : str
        Text message.
    items : list
        Reported information items (e.g. table or column names).
    """
    print(msg)
    if len(items) > 0:
        print('  -', '\n  - '.join(items), '\n')
    else:
        print('  - None\n')


def parse_args(args):
    parser = argparse.ArgumentParser(
        description=(
            'Command-line utility for validating the DINA '
            'Collections database schema. YAML-formatted output '
            'is written to <stdout>.'))
    parser.add_argument(
        '-V', '--version', action='version',
        version='validate_schema.py ' + __version__)
    parser.add_argument(
        '--user', type=str, action='store', default='root',
        dest='user', help='MySQL user (default: "root")')
    parser.add_argument(
        '--password', type=str, action='store', default=None,
        dest='password', help='MySQL password')
    parser.add_argument(
        '--host', type=str, action='store', default='localhost',
        dest='host', help='database host (default: "localhost")')
    parser.add_argument(
        'database_name', type=str, action='store', help='MySQL database name')
    parser.add_argument(
        'version_added', type=str, action='store', help='version added')
    return parser.parse_args(args)


def main(args=None):
    if args is None:
        args = sys.argv[1:]
    parser = parse_args(args)

    if not parser.password:
        password = getpass.getpass('MySQL password:')
    else:
        password = parser.password

    implemented_columns = get_schema_info(
        user=parser.user, host=parser.host, password=password,
        db=parser.database_name, info_table='columns')

    added_tables = get_tables_spec(TABLES_PATH, parser.version_added)
    tables_not_found = list(added_tables.table_name[
        ~added_tables.table_name.isin(implemented_columns.TABLE_NAME)
        ].values)

    added_columns = get_columns_spec(COLUMNS_PATH, parser.version_added)
    columns_not_found = list(added_columns.column_fullname[
        ~added_columns.column_fullname.isin(
            implemented_columns.COLUMN_FULLNAME)].values)

    implemented_fks = get_schema_info(
        user=parser.user, host=parser.host, password=password,
        db=parser.database_name, info_table='key_column_usage')
    implemented_fks['RELATION'] = (
        implemented_fks.COLUMN_FULLNAME + ' -> ' +
        implemented_fks.REFERENCED_FULLNAME)

    added_fks = added_columns.loc[
        added_columns.key == 'FK',
        ['column_fullname', 'referenced_fullname']]
    added_fks['relation'] = (
        added_fks.column_fullname + ' -> ' + added_fks.referenced_fullname)
    relations_not_found = list(added_fks.relation[
        ~added_fks.relation.isin(implemented_fks.RELATION)].values)

    implemented_data_types = (
        implemented_columns.COLUMN_FULLNAME + ' [' +
        pv.to_string(implemented_columns.COLUMN_TYPE) + ']')
    added_data_types = (
        added_columns.column_fullname + ' [' +
        added_columns.data_type + '(' +
        pv.to_string(added_columns['size']) + ')]').replace(
            '\(\)$', '', regex=True)
    wrong_data_types = list(added_data_types[
        ~added_data_types.isin(implemented_data_types)].dropna().values)

    print_message('Missing tables:', tables_not_found)
    print_message('Missing columns:', columns_not_found)
    print_message(
        'Missing relations (column -> referenced column):',
        relations_not_found)
    print_message(
        'Wrong data types (column [correct data type]):',
        wrong_data_types)

if __name__ == '__main__':
    main()
