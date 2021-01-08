#Requires -Version 5.1
#Requires -Modules Pester
$sutPath = Join-Path "$PsScriptRoot\..\sut" $MyInvocation.MyCommand.Name.Replace('.Tests','')

Describe "PsQuirks" {
    . $sutPath
    Context "Find-RunningWServices" {
        It "Should return at least 1 service" {
            @(Find-RunningWServices).Count | Should BeGreaterThan 0
        }


    }
    Context "Test-IsOdd" {
        It "Should Return Bool" {
            Test-IsOdd -Number 2 | Should BeOfType System.Boolean
        }
    }
    Context "Get-FooCount" {
        It "Should have a count of 1" {
            Get-FooCount | Should Be 1
        }
    }
    Context "Add-IntFiles" {
        $filesPath = "$PsScriptRoot\..\files"
        It "Should Add File Contents as ints" {
            $r = Add-IntFiles -FirstPath "$filesPath\12.txt" -SecondPath "$filesPath\4.txt"
            $r | Should Be (12+4)
        }
    }
}