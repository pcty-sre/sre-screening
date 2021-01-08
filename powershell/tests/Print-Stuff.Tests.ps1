#Requires -Version 5.1
#Requires -Modules Pester
$sutPath = Join-Path "$PsScriptRoot\..\sut" $MyInvocation.MyCommand.Name.Replace('.Tests','')

Describe 'Print Stuff' {
    . $sutPath
    Context 'Print-Stuff' {
        It "Should Print Hi" {
            Print-Stuff -Phrase 'hi' | Should Be "hi"
        }
    }
    Context 'Print-Stuff2' {
        It "Should Print Hi" {
            Print-Stuff2 @($null,'hi') | Should Be 'hi'
        }
    }
    Context "Print-PID" {
        It "Should Print PID" {
            $psProcesses = @(Get-Process -Name 'powershell')
            Print-PID -Process $psProcesses[0] | Should Match 'Hi\s+\d+'
        }
    }
}
