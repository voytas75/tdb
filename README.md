# Miniature Relational Database Management System (DBMS) Using Text Files Documentation

[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/tdb)](https://www.powershellgallery.com/packages/tdb)

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
    - [Listing Tables](#listing-tables)

## Introduction

The Miniature Relational Database Management System (DBMS) Using Text Files is a lightweight, file-based relational database management system developed using PowerShell. It provides functionalities for data storage, retrieval, update, and deletion operations without the need for complex database software.

## Installation

1. **Install the Script:**
   Install the PowerShell script file from PowerShell Gallery.

   ```powershell
   Install-Script -Name tdb
   ```

2. **Run the Script:**

   ```powershell
   tdb.ps1
   ```

   or

   ```powershell
   tdb
   ```

3. **Show usage guide**

   ```powershell
   show-tdbUsage
   ```

   When you run the script for the first time, it will automatically create a configuration file named `.tdb_default.config` with default settings. **This file will be located in the same directory where the script is**. The default settings include paths for the database directory and the log file. You can modify these settings as needed.

   Example of default settings in `.tdb_default.config`:

   ```json
   {
    "DBDirectory":  "C:\\Users\\voytas75\\Documents\\tdb\\DB",
    "LogFilePath":  "C:\\Users\\voytas75\\Documents\\tdb\\Logs\\tdb.Log",
   }
   ```

## Configuration

The script uses a configuration file for settings. These settings can be modified in the `.tdb_default.config` file.

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

```powershell
New-tdbTable -TableName 'Users' -Columns @('Name', 'Email')
```

### Inserting a Record

To insert a new record into a table, use the `Insert-tdbRecord` function. This function requires the table name and a hashtable representing the record.

```powershell
Insert-tdbRecord -TableName 'Users' -Record @{Name='John Doe'; Email='john@example.com'}
```

### Reading Records

To read records from a table, use the `Get-tdbRecord` function. This function requires the table name and a hashtable representing the filter criteria.

```powershell
get-tdbRecord -TableName "groups1" -ComparisonOperator contains
```

### Updating Records

To update existing records in a table, use the `Update-tdbRecords` function. This function requires the table name, a hashtable representing the filter criteria, and a hashtable representing the new values.

```powershell
Update-tdbRecord -TableName 'Users' -Filter @{ID=1} -NewValues @{Email='john.doe@example.com'}
```

### Deleting Records

To delete records from a table, use the `Remove-tdbRecords` function. This function requires the table name and a hashtable representing the filter criteria.

```powershell
Remove-tdbRecord -TableName 'Users' -Filter @{ID=1}
```

### Listing Tables

To list all tables in the current database or show info for a specific table, use the `Get-tdbTable` function.

```powershell
Get-tdbTable
```
