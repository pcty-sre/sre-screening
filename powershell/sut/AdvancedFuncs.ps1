Set-StrictMode -Version Latest
function Get-FullPath {
param(
    [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
    [System.IO.FileInfo]
    $File
)
    Write-Output $file.FullName
}
function Get-TextFileContent {
param(
    [Parameter(Mandatory=$True)]
    [string]
    $Path,
    [Parameter(Mandatory=$False)]
    [string]
    $FileName = '20.txt'
)
BEGIN {

    $textFilesInFolder = @(Get-ChildItem -Path $Path -Filter *.txt)
    if($textFilesInFolder.Name -notcontains $fileName) {
        return
    }
    $matchingFile = $textFilesInFolder | Where-Object { $_.Name -eq $fileName }
}
PROCESS {
     $content = $matchingFile | Get-Content
}
END {
    Write-Output "hi: $($content)"
}}