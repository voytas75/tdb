# Miniature Relational Database Management System (DBMS) Using Text Files Documentation

## Table of Contents
- [Miniature Relational Database Management System (DBMS) Using Text Files Documentation](#miniature-relational-database-management-system-dbms-using-text-files-documentation)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Usage Guide](#usage-guide)
    - [Creating a New Table](#creating-a-new-table)
    - [Inserting a Record](#inserting-a-record)
    - [Reading Records](#reading-records)
    - [Updating Records](#updating-records)
    - [Deleting Records](#deleting-records)
    - [Creating an Index](#creating-an-index)
    - [Listing Tables](#listing-tables)

## Introduction
The Miniature Relational Database Management System (DBMS) Using Text Files is a lightweight, file-based relational database management system developed using PowerShell. It provides functionalities for data storage, retrieval, update, and deletion operations without the need for complex database software.

## Installation
1. **Download the Script:**
   Download the PowerShell script file from the repository.

2. **Save the Script:**
   Save the script file to a directory of your choice.

3. **Open PowerShell:**
   Open PowerShell with administrative privileges.

4. **Navigate to the Script Directory:**
   ```powershell
   cd path\to\your\script
   ```

5. **Run the Script:**
   ```powershell
   .\tdb.ps1
   ```

## Configuration
The script uses a configuration file for settings. These settings can be modified in the `.tdb.config` file.

- **Database Path:**
  ```json
  "DBDirectory": ".\\Database"
  ```

- **Log File Path:**
  ```json
  "LogFilePath": ".\\Database\\log.txt"
  ```

Ensure that the paths are correctly set according to your environment.

## Usage Guide

### Creating a New Table
To create a new table, use the `New-tdbTable` function. This function requires the table name and the columns you want to include in the table. The table name should only contain alphanumeric characters and underscores.

### Inserting a Record
To insert a new record into a table, use the `Insert-tdbRecord` function. This function requires the table name and a hashtable representing the record.

### Reading Records
To read records from a table, use the `Get-tdbRecord` function. This function requires the table name and a hashtable representing the filter criteria.

### Updating Records
To update existing records in a table, use the `Update-tdbRecords` function. This function requires the table name, a hashtable representing the filter criteria, and a hashtable representing the new values.

### Deleting Records
To delete records from a table, use the `Remove-tdbRecords` function. This function requires the table name and a hashtable representing the filter criteria.

### Creating an Index
To create an index on a table, use the `New-tdbDBMSIndex` function. This function requires the table name, column name, and index name.

### Listing Tables
To list all tables in the current database or show info for a specific table, use the `Get-tdbTable` function.
