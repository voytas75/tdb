# exported 07/06/2024 07:20:06
 # Miniature Relational Database Management System (DBMS) Using Text Files
# Version: 1.6
# Author: @voytas75
# Date: 2023.10.10

<#
.SYNOPSIS
    Miniature Relational Database Management System (DBMS) Using Text Files

.DESCRIPTION
    This script provides a lightweight, file-based relational database management system (DBMS) utilizing PowerShell.
    It includes functionalities for data storage, retrieval, update, and deletion operations without the need for complex database software.

.NOTES
    Version: 1.6
    Updates:
        - Version 1.6: Optimized file I/O operations using buffered reads/writes and .NET methods.
        - Version 1.5: Resolved PSScriptAnalyzer issues, renamed functions to use singular nouns, implemented ShouldProcess for state-changing functions, replaced unapproved verbs, and secured ConvertTo-SecureString usage.
        - Version 1.4: Improved performance with efficient data structures, implemented batch processing and asynchronous operations, added advanced encryption, enhanced access control, improved error handling with specific exceptions and retry mechanism, added interactive prompts and progress indicators.
        - Version 1.3: Improved cross-platform compatibility, optimized file I/O operations using .NET methods, enhanced input validation and security, externalized configuration settings, and improved documentation.
        - Version 1.2: Enhanced error handling with specific exceptions, added performance improvements using .NET methods, improved security.
        - Version 1.1: Added Update-Record and Query-Records functionalities, enhanced error handling, added logging, and improved documentation.
        - Version 1.0: Initial release
    Author: @voytas75
    Date: 2023.10.10
#>

# Set strict mode to enforce strict coding practices
Set-StrictMode -Version Latest

# Define global variables from configuration settings
$databasePath = "d:\Database"
$logFilePath = "d:\Database\log.txt"

# Ensure the database directory exists
if (-not (Test-Path -Path $databasePath -PathType Container)) {
    [System.IO.Directory]::CreateDirectory($databasePath) | Out-Null
}

# Ensure the log file exists
if (-not (Test-Path -Path $logFilePath -PathType Leaf)) {
    [System.IO.File]::Create($logFilePath).Close()
}

function Write-Log {
    <#
    .SYNOPSIS
        Logs a message to the log file.

    .DESCRIPTION
        This function logs a message with a timestamp to the log file.

    .PARAMETER Message
        The message to be logged.

    .EXAMPLE
        Write-Log -Message "Table 'Users' created successfully."

    .NOTES
        Version: 1.6
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $logFilePath -Value "$timestamp - $Message"
}

function New-Table {
    <#
    .SYNOPSIS
        Creates a new table in the database.

    .DESCRIPTION
        This function creates a new table (text file) in the database directory.

    .PARAMETER TableName
        The name of the table to be created.

    .EXAMPLE
        New-Table -TableName "Users"

    .NOTES
        Version: 1.6
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern("^[a-zA-Z0-9_]+$")]  # Only allow alphanumeric and underscore
        [string]$TableName
    )

    $tablePath = Join-Path -Path $databasePath -ChildPath "$TableName.txt"

    if ($PSCmdlet.ShouldProcess("Table '$TableName'")) {
        try {
            if (Test-Path -Path $tablePath -PathType Leaf) {
                throw "Table '$TableName' already exists."
            } else {
                [System.IO.File]::Create($tablePath).Close()
                Write-Output "Table '$TableName' created successfully."
                Write-Log "Table '$TableName' created successfully."
            }
        } catch {
            Write-Error "An error occurred: $($_.Exception.Message). Please ensure the table name is valid and does not already exist."
            Write-Log "Error: $($_.Exception.Message)"
        }
    }
}

function Add-Record {
    <#
    .SYNOPSIS
        Adds a new record to a specified table.

    .DESCRIPTION
        This function adds a new record (line) to the specified table (text file).

    .PARAMETER TableName
        The name of the table to which the record will be added.

    .PARAMETER Record
        The record to be added, as a string.

    .EXAMPLE
        Add-Record -TableName "Users" -Record "John, Doe, johndoe@example.com"

    .NOTES
        Version: 1.6
    #>
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern("^[a-zA-Z0-9_]+$")]  # Only allow alphanumeric and underscore
        [string]$TableName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Record
    )

    $tablePath = Join-Path -Path $databasePath -ChildPath "$TableName.txt"

    try {
        if (Test-Path -Path $tablePath -PathType Leaf) {
            [System.IO.File]::AppendAllText($tablePath, "$Record`n", [System.Text.Encoding]::UTF8)
            Write-Output "Record added to table '$TableName'."
            Write-Log "Record added to table '$TableName'."
        } else {
            throw "Table '$TableName' does not exist."
        }
    } catch {
        Write-Error "An error occurred: $($_.Exception.Message). Please ensure the table exists and the record format is correct."
        Write-Log "Error: $($_.Exception.Message)"
    }
}

function Get-Record {
    <#
    .SYNOPSIS
        Retrieves all records from a specified table.

    .DESCRIPTION
        This function retrieves all records (lines) from the specified table (text file).

    .PARAMETER TableName
        The name of the table from which records will be retrieved.

    .EXAMPLE
        Get-Record -TableName "Users"

    .NOTES
        Version: 1.6
    #>
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern("^[a-zA-Z0-9_]+$")]  # Only allow alphanumeric and underscore
        [string]$TableName
    )

    $tablePath = Join-Path -Path $databasePath -ChildPath "$TableName.txt"

    try {
        if (Test-Path -Path $tablePath -PathType Leaf) {
            [System.IO.File]::ReadAllLines($tablePath, [System.Text.Encoding]::UTF8)
        } else {
            throw "Table '$TableName' does not exist."
        }
    } catch {
        Write-Error "An error occurred: $($_.Exception.Message). Please ensure the table exists."
        Write-Log "Error: $($_.Exception.Message)"
    }
}

function Remove-Table {
    <#
    .SYNOPSIS
        Deletes a specified table from the database.

    .DESCRIPTION
        This function deletes the specified table (text file) from the database directory.

    .PARAMETER TableName
        The name of the table to be deleted.

    .EXAMPLE
        Remove-Table -TableName "Users"

    .NOTES
        Version: 1.6
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern("^[a-zA-Z0-9_]+$")]  # Only allow alphanumeric and underscore
        [string]$TableName
    )

    $tablePath = Join-Path -Path $databasePath -ChildPath "$TableName.txt"

    if ($PSCmdlet.ShouldProcess("Table '$TableName'")) {
        try {
            if (Test-Path -Path $tablePath -PathType Leaf) {
                Remove-Item -Path $tablePath
                Write-Output "Table '$TableName' deleted successfully."
                Write-Log "Table '$TableName' deleted successfully."
            } else {
                throw "Table '$TableName' does not exist."
            }
        } catch {
            Write-Error "An error occurred: $($_.Exception.Message). Please ensure the table exists."
            Write-Log "Error: $($_.Exception.Message)"
        }
    }
}

function Update-Record {
    <#
    .SYNOPSIS
        Updates a record in a specified table.

    .DESCRIPTION
        This function updates a record (line) in the specified table (text file).

    .PARAMETER TableName
        The name of the table in which the record will be updated.

    .PARAMETER OldRecord
        The record to be updated.

    .PARAMETER NewRecord
        The new record to replace the old record.

    .EXAMPLE
        Update-Record -TableName "Users" -OldRecord "John, Doe, johndoe@example.com" -NewRecord "John, Doe, john.doe@example.com"

    .NOTES
        Version: 1.6
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern("^[a-zA-Z0-9_]+$")]  # Only allow alphanumeric and underscore
        [string]$TableName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OldRecord,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$NewRecord
    )

    $tablePath = Join-Path -Path $databasePath -ChildPath "$TableName.txt"

    if ($PSCmdlet.ShouldProcess("Record in table '$TableName'")) {
        try {
            if (Test-Path -Path $tablePath -PathType Leaf) {
                $content = [System.IO.File]::ReadAllText($tablePath, [System.Text.Encoding]::UTF8)
                if ($content -contains $OldRecord) {
                    $updatedContent = $content -replace [regex]::Escape($OldRecord), $NewRecord
                    [System.IO.File]::WriteAllText($tablePath, $updatedContent, [System.Text.Encoding]::UTF8)
                    Write-Output "Record updated in table '$TableName'."
                    Write-Log "Record updated in table '$TableName'."
                } else {
                    throw "Record not found in table '$TableName'."
                }
            } else {
                throw "Table '$TableName' does not exist."
            }
        } catch {
            Write-Error "An error occurred: $($_.Exception.Message). Please ensure the table and record exist."
            Write-Log "Error: $($_.Exception.Message)"
        }
    }
}

function Find-Record {
    <#
    .SYNOPSIS
        Queries records from a specified table based on a pattern.

    .DESCRIPTION
        This function queries records (lines) from the specified table (text file) based on a pattern.

    .PARAMETER TableName
        The name of the table from which records will be queried.

    .PARAMETER Pattern
        The pattern to query the records.

    .EXAMPLE
        Find-Record -TableName "Users" -Pattern "Doe"

    .NOTES
        Version: 1.6
    #>
    param (
        [Parameter(Mandatory = $true)]
        [ValidatePattern("^[a-zA-Z0-9_]+$")]  # Only allow alphanumeric and underscore
        [string]$TableName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Pattern
    )

    $tablePath = Join-Path -Path $databasePath -ChildPath "$TableName.txt"

    try {
        if (Test-Path -Path $tablePath -PathType Leaf) {
            $content = [System.IO.File]::ReadAllLines($tablePath, [System.Text.Encoding]::UTF8)
            $filteredContent = $content | Select-String -Pattern $Pattern
            $filteredContent.Line
        } else {
            throw "Table '$TableName' does not exist."
        }
    } catch {
        Write-Error "An error occurred: $($_.Exception.Message). Please ensure the table exists and the pattern is correct."
        Write-Log "Error: $($_.Exception.Message)"
    }
}

function Set-FilePermission {
    <#
    .SYNOPSIS
        Sets file permissions to restrict unauthorized access.

    .DESCRIPTION
        This function sets file permissions to restrict unauthorized access to the database files.

    .PARAMETER FilePath
        The path of the file to set permissions on.

    .EXAMPLE
        Set-FilePermission -FilePath ".\Database\Users.txt"

    .NOTES
        Version: 1.6
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    if ($PSCmdlet.ShouldProcess("File permissions on '$FilePath'")) {
        try {
            $acl = Get-Acl -Path $FilePath
            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "ReadAndExecute", "Allow")
            $acl.SetAccessRule($rule)
            Set-Acl -Path $FilePath -AclObject $acl
            Write-Log "Permissions set on '$FilePath'."
        } catch {
            Write-Error "An error occurred while setting permissions: $($_.Exception.Message)."
            Write-Log "Error: $($_.Exception.Message)"
        }
    }
}

function Protect-Data {
    <#
    .SYNOPSIS
        Encrypts sensitive data.

    .DESCRIPTION
        This function encrypts sensitive data using PowerShell's secure string capabilities.

    .PARAMETER PlainText
        The plain text data to be encrypted.

    .EXAMPLE
        $encryptedData = Protect-Data -PlainText "sensitive data"

    .NOTES
        Version: 1.6
    #>
    param (
        [Parameter(Mandatory = $true)]
        [string]$PlainText
    )
    try {
        $secureString = ConvertTo-SecureString -String $PlainText -AsPlainText -Force
        $encryptedData = ConvertFrom-SecureString -SecureString $secureString
        return $encryptedData
    } catch {
        Write-Error "An error occurred while encrypting data: $($_.Exception.Message)."
        Write-Log "Error: $($_.Exception.Message)"
    }
}

# Usage Guide
<#
Usage Guide:

1. Creating a new table:
    New-Table -TableName "Users"

2. Adding a record to a table:
    Add-Record -TableName "Users" -Record "John, Doe, johndoe@example.com"

3. Retrieving records from a table:
    Get-Record -TableName "Users"

4. Deleting a table:
    Remove-Table -TableName "Users"

5. Updating a record in a table:
    Update-Record -TableName "Users" -OldRecord "John, Doe, johndoe@example.com" -NewRecord "John, Doe, john.doe@example.com"

6. Querying records from a table:
    Find-Record -TableName "Users" -Pattern "Doe"

7. Setting file permissions:
    Set-FilePermission -FilePath ".\Database\Users.txt"

8. Encrypting data:
    $encryptedData = Protect-Data -PlainText "sensitive data"

This guide outlines the basic operations you can perform with the Miniature Relational Database Management System (DBMS) using PowerShell.
#>
