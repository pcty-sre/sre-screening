function Find-RunningWServices {
    Get-Service -Name 'W*' |
        Select-Object -Property Name,DisplayName |
        Where-object { $_.Status -eq 'Running' }
}
function Test-IsOdd {
param(
    [int]
    $Number
)
    Set-Strictmode -Version Latest
    $isOdd = ($Number % 2) -eq 0
    Write-Output "$Number is odd: $isOdd"
}
function Get-FooCount {
    Set-Strictmode -Version Latest
    function foo {
        # Do not change this inner function
        $r = @("hi")
        return $r
    }
    (foo).Count
}
function Add-IntFiles {
param(
    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({ Test-Path -Path $_ })]
    [string]
    $FirstPath,
    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({ Test-Path -Path $_ })]
    [string]
    $SecondPath
)
    # Fix this without modifying the called script
    $val = . $PsScriptRoot\getIntFromFile.ps1 -Path $FirstPath
    $val2 = . $PsScriptRoot\getIntFromFile.ps1 -Path $SecondPath
    $ret = $val + $val2
    return $ret
}