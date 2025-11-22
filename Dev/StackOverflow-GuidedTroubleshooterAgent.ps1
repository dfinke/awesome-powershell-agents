#Requires -Modules PSAI
# Stack Overflow Guided Troubleshooter Agent

<#
    .SYNOPSIS
    Gets error log and text files for troubleshooting.
    .DESCRIPTION
    Recursively finds .log and .txt files in the specified path for error extraction.
    .PARAMETER path
    The root directory to search. Defaults to current directory.
    .EXAMPLE
    Get-ErrorLogs -path "C:\Logs"
    Used by Stack Overflow Guided Troubleshooter Agent.
#>
function global:Get-ErrorLogs {
    param([string]$path = ".")

    Get-ChildItem -Path $path -Include "*.log", "*.txt" -Recurse | Select-Object -ExpandProperty FullName
}

<#
    .SYNOPSIS
    Gets the content of a file.
    .DESCRIPTION
    Reads and returns the content of the specified file path.
    .PARAMETER filePath
    The path to the file to read.
    .EXAMPLE
    Get-FileContent -filePath "C:\Logs\error.log"
#>
function global:Get-FileContent {
    param([string]$filePath)
    
    Get-Content -Path $filePath
}

<#
    .SYNOPSIS
    Performs a Tavily search for troubleshooting Q&A.
    .DESCRIPTION
    Placeholder for search logic. Returns a string with search results for the query.
    .PARAMETER query
    The search query string.
    .EXAMPLE
    Invoke-TavilySearch -query "PowerShell error code 1"
#>
function global:Invoke-TavilySearch {
    param([string]$query)

    if ( -not $env:TAVILY_API_KEY) {
        return  "Error: TAVILY_API_KEY environment variable is not set."
    }
    
    $tavilyParams = @{
        api_key = $env:TAVILY_API_KEY
        include_domains = "stackoverflow.com"
        query   = $query        
    }

    $body = $tavilyParams | ConvertTo-Json -Depth 10

    Invoke-RestMethod -Method Post -Uri "https://api.tavily.com/search" -ContentType 'application/json' -Body $body
}

$tools = @('Get-ErrorLogs', 'Get-FileContent', 'Invoke-TavilySearch')

$instructions = "You are a Stack Overflow Guided Troubleshooter Agent. Search the current directory and extract error text. Call Tavily to find Q&A posts and issue threads. Distill common causes, code fixes, config changes. Output a fix proposal with alternatives. You must include relevant Stack Overflow links."

$agent = New-Agent -Tools $tools -Instructions $instructions -ShowToolCalls
$prompt = "Troubleshoot the error in app.log using Stack Overflow."
$result = $agent | Get-AgentResponse $prompt

$result