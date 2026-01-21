# Fix products.html - Remove HT-020 and HT-030, fix image references

$file = "c:\Hi-tech-enterprises\products.html"
$content = Get-Content $file -Raw

Write-Output "Before changes: $($content.Length) characters"

# Fix: Multi Head Weigher should use product-1.PNG (currently uses product-2.PNG at line 422)
# The Multi Head Weigher is the FIRST occurrence of product-2.PNG, Four Head is the second
$content = $content -replace '(<!-- Product 3: Multi Head Weigher.*?<img src="assets/images/products/)product-2(\.PNG")', '$1product-1$2'

# Comment out HT-020 product (lines 255-337)
$content = $content -replace '(<!-- Product 1: HT-020 -->.*?</article>)', '<!-- REMOVED: Product without matching image\r\n$1\r\nEND REMOVED -->'

# Comment out HT-030 product (lines 339-415)  
$content = $content -replace '(<!-- Product 2: HT-030 -->.*?(?=<!-- Product 3))', '<!-- REMOVED: Product without matching image\r\n$1\r\nEND REMOVED -->'

# Update schema numberOfItems from 18 to 16
$content = $content -replace '"numberOfItems": 18', '"numberOfItems": 16'

Write-Output "After changes: $($content.Length) characters"

# Backup original
Copy-Item $file "$file.backup" -Force
Write-Output "Created backup: $file.backup"

# Save changes
$content | Set-Content $file -NoNewline
Write-Output "Saved changes to $file"

# Verify the fix
$verifyContent = Get-Content $file -Raw
if ($verifyContent -match 'Multi Head Weigher.*?product-1\.PNG') {
    Write-Output "✓ Multi Head Weigher now uses product-1.PNG"
} else {
    Write-Output "✗ Multi Head Weigher fix may have failed"
}

if ($verifyContent -match 'REMOVED.*HT-020') {
    Write-Output "✓ HT-020 commented out"
} else {
    Write-Output "✗ HT-020 removal may have failed"
}

if ($verifyContent -match 'REMOVED.*HT-030') {
    Write-Output "✓ HT-030 commented out"
} else {
    Write-Output "✗ HT-030 removal may have failed"
}
