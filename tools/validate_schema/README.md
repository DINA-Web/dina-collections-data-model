# validate_schema.py

**validate_schema.py** is a command-line utility for checking that
the DINA Collections database schema complies with the specifications in
the data dictionary in this repository.

The tool is written in Python 3 with dependencies on the third-party
libraries [PyMySQL](https://pymysql.readthedocs.io/en/latest/index.html)
and [pandas](http://pandas.pydata.org) and
[pandas-validation](https://github.com/jmenglund/pandas-validation).
The code conforms to the [PEP 8](https://www.python.org/dev/peps/pep-0008/) style guide.

The script checks that:

- all tables exist
- all columns exist
- the referenced column is correct for each foreign key
- datatype (including size) is correct for each column


## Installing required packages

    $ pip install PyMySQL pandas pandas-validation

You may consider installing the required Python packages
within a virtual environment in order to avoid cluttering your system's
Python path. See for example the environment management system
[conda](http://conda.io) or the package
[virtualenv](https://virtualenv.pypa.io/en/latest/).


## Usage

Clone this repository and and move to the directory with the script:

    $ git clone https://github.com/DINA-Web/dina-collections-data-model.git
    $ cd dina-collections-data-model/tools/pandas-validation

Then, run the script:

    $ ./validate_schema.py -h
    usage: validate_schema.py [-h] [-V] [--user USER] [--password PASSWORD]
                              [--host HOST]
                              database_name version_added

    Command-line utility for validating the DINA Collections database schema.
    YAML-formatted output is written to <stdout>.

    positional arguments:
      database_name        MySQL database name
      version_added        version added

    optional arguments:
      -h, --help           show this help message and exit
      -V, --version        show program's version number and exit
      --user USER          MySQL user (default: "root")
      --password PASSWORD  MySQL password
      --host HOST          database host (default: "localhost")
