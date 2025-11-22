function global:Get-KBInstall {
    param(
        [int]$MonthsAgo
    )
    
    $xMonthsAgo = (Get-Date).AddMonths(-$MonthsAgo)                        
    
    Get-HotFix | Where-Object { $_.InstalledOn -ge $xMonthsAgo } | Select-Object HotFixID, Description, InstalledOn              
}

function Global:Invoke-WebSearch {
    param(
        [Parameter(Mandatory)]
        [string]$query

    )

    if ( -not $env:TAVILY_API_KEY) {
        return  "Error: TAVILY_API_KEY environment variable is not set."
    }
    
    $tavilyParams = @{
        api_key = $env:TAVILY_API_KEY
        query   = $query        
    }
    
    $body = $tavilyParams | ConvertTo-Json -Depth 10

    Invoke-RestMethod -Method Post -Uri "https://api.tavily.com/search" -ContentType 'application/json' -Body $body
}

$prompt = @"
List the Windows hotfixes installed in the last 6 months and provide a web search for more information about each hotfix.
"@

New-Agent -ShowToolCalls -Tools Get-KBInstall, Invoke-WebSearch | Get-AgentResponse $prompt