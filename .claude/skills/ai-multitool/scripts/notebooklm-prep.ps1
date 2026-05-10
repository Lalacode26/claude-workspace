<#
.SYNOPSIS
  Chuẩn bị tài liệu để upload NotebookLM.

.DESCRIPTION
  Vì NotebookLM không có public API, script này:
  - Gom files .md/.txt/.pdf trong SourceFolder (recursive).
  - Copy sang OutFolder (mặc định: .\notebooklm-input).
  - Tạo manifest.txt liệt kê files + size.
  - Mở notebooklm.google.com trên browser mặc định để user upload thủ công.

.PARAMETER SourceFolder
  Folder chứa tài liệu nguồn (bắt buộc).

.PARAMETER OutFolder
  Folder đích. Mặc định: .\notebooklm-input

.PARAMETER NoBrowser
  Không tự mở browser sau khi prep xong.

.EXAMPLE
  .\notebooklm-prep.ps1 -SourceFolder ".\drafts"

.EXAMPLE
  .\notebooklm-prep.ps1 -SourceFolder "C:\research" -OutFolder "C:\nlm-batch1" -NoBrowser
#>
param(
    [Parameter(Mandatory=$true)][string]$SourceFolder,
    [string]$OutFolder = ".\notebooklm-input",
    [switch]$NoBrowser
)

if (-not (Test-Path $SourceFolder)) {
    Write-Error "Source folder không tồn tại: $SourceFolder"
    exit 1
}

New-Item -ItemType Directory -Path $OutFolder -Force | Out-Null

$extensions = @("*.md", "*.txt", "*.pdf")
$files = @()
foreach ($ext in $extensions) {
    $files += Get-ChildItem -Path $SourceFolder -Filter $ext -Recurse -File
}

if ($files.Count -eq 0) {
    Write-Warning "Không tìm thấy file .md/.txt/.pdf trong: $SourceFolder"
    exit 0
}

$manifest = @()
foreach ($f in $files) {
    $dest = Join-Path $OutFolder $f.Name
    Copy-Item -Path $f.FullName -Destination $dest -Force
    $sizeKB = [math]::Round($f.Length / 1KB, 1)
    $manifest += "- $($f.Name) ($sizeKB KB) — from $($f.DirectoryName)"
}

$manifestPath = Join-Path $OutFolder "manifest.txt"
$manifestContent = @"
NotebookLM Input Manifest
=========================
Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Source: $SourceFolder
Output: $OutFolder
Total files: $($files.Count)

Files:
$($manifest -join "`n")

Hướng dẫn:
1. Mở https://notebooklm.google.com
2. Tạo notebook mới (hoặc mở notebook hiện có)
3. Click "Add source" -> "Upload" -> chọn tất cả files trong folder $OutFolder
4. (Không upload manifest.txt — chỉ là log)
"@

Set-Content -Path $manifestPath -Value $manifestContent -Encoding utf8

Write-Output "Đã chuẩn bị $($files.Count) file vào: $OutFolder"
Write-Output "Manifest: $manifestPath"

if (-not $NoBrowser) {
    Write-Output "Mở NotebookLM..."
    Start-Process "https://notebooklm.google.com"
}
