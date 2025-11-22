#Requires -Modules PSAI, ImportExcel
# CSV to Excel Migration Agent

<#
    .SYNOPSIS
    Gets CSV files for migration.
    .DESCRIPTION
    Recursively finds .csv files in the specified path for migration.
    .PARAMETER path
    The root directory to search. Defaults to current directory.
    .EXAMPLE
    Get-CsvFiles -path "C:\Data"
#>
function global:Get-CsvFiles {
    param([string]$path = ".")

    Get-ChildItem -Path $path -Filter "*.csv" -File | Select-Object -ExpandProperty FullName
}

<#
    .SYNOPSIS
    Exports data from CSV to Excel.
    .DESCRIPTION
    Converts CSV data to Excel format and saves to the specified path.
    .PARAMETER csvPath
    The path to the CSV file.
    .PARAMETER excelPath
    The path to save the Excel file.
    .EXAMPLE
    ConvertTo-Excel -csvPath "C:\Data\data.csv" -excelPath "C:\Data\data_converted.xlsx"
#>
function global:ConvertTo-Excel {
    param([string]$csvPath, [string]$excelPath)

    try {
        Import-Csv -Path $csvPath | Export-Excel -Path $excelPath -TableName "Data" -AutoSize
    }
    catch {
        Return "Failed to convert $csvPath to Excel: $_"
    }
}

$tools = @('Get-CsvFiles', 'ConvertTo-Excel')

$instructions = "You are a CSV to Excel Migration Agent. Find all .csv files in a target folder. Export to .xlsx."

$agent = New-Agent -Tools $tools -Instructions $instructions -ShowToolCalls
$prompt = "Convert CSV files in the current folder to Excel format."

$result = $agent | Get-AgentResponse $prompt
$result
