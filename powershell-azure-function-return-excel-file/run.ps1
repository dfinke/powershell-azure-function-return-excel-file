param($Request)

$ts = (Get-Date).ToString("yyyyMMddss")
$xlFileName = "excel-$($ts).xlsx"

$path = 'D:\home\site\ExcelOutput'
if (!(Test-Path $path)) {
    $null = mkdir $path
}

$xlfile = "$path\$xlFileName"

ConvertFrom-Csv @"
Region,Item,TotalSold
West,hammer,60
North,kiwi,75
South,lemon,7
West,pear,36
West,melon,55
West,nail,44
East,lemon,44
South,hammer,71
West,banana,55
East,nail,25
"@ | Export-Excel -Path $xlfile

$bytes = Get-Content -AsByteStream $xlfile -Raw

Push-OutputBinding -Name Response -Value @{
    StatusCode  = "OK"
    Body        = $bytes
    ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    Headers     = @{ 'Content-Disposition' = "attachment; filename=$($xlFileName)" }
}