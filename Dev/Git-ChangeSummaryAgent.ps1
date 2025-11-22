#Requires -Modules PSAI
# Git Change Summary Agent

<#
    .SYNOPSIS
    Gets git log as JSON.
    .DESCRIPTION
    Retrieves git log information and returns it as JSON.
    .PARAMETER repoPath
    The path to the git repository.
    .EXAMPLE
    Get-GitLogJson -repoPath "C:\MyRepo"
#>
function global:Get-GitLogJson {
    param([int]$Count = 10)
    $log = git log -n $Count --name-status --pretty=format:'%H|%an|%ad|%s'
    $entries = $log -split "`n`n"
    $result = @()
    foreach ($entry in $entries) {
        $lines = $entry -split "`n"
        $commit = $lines[0] -split '\|'
        $files = $lines[1..($lines.Length - 1)] | Where-Object { $_ }
        $result += @{
            Hash    = $commit[0]
            Author  = $commit[1]
            Date    = $commit[2]
            Message = $commit[3]
            Files   = $files
        }
    }
    $result | ConvertTo-Json -Depth 5
}

<#
    .SYNOPSIS
    Gets the content of a file.
    .DESCRIPTION
    Reads and returns the content of the specified file path.
    .PARAMETER filePath
    The path to the file to read.
    .EXAMPLE
    Get-FileContent -filePath "C:\MyRepo\log.txt"
#>
function global:Get-FileContent {
    param([string]$filePath)
    Get-Content -Path $filePath
}

$tools = @('Get-GitLogJson', 'Get-FileContent')

$instructions = "You are a Git Change Summary Agent. Use Get-GitLogJson to fetch recent commit metadata and file changes. Group changes by feature, area (folder path prefixes). Generate a summary like 'Frontend: …', 'Backend: …'. Optionally produce release-note-style markdown."

$agent = New-Agent -Tools $tools -Instructions $instructions -ShowToolCalls
$prompt = "Summarize recent Git changes in the last 20 commits."
$result = $agent | Get-AgentResponse $prompt
$result
