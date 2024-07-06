# Miniature Relational Database Management System (DBMS) Using Text Files Documentation

## Table of Contents
1. [Introduction](#introduction)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Usage Guide](#usage-guide)
    - [Creating a New Table](#creating-a-new-table)
    - [Adding a Record](#adding-a-record)
    - [Retrieving Records](#retrieving-records)
    - [Deleting a Table](#deleting-a-table)
    - [Updating a Record](#updating-a-record)
    - [Querying Records](#querying-records)
    - [Setting File Permissions](#setting-file-permissions)
    - [Encrypting Data](#encrypting-data)
5. [Developer Notes](#developer-notes)
    - [Code Structure](#code-structure)
    - [Key Functions and Logic](#key-functions-and-logic)
6. [Dependencies and Prerequisites](#dependencies-and-prerequisites)
7. [Troubleshooting and Common Issues](#troubleshooting-and-common-issues)
8. [FAQ](#faq)
9. [Video Tutorials](#video-tutorials)

## Introduction
The Miniature Relational Database Management System (DBMS) Using Text Files is a lightweight, file-based relational database management system developed using PowerShell. It provides functionalities for data storage, retrieval, update, and deletion operations without the need for complex database software.

**Version:** 1.6  
**Author:** @voytas75  
**Date:** 2023.10.10

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
   .\YourScriptName.ps1
   ```

## Configuration
The script uses global variables for configuration settings. These settings can be modified at the beginning of the script.

- **Database Path:**
  ```powershell
  $databasePath = ".\Database"
  ```

- **Log File Path:**
  ```powershell
  $logFilePath = ".\Database\log.txt"
  ```

Ensure that the paths are correctly set according to your environment.

## Usage Guide

### Creating a New Table
To create a new table:
```powershell
New-Table -TableName "Users"
```

### Adding a Record
To add a new record to a table:
```powershell
Add-Record -TableName "Users" -Record "John, Doe, johndoe@example.com"
```

### Retrieving Records
To retrieve all records from a table:
```powershell
Get-Record -TableName "Users"
```

### Deleting a Table
To delete a table:
```powershell
Remove-Table -TableName "Users"
```

### Updating a Record
To update a record in a table:
```powershell
Update-Record -TableName "Users" -OldRecord "John, Doe, johndoe@example.com" -NewRecord "John, Doe, john.doe@example.com"
```

### Querying Records
To query records from a table based on a pattern:
```powershell
Find-Record -TableName "Users" -Pattern "Doe"
```

### Setting File Permissions
To set file permissions to restrict unauthorized access:
```powershell
Set-FilePermission -FilePath ".\Database\Users.txt"
```

### Encrypting Data
To encrypt sensitive data:
```powershell
$encryptedData = Protect-Data -PlainText "sensitive data"
```

## Developer Notes

### Code Structure
The script is structured into several functions, each performing a specific operation. The main functions include:

- `New-Table`
- `Add-Record`
- `Get-Record`
- `Remove-Table`
- `Update-Record`
- `Find-Record`
- `Set-FilePermission`
- `Protect-Data`
- `Write-Log`

### Key Functions and Logic
- **`New-Table`**: Creates a new table (text file) in the database directory.
- **`Add-Record`**: Adds a new record (line) to the specified table.
- **`Get-Record`**: Retrieves all records (lines) from the specified table.
- **`Remove-Table`**: Deletes the specified table (text file) from the database directory.
- **`Update-Record`**: Updates a record (line) in the specified table.
- **`Find-Record`**: Queries records from the specified table based on a pattern.
- **`Set-FilePermission`**: Sets file permissions to restrict unauthorized access.
- **`Protect-Data`**: Encrypts sensitive data using PowerShell's secure string capabilities.
- **`Write-Log`**: Logs messages with timestamps to a log file.

## Dependencies and Prerequisites
- **PowerShell Version**: Ensure you have PowerShell 5.1 or later installed.
- **File System Access**: The script requires read/write access to the directory where the database files are stored.

## Troubleshooting and Common Issues
1. **Table Already Exists**:
   - Error: "Table 'TableName' already exists."
   - Solution: Use a different table name or delete the existing table.

2. **Table Does Not Exist**:
   - Error: "Table 'TableName' does not exist."
   - Solution: Ensure the table name is correct and the table has been created.

3. **Record Not Found**:
   - Error: "Record not found in table 'TableName'."
   - Solution: Verify the record exists and the search pattern is correct.

4. **Permission Issues**:
   - Error: "An error occurred while setting permissions."
   - Solution: Ensure you have the necessary permissions to modify file access controls.

## FAQ
**Q1: Can I use special characters in table names?**  
A1: No, table names can only contain alphanumeric characters and underscores.

**Q2: How do I view the log file?**  
A2: The log file is located at the path specified in `$logFilePath`. You can open it with any text editor.

**Q3: How do I handle large datasets?**  
A3: For large datasets, consider using efficient data structures and optimizing file I/O operations.

**Q4: Can I use this script on Linux or macOS?**  
A4: Yes, the script is cross-platform compatible with PowerShell Core.

## Video Tutorials
Consider adding video tutorials for installation and basic usage to enhance user understanding. These can be hosted on platforms like YouTube or embedded in the documentation.

---

This documentation provides a comprehensive guide for users and developers to effectively use and understand the Miniature Relational Database Management System (DBMS) Using Text Files. Ensure to review and update the documentation regularly to maintain accuracy and completeness.




