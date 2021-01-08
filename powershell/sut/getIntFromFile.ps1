param(
    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({ Test-Path -Path $_ })]
    [string]
    $Path
)
# DO NOT MODIFY THIS FILE
$content = (Get-Content -Path $Path -Raw).Trim()
$val = 0
$result = $null
if([int]::TryParse($content,[ref]$result)) {
    $val = $result
}
return $val