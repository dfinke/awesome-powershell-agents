#Requires -Modules PSAI, ImportExcel
# Excel Report Generator Agent

<#
    .SYNOPSIS
    Gets Excel files for report generation.
    .DESCRIPTION
    Recursively finds .xlsx files in the specified path for report generation.
    .PARAMETER path
    The root directory to search. Defaults to current directory.
    .EXAMPLE
    Get-ExcelFiles -path "C:\Reports"
#>
function global:Get-ExcelFiles {
    param([string]$path = ".")
    Get-ChildItem -Path $path -Filter "*.xlsx" -File | Select-Object -ExpandProperty FullName
}

<#
    .SYNOPSIS
    Imports Excel data.
    .DESCRIPTION
    Reads and returns the content of the specified Excel file.
    .PARAMETER filePath
    The path to the Excel file to import.
    .EXAMPLE
    Import-ExcelData -filePath "C:\Reports\report.xlsx"
#>
function global:Import-ExcelData {
    param([string]$filePath)
    Import-Excel -Path $filePath
}

<#
    .SYNOPSIS
    Exports a report to Excel.
    .DESCRIPTION
    Saves the provided data to an Excel file at the specified path.
    .PARAMETER path
    The path to save the Excel report.
    .PARAMETER dataAsJson
    The data to export to Excel in JSON format.
    .EXAMPLE
    Export-ExcelReport -path "C:\Reports\summary.xlsx" -data $summary
#>
function global:Export-ExcelReport {
    param([string]$path, [string]$dataAsJson)
    
    ConvertFrom-Json $dataAsJson | Export-Excel -Path $path
}

$tools = @('Get-ExcelFiles', 'Import-ExcelData', 'Export-ExcelReport')

$instructions = "You are an Excel Report Generator Agent. Scan a directory for .xlsx files, identify key numeric and date columns, compute aggregates such as total count, sum, average by date or category. Generate a consolidated workbook with one sheet per source file (summary only), a Dashboard sheet with combined totals. The output data should not be nested; flatten any structures."

$agent = New-Agent -Tools $tools -Instructions $instructions -ShowToolCalls
$prompt = "Generate a summary report from Excel files in the current folder."
$result = $agent | Get-AgentResponse $prompt
$result
