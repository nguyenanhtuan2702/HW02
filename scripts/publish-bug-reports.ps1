[CmdletBinding()]
param(
    # Safe by default. GitHub Issues are created only when -Execute is supplied.
    [switch]$Execute,
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($Execute -and $DryRun) {
    throw 'Choose either -DryRun or -Execute, not both.'
}

$TargetRepo = 'nguyenanhtuan2702/eshop-sut'
$ExpectedAccount = 'nguyenanhtuan2702'
$WorkspaceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$BugReportsRoot = Join-Path $WorkspaceRoot 'bug-reports'
$CsvPath = Join-Path $BugReportsRoot 'github-issues.csv'
$RunId = Get-Date -Format 'yyyyMMdd-HHmmss'
$IsDryRun = -not $Execute

# Screenshot map is explicit and based on the evidence paths in each BR report.
# Empty arrays mean the report has no suitable screenshot; a reason is recorded.
$BugDefinitions = @(
    [pscustomobject]@{
        BugId = 'BR-FR01-01'
        ReportPath = 'bug-reports/BR-FR01-01.md'
        Screenshots = @(
            [pscustomobject]@{ Path = 'evidence/FR-01-registration/TC01/screenshots/20261016-155435-TC01-FAIL.png'; Label = 'TC01'; Alt = 'TC01 - mật khẩu đạt yêu cầu bị từ chối' }
            [pscustomobject]@{ Path = 'evidence/FR-01-registration/BVA-FR01-02/screenshots/20261016-155435-BVA-FR01-02-FAIL.png'; Label = 'BVA-FR01-02'; Alt = 'BVA-FR01-02 - mật khẩu 8 ký tự bị từ chối' }
            [pscustomobject]@{ Path = 'evidence/FR-01-registration/BVA-FR01-03/screenshots/20261016-155435-BVA-FR01-03-FAIL.png'; Label = 'BVA-FR01-03'; Alt = 'BVA-FR01-03 - mật khẩu 9 ký tự bị từ chối' }
        )
        NoScreenshotReason = ''
    }
    [pscustomobject]@{
        BugId = 'BR-FR01-02'
        ReportPath = 'bug-reports/BR-FR01-02.md'
        Screenshots = @(
            [pscustomobject]@{ Path = 'evidence/FR-01-registration/TC01/screenshots/20261016-155435-TC01-FAIL.png'; Label = 'TC01'; Alt = 'TC01 - biểu mẫu đăng ký không có trường xác nhận mật khẩu' }
        )
        NoScreenshotReason = ''
    }
    [pscustomobject]@{
        BugId = 'BR-FR01-03'
        ReportPath = 'bug-reports/BR-FR01-03.md'
        Screenshots = @()
        NoScreenshotReason = 'Không có ảnh phù hợp: TC04-TC10 là kiểm thử API-only; JSON và trace là bằng chứng gốc.'
    }
    [pscustomobject]@{
        BugId = 'BR-FR09-01'
        ReportPath = 'bug-reports/BR-FR09-01.md'
        Screenshots = @(
            [pscustomobject]@{ Path = 'evidence/FR-09-coupons/TC09-01/screenshots/20261016-155435-TC09-01-FAIL.png'; Label = 'TC09-01'; Alt = 'TC09-01 - số tiền giảm phần trăm và tổng sau giảm bị sai' }
        )
        NoScreenshotReason = ''
    }
    [pscustomobject]@{
        BugId = 'BR-FR09-02'
        ReportPath = 'bug-reports/BR-FR09-02.md'
        Screenshots = @()
        NoScreenshotReason = 'Không có ảnh phù hợp để chứng minh JWT: screenshot TC09-06 cho thấy UI đang đăng nhập, còn TC09-07 là API-only. Dùng JSON/trace; không đính kèm ảnh dễ gây hiểu nhầm.'
    }
    [pscustomobject]@{
        BugId = 'BR-FR09-03'
        ReportPath = 'bug-reports/BR-FR09-03.md'
        Screenshots = @(
            [pscustomobject]@{ Path = 'evidence/FR-09-coupons/TC09-09/screenshots/20261016-155435-TC09-09-FAIL.png'; Label = 'TC09-09'; Alt = 'TC09-09 - coupon bị từ chối tại đúng ngưỡng tối thiểu' }
            [pscustomobject]@{ Path = 'evidence/FR-09-coupons/BVA-FR09-02/screenshots/20261016-155435-BVA-FR09-02-FAIL.png'; Label = 'BVA-FR09-02'; Alt = 'BVA-FR09-02 - coupon bị từ chối tại biên bằng ngưỡng' }
        )
        NoScreenshotReason = ''
    }
    [pscustomobject]@{
        BugId = 'BR-FR17-01'
        ReportPath = 'bug-reports/BR-FR17-01.md'
        Screenshots = @()
        NoScreenshotReason = 'Không có ảnh phù hợp: TC17-05/06 là kiểm thử API-only; JSON và trace là bằng chứng gốc.'
    }
    [pscustomobject]@{
        BugId = 'BR-FR17-02'
        ReportPath = 'bug-reports/BR-FR17-02.md'
        Screenshots = @(
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/TC17-07/screenshots/20261016-155435-TC17-07-FAIL.png'; Label = 'TC17-07'; Alt = 'TC17-07 - discount_value bằng 0 được chấp nhận' }
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/TC17-08/screenshots/20261016-155435-TC17-08-FAIL.png'; Label = 'TC17-08'; Alt = 'TC17-08 - discount_value âm được chấp nhận' }
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/BVA-FR17-01/screenshots/20261016-155435-BVA-FR17-01-FAIL.png'; Label = 'BVA-FR17-01'; Alt = 'BVA-FR17-01 - giá trị giảm bằng 0 ở biên dưới' }
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/BVA-FR17-02/screenshots/20261016-155435-BVA-FR17-02-FAIL.png'; Label = 'BVA-FR17-02'; Alt = 'BVA-FR17-02 - giá trị giảm âm dưới biên' }
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/BVA-FR17-04/screenshots/20261016-155435-BVA-FR17-04-FAIL.png'; Label = 'BVA-FR17-04'; Alt = 'BVA-FR17-04 - fixed discount bằng 0 ở biên dưới' }
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/BVA-FR17-05/screenshots/20261016-155435-BVA-FR17-05-FAIL.png'; Label = 'BVA-FR17-05'; Alt = 'BVA-FR17-05 - fixed discount âm dưới biên' }
        )
        NoScreenshotReason = ''
    }
    [pscustomobject]@{
        BugId = 'BR-FR17-03'
        ReportPath = 'bug-reports/BR-FR17-03.md'
        Screenshots = @(
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/TC17-10/screenshots/20261016-155435-TC17-10-FAIL.png'; Label = 'TC17-10'; Alt = 'TC17-10 - min_order_amount âm được chấp nhận' }
            [pscustomobject]@{ Path = 'evidence/FR-17-coupon-management/BVA-FR17-07/screenshots/20261016-155435-BVA-FR17-07-FAIL.png'; Label = 'BVA-FR17-07'; Alt = 'BVA-FR17-07 - giá trị âm dưới biên min_order_amount' }
        )
        NoScreenshotReason = ''
    }
    [pscustomobject]@{
        BugId = 'BR-FR11-01'
        ReportPath = 'bug-reports/BR-FR11-01.md'
        Screenshots = @(
            [pscustomobject]@{ Path = 'evidence/FR-11-mobile/TC03/ev3_9_10.jpg'; Label = 'TC03/TC10'; Alt = 'TC03 và TC10 - cùng một ảnh cho thấy trạng thái đơn hàng không phân biệt bằng màu' }
        )
        NoScreenshotReason = ''
    }
)

function Add-CsvResult {
    param(
        [Parameter(Mandatory = $true)]$Definition,
        [Parameter(Mandatory = $true)][string]$Status,
        [string]$IssueNumber = '',
        [string]$IssueUrl = '',
        [string]$ScreenshotStatus = '',
        [string]$Note = ''
    )

    $row = [pscustomobject][ordered]@{
        RunId = $RunId
        Timestamp = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss zzz')
        Repository = $TargetRepo
        BugId = $Definition.BugId
        Title = $Definition.Title
        Status = $Status
        IssueNumber = $IssueNumber
        IssueUrl = $IssueUrl
        ScreenshotStatus = $ScreenshotStatus
        ScreenshotFiles = (@($Definition.Screenshots | ForEach-Object { $_.Path }) -join '; ')
        Note = $Note
    }

    if (-not (Test-Path -LiteralPath $CsvPath) -or (Get-Item -LiteralPath $CsvPath).Length -eq 0) {
        $row | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8
    }
    else {
        $row | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Append
    }
}

function ConvertTo-IssueBody {
    param(
        [Parameter(Mandatory = $true)][string]$RawReport,
        [Parameter(Mandatory = $true)]$Definition,
        [Parameter(Mandatory = $false)][string[]]$ResolvedScreenshots = @()
    )

    $lines = @($RawReport -split '\r?\n')
    $filteredLines = New-Object System.Collections.Generic.List[string]
    foreach ($line in $lines) {
        if ($line -match '^#\s+') { continue }
        if ($line -match '^\*\*.*GitHub Issue.*\*\*') { continue }
        $filteredLines.Add($line)
    }

    $evidenceIndex = -1
    $notesIndex = -1
    for ($i = 0; $i -lt $filteredLines.Count; $i++) {
        if ($filteredLines[$i] -match '^##\s+Bằng chứng\s*$') { $evidenceIndex = $i }
        elseif ($evidenceIndex -ge 0 -and $filteredLines[$i] -match '^##\s+Ghi chú\s*$') { $notesIndex = $i; break }
    }
    if ($evidenceIndex -lt 0) {
        throw "Evidence heading not found in $($Definition.ReportPath)."
    }

    $evidenceLines = New-Object System.Collections.Generic.List[string]
    $evidenceLines.Add('## Bằng chứng')
    $evidenceLines.Add('')
    if ($ResolvedScreenshots.Count -gt 0) {
        $evidenceLines.Add('Ảnh chụp màn hình liên quan được đính kèm trực tiếp vào Issue:')
        foreach ($screenshot in @($Definition.Screenshots)) {
            $evidenceLines.Add("- $($screenshot.Label) — $([IO.Path]::GetFileName($screenshot.Path))")
        }
    }
    else {
        $evidenceLines.Add('Không có screenshot phù hợp để đính kèm.')
        $evidenceLines.Add($Definition.NoScreenshotReason)
        $evidenceLines.Add('Không sử dụng ảnh thay thế; bằng chứng gốc được ghi trong execution results của HW02.')
    }
    $evidenceLines.Add('')

    $bodyLines = New-Object System.Collections.Generic.List[string]
    for ($i = 0; $i -lt $evidenceIndex; $i++) { $bodyLines.Add($filteredLines[$i]) }
    foreach ($line in $evidenceLines) { $bodyLines.Add($line) }
    if ($notesIndex -ge 0) {
        for ($i = $notesIndex; $i -lt $filteredLines.Count; $i++) { $bodyLines.Add($filteredLines[$i]) }
    }

    $body = $bodyLines -join "`r`n"
    # Local repository links do not resolve in an issue; keep their link text only.
    $body = [regex]::Replace($body, '\[([^\]]+)\]\(([^)]+)\)', '$1')
    $body = "<!-- HW02-BUG-ID: $($Definition.BugId) -->`r`n`r`n" + $body.Trim()
    return $body
}

function Find-ExistingIssue {
    param([Parameter(Mandatory = $true)][string]$BugId, [Parameter(Mandatory = $true)]$Issues)

    foreach ($issue in @($Issues)) {
        $searchText = [string]$issue.title + "`n" + [string]$issue.body
        if ($searchText.IndexOf($BugId, [StringComparison]::OrdinalIgnoreCase) -ge 0) {
            return $issue
        }
    }
    return $null
}

# Resolve gh from PATH or the standard Windows installation path.
$GhPath = $null
$ghCommand = Get-Command -Name 'gh' -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
if ($null -ne $ghCommand) {
    $GhPath = $ghCommand.Source
}
else {
    $ghCandidates = @(
        (Join-Path $env:ProgramFiles 'GitHub CLI\gh.exe'),
        (Join-Path $env:LOCALAPPDATA 'Programs\GitHub CLI\gh.exe')
    )
    foreach ($candidate in $ghCandidates) {
        if (Test-Path -LiteralPath $candidate) { $GhPath = $candidate; break }
    }
}
if ([string]::IsNullOrWhiteSpace($GhPath)) {
    throw 'GitHub CLI (gh) was not found on PATH or in its standard Windows install locations. Open PowerShell where gh is available, or add gh.exe to PATH.'
}

# Read and validate all local reports and explicitly mapped screenshots before contacting GitHub.
$Prepared = New-Object System.Collections.Generic.List[object]
foreach ($definition in $BugDefinitions) {
    $reportFullPath = Join-Path $WorkspaceRoot $definition.ReportPath.Replace('/', '\')
    $title = ''
    $rawReport = ''
    $preflightError = ''
    $resolvedScreenshots = New-Object System.Collections.Generic.List[string]

    if (-not (Test-Path -LiteralPath $reportFullPath -PathType Leaf)) {
        $preflightError = "Report file missing: $($definition.ReportPath)"
    }
    else {
        $rawReport = Get-Content -LiteralPath $reportFullPath -Raw -Encoding UTF8
        $titleMatch = [regex]::Match($rawReport, '(?m)^#\s+(?<title>.+?)\s*$')
        $idMatch = [regex]::Match($rawReport, '(?m)^\*\*Bug ID:\*\*\s*(?<id>BR-[A-Z0-9-]+)\s*$')
        if (-not $titleMatch.Success -or -not $idMatch.Success -or $idMatch.Groups['id'].Value -ne $definition.BugId) {
            $preflightError = "Bug ID or title could not be verified in $($definition.ReportPath)"
        }
        else {
            $title = $titleMatch.Groups['title'].Value.Trim()
            foreach ($screenshot in @($definition.Screenshots)) {
                $screenshotFullPath = Join-Path $WorkspaceRoot $screenshot.Path.Replace('/', '\')
                $screenshotName = [IO.Path]::GetFileName($screenshot.Path)
                if (-not $rawReport.Contains($screenshotName)) {
                    $preflightError = "Mapped screenshot is not referenced by the bug report: $($screenshot.Path)"
                }
                elseif (Test-Path -LiteralPath $screenshotFullPath -PathType Leaf) {
                    $resolvedScreenshots.Add((Resolve-Path -LiteralPath $screenshotFullPath).Path)
                }
                else {
                    $preflightError = "Mapped screenshot missing: $($screenshot.Path)"
                }
            }
        }
    }

    $definition | Add-Member -NotePropertyName Title -NotePropertyValue $title -Force
    $definition | Add-Member -NotePropertyName ResolvedScreenshots -NotePropertyValue $resolvedScreenshots.ToArray() -Force
    $definition | Add-Member -NotePropertyName RawReport -NotePropertyValue $rawReport -Force
    $definition | Add-Member -NotePropertyName PreflightError -NotePropertyValue $preflightError -Force
    $Prepared.Add($definition)
}

# All remote commands below are read-only until -Execute reaches gh issue create.
try {
    $authOutput = & $GhPath auth status --hostname github.com 2>&1
    $authExitCode = $LASTEXITCODE
    if ($authExitCode -ne 0) {
        throw "gh auth status failed. Authenticate with the expected account first. Details: $($authOutput -join ' ')"
    }
    $loginOutput = & $GhPath api user --jq .login 2>&1
    $loginExitCode = $LASTEXITCODE
    $login = ($loginOutput -join '').Trim()
    if ($loginExitCode -ne 0 -or $login -ne $ExpectedAccount) {
        throw "Expected GitHub account '$ExpectedAccount', but gh reports '$login'. No issue was created."
    }

    $issueListOutput = & $GhPath issue list --repo $TargetRepo --state all --limit 1000 --json number,title,body,url 2>&1
    $issueListExitCode = $LASTEXITCODE
    if ($issueListExitCode -ne 0) {
        throw "Could not check existing Issues in $TargetRepo. No issue was created. Details: $($issueListOutput -join ' ')"
    }
    $issueListText = ($issueListOutput | ForEach-Object { [string]$_ }) -join "`n"
    $ExistingIssues = @()
    if (-not [string]::IsNullOrWhiteSpace($issueListText)) {
        $parsedIssues = $issueListText | ConvertFrom-Json
        if ($null -ne $parsedIssues) { $ExistingIssues = @($parsedIssues) }
    }
}
catch {
    $precheckMessage = $_.Exception.Message
    foreach ($definition in $Prepared) {
        if (-not [string]::IsNullOrWhiteSpace($definition.PreflightError)) {
            Add-CsvResult -Definition $definition -Status 'FAILED_PREFLIGHT' -ScreenshotStatus 'NOT_ATTEMPTED' -Note $definition.PreflightError
        }
        else {
            Add-CsvResult -Definition $definition -Status 'FAILED_PRECHECK' -ScreenshotStatus 'NOT_ATTEMPTED' -Note $precheckMessage
        }
    }
    throw "$precheckMessage Results recorded in $CsvPath. No Issue was created."
}

$ModeName = if ($IsDryRun) { 'DRY RUN' } else { 'EXECUTE' }
Write-Host "$ModeName | account=$login | target=$TargetRepo | CSV=$CsvPath"
Write-Host 'No git remote, commit, or push command is used by this script.'

$failedCount = 0
foreach ($definition in $Prepared) {
    $screenshotStatus = if ($definition.Screenshots.Count -gt 0) { 'READY_TO_ATTACH' } else { 'NO_MATCHING_SCREENSHOT' }

    if (-not [string]::IsNullOrWhiteSpace($definition.PreflightError)) {
        Add-CsvResult -Definition $definition -Status 'FAILED_PREFLIGHT' -ScreenshotStatus 'NOT_ATTEMPTED' -Note $definition.PreflightError
        Write-Host "FAILED_PREFLIGHT | $($definition.BugId) | $($definition.PreflightError)"
        $failedCount++
        continue
    }

    $duplicate = Find-ExistingIssue -BugId $definition.BugId -Issues $ExistingIssues
    if ($null -ne $duplicate) {
        Add-CsvResult -Definition $definition -Status 'ALREADY_EXISTS' -IssueNumber ([string]$duplicate.number) -IssueUrl ([string]$duplicate.url) -ScreenshotStatus 'NOT_ATTEMPTED' -Note 'Existing issue body/title contains this Bug ID; skipped to prevent a duplicate.'
        Write-Host "ALREADY_EXISTS | $($definition.BugId) | $($duplicate.url)"
        continue
    }

    if ($IsDryRun) {
        $status = if ($definition.Screenshots.Count -gt 0) { 'DRY_RUN_READY' } else { 'DRY_RUN_NO_SCREENSHOT' }
        $note = if ($definition.Screenshots.Count -gt 0) { 'Would create issue with explicitly mapped screenshots; no GitHub write performed.' } else { $definition.NoScreenshotReason }
        Add-CsvResult -Definition $definition -Status $status -ScreenshotStatus $screenshotStatus -Note $note
        Write-Host "$status | $($definition.BugId) | attachments=$($definition.Screenshots.Count) | $($definition.Title)"
        continue
    }

    $body = ConvertTo-IssueBody -RawReport $definition.RawReport -Definition $definition -ResolvedScreenshots $definition.ResolvedScreenshots
    $tempBodyPath = Join-Path ([IO.Path]::GetTempPath()) ("hw02-{0}-{1}-{2}.md" -f $RunId, $definition.BugId, [guid]::NewGuid().ToString('N'))
    [IO.File]::WriteAllText($tempBodyPath, $body, [Text.UTF8Encoding]::new($true))
    try {
        $ghArgs = @('issue', 'create', '--repo', $TargetRepo, '--title', $definition.Title, '--body-file', $tempBodyPath)
        foreach ($screenshot in @($definition.Screenshots)) {
            $screenshotFullPath = Join-Path $WorkspaceRoot $screenshot.Path.Replace('/', '\')
            $ghArgs += @('--attach', ('{0}#{1}' -f $screenshotFullPath, $screenshot.Alt))
        }

        $createOutput = & $GhPath @ghArgs 2>&1
        $createExitCode = $LASTEXITCODE
        $createText = ($createOutput | ForEach-Object { [string]$_ }) -join "`n"
        $urlPattern = 'https://github\.com/' + [regex]::Escape($TargetRepo) + '/issues/(?<number>\d+)'
        $urlMatch = [regex]::Match($createText, $urlPattern)
        $issueUrl = if ($urlMatch.Success) { $urlMatch.Value } else { '' }
        $issueNumber = if ($urlMatch.Success) { $urlMatch.Groups['number'].Value } else { '' }

        if ($createExitCode -eq 0 -and $urlMatch.Success) {
            $createdIssue = [pscustomobject]@{ number = $issueNumber; title = $definition.Title; body = "HW02-BUG-ID: $($definition.BugId)"; url = $issueUrl }
            $ExistingIssues += $createdIssue
            $createdScreenshotStatus = if ($definition.Screenshots.Count -gt 0) { 'ATTACHED' } else { 'NO_MATCHING_SCREENSHOT' }
            Add-CsvResult -Definition $definition -Status 'CREATED' -IssueNumber $issueNumber -IssueUrl $issueUrl -ScreenshotStatus $createdScreenshotStatus -Note $definition.NoScreenshotReason
            Write-Host "CREATED | $($definition.BugId) | $issueUrl"
        }
        elseif ($urlMatch.Success) {
            $createdIssue = [pscustomobject]@{ number = $issueNumber; title = $definition.Title; body = "HW02-BUG-ID: $($definition.BugId)"; url = $issueUrl }
            $ExistingIssues += $createdIssue
            Add-CsvResult -Definition $definition -Status 'CREATED_WITH_ATTACHMENT_FAILURE' -IssueNumber $issueNumber -IssueUrl $issueUrl -ScreenshotStatus 'CHECK_ATTACHMENT_UPLOAD' -Note ($createText -replace '\s+', ' ')
            Write-Host "CREATED_WITH_ATTACHMENT_FAILURE | $($definition.BugId) | $issueUrl"
            $failedCount++
        }
        else {
            Add-CsvResult -Definition $definition -Status 'FAILED' -ScreenshotStatus 'UPLOAD_FAILED_OR_NOT_ATTEMPTED' -Note ($createText -replace '\s+', ' ')
            Write-Host "FAILED | $($definition.BugId) | $createText"
            $failedCount++
        }
    }
    finally {
        Remove-Item -LiteralPath $tempBodyPath -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Results appended to $CsvPath"
if ($IsDryRun) {
    Write-Host 'Dry run complete. No Issue was created. Review the CSV, then run with -Execute only when you are ready to publish.'
}
if ($failedCount -gt 0) { exit 1 }
