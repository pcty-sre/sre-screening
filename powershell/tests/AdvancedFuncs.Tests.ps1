#Requires -Version 5.1
#Requires -Modules Pester
$sutPath = Join-Path "$PsScriptRoot\..\sut" $MyInvocation.MyCommand.Name.Replace('.Tests','')

Describe 'Advanced Funcs' {
    . $sutPath
    $filesPath = "$PsScriptRoot\..\files"
    Context "Get-FullPath" {
        $files = @(Get-ChildItem -Path $filesPath)
        $fullPaths = @($files | Get-FullPath)
        It "Should return same number of entries" {
            $files.Count | Should Be $fullPaths.Count
        }
    }
    Context "Get-TextFileContent" {
        It "Should return hi: 20" {
            Get-TextFileContent -Path $filesPath | Should Be "hi: 20"
        }
        It "Should return null on missing file" {
            Get-TextFileContent -Path $filesPath -FileName '21.txt' | Should Be $null
        }
    }
}
