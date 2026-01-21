# Remove HT-020 and HT-030 from products.html
$file = "c:\Hi-tech-enterprises\products.html"
$lines = Get-Content $file

Write-Output "Total lines before: $($lines.Count)"

# Find line indices (adjust for 0-based indexing)
# HT-020: lines 255-337 (1-indexed) = indices 254-336 (0-indexed)
# HT-030: lines 339-415 (1-indexed) = indices 338-414 (0-indexed), BUT after removing HT-020, this shifts back by 83 lines

# Remove HT-030 first (lines 339-415)
$newLines = $lines[0..337] + $lines[416..($lines.Count-1)]
Write-Output "After removing HT-030: $($newLines.Count) lines"

# Now remove HT-020 (lines 255-337 in original, still 254-336 in indices)
$finalLines = $newLines[0..254] + $newLines[338..($newLines.Count-1)]
Write-Output "After removing HT-020: $($finalLines.Count) lines"

# Backup
Copy-Item $file "$file.bak2" -Force

# Save
$finalLines | Set-Content $file

Write-Output "Done! Removed HT-020 and HT-030 from products.html"
