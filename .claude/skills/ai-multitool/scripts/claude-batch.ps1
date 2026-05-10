<#
.SYNOPSIS
  Gọi Anthropic Claude API (claude-sonnet-4-6).

.PARAMETER Prompt
  Prompt string (mutually exclusive với -PromptFile).

.PARAMETER PromptFile
  Đường dẫn file prompt (.md/.txt). Đọc nội dung làm prompt.

.PARAMETER InputText
  Input bổ sung sẽ append vào prompt sau separator '---'. Hữu ích khi dùng template có placeholder.

.PARAMETER MaxTokens
  Default 2048.

.PARAMETER Model
  Default claude-sonnet-4-6.

.EXAMPLE
  .\claude-batch.ps1 -Prompt "Viết 3 caption về workshop NextJS"

.EXAMPLE
  .\claude-batch.ps1 -PromptFile prompts\rewrite-caption.md -InputText "Caption gốc..."
#>
param(
    [string]$Prompt,
    [string]$PromptFile,
    [string]$InputText,
    [int]$MaxTokens = 2048,
    [string]$Model = "claude-sonnet-4-6"
)

if (-not $env:ANTHROPIC_API_KEY) {
    Write-Error "Chưa set ANTHROPIC_API_KEY. Chạy: setx ANTHROPIC_API_KEY 'your-key' (mở terminal mới sau khi set)"
    exit 1
}

if ($PromptFile) {
    if (-not (Test-Path $PromptFile)) {
        Write-Error "Không tìm thấy file: $PromptFile"
        exit 1
    }
    $Prompt = Get-Content -Path $PromptFile -Raw -Encoding utf8
}

if ($InputText) {
    $Prompt = "$Prompt`n`n---`n`n$InputText"
}

if ([string]::IsNullOrWhiteSpace($Prompt)) {
    Write-Error "Prompt rỗng. Truyền -Prompt hoặc -PromptFile."
    exit 1
}

$body = @{
    model = $Model
    max_tokens = $MaxTokens
    messages = @(
        @{ role = "user"; content = $Prompt }
    )
} | ConvertTo-Json -Depth 10

$headers = @{
    "x-api-key" = $env:ANTHROPIC_API_KEY
    "anthropic-version" = "2023-06-01"
    "content-type" = "application/json"
}

try {
    $response = Invoke-RestMethod -Uri "https://api.anthropic.com/v1/messages" -Method Post -Body $body -Headers $headers
    Write-Output $response.content[0].text
} catch {
    Write-Error "Anthropic API error: $($_.Exception.Message)"
    exit 1
}
