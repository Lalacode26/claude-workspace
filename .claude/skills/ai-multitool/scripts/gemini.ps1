<#
.SYNOPSIS
  Gọi Google Gemini API qua REST endpoint.

.DESCRIPTION
  Wrapper đơn giản — đọc $env:GEMINI_API_KEY, gửi prompt tới gemini-2.5-flash, in response ra stdout.

.PARAMETER Prompt
  Nội dung prompt. Nếu không truyền, đọc từ stdin (pipeline).

.PARAMETER Model
  Model ID. Mặc định: gemini-2.5-flash.

.EXAMPLE
  .\gemini.ps1 -Prompt "10 idea content về JS"

.EXAMPLE
  Get-Content prompt.txt | .\gemini.ps1
#>
param(
    [string]$Prompt,
    [string]$Model = "gemini-2.5-flash"
)

if (-not $env:GEMINI_API_KEY) {
    Write-Error "Chưa set GEMINI_API_KEY. Lấy key tại https://aistudio.google.com/apikey rồi chạy: setx GEMINI_API_KEY 'your-key' (mở terminal mới sau khi set)"
    exit 1
}

if (-not $Prompt) {
    $Prompt = [Console]::In.ReadToEnd()
}

if ([string]::IsNullOrWhiteSpace($Prompt)) {
    Write-Error "Prompt rỗng. Truyền -Prompt 'text' hoặc pipe input qua stdin."
    exit 1
}

$uri = "https://generativelanguage.googleapis.com/v1beta/models/$($Model):generateContent?key=$($env:GEMINI_API_KEY)"

$body = @{
    contents = @(
        @{
            parts = @(
                @{ text = $Prompt }
            )
        }
    )
} | ConvertTo-Json -Depth 10

try {
    $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType "application/json; charset=utf-8"
    $text = $response.candidates[0].content.parts[0].text
    Write-Output $text
} catch {
    Write-Error "Gemini API error: $($_.Exception.Message)"
    exit 1
}
