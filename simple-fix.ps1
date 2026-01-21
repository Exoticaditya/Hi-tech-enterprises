# Simple fix fo products.html
$file = "c:\Hi-tech-enterprises\products.html"
$content = Get-Content $file -Raw

Write-Output "Starting fixes..."

# Backup
Copy-Item $file "$file.backup" -Force

# Fix: Replace product-2.PNG with product-1.PNG ONLY in the Multi Head Weigher section (first occurrence)
# We'll target the specific line with context
$pattern = '(<!-- Product 3: Multi Head Weigher[^<]*<article[^<]*<[^<]*<img src="assets/images/products/)product-2(\.PNG")'
if ($content -match $pattern) {
    $content = $content -replace $pattern, '${1}product-1${2}'
    Write-Output "Fixed Multi Head Weigher image"
}

# Save
$content | Set-Content $file -NoNewline

Write-Output "Done!"
