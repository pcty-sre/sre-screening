#Requires -Version 5.1
#Requires -Modules Pester
$sutPath = Join-Path "$PsScriptRoot\..\sut" $MyInvocation.MyCommand.Name.Replace('.Tests','')

Describe "CI Repair Simulation" {
    . $sutPath
    [xml]$srcXml = '<Server port="8015" shutdown="SHUTDOWN">

    <Service name="Catalina">
        <Connector port="8081"/>

        <!-- This is the optional AJP connector -->
        <Connector port="8019" protocol="AJP/1.3"/>

        <Engine name="Catalina" defaultHost="localhost">
            <Host name="localhost" appBase="webapps"/>
        </Engine>
    </Service>
</Server>'
    Context "Save-XmlFile (with relative path)" {
        Push-Location $ENV:TEMP
        $fileName = [io.path]::GetRandomFileName()
        $relPath = ".\$fileName"
        $fullPath = Join-Path $ENV:TEMP $fileName
        Save-XmlFile -Xml $srcXml -Path $relPath
        It "Shoulod Save a file" {
            Test-Path -Path $fullPath | Should Be $True
        }
        It "Should create a valid XML file" {
            [xml]$savedXml = (Get-Content -Path $fullPath -Raw)
            $savedXml | Should BeOfType System.Xml.XmlDocument
        }
        Pop-Location
    }
    Context "Transform-TomcatConf" {
        [xml]$finalXml = '<Server port="8015" shutdown="SHUTDOWN">
        <Service name="Catalina">
          <Connector port="8081" sendReasonPhrase="true" relaxedPathChars="[]" relaxedQueryChars="[]" />
          <!-- This is the optional AJP connector -->
          <Connector port="8019" protocol="AJP/1.3" sendReasonPhrase="true" />
          <Engine name="Catalina" defaultHost="localhost">
            <Host name="localhost" appBase="webapps" startStopThreads="2" />
          </Engine>
          <Connector port="8040" sendReasonPhrase="true" maxThreads="50" />
        </Service>
      </Server>'
        $transformedXml = Transform-TomcatConf -Conf $srcXml
        # Let's make sure it's idempotent
        $transformedXml = Transform-TomcatConf -Conf $transformedXml
        It "Should have startStopThreads" {
            $transformedXml.server.service.Engine.Host.startStopThreads | Should Be 2
        }
        It "Should Have sendReasonPhrase set on connectors" {
            $transformedXml.server.service.Connector[0].sendReasonPhrase | Should Be 'true'
            $transformedXml.server.service.Connector[1].sendReasonPhrase | Should Be 'true'
            $transformedXml.server.service.Connector[2].sendReasonPhrase | Should Be 'true'
        }
        It "Should Have Connector on 8040" {
            $c = $transformedXml.server.service.Connector | Where-Object { $_.port -eq '8040' }
            $c | Should Not BeNullOrEmpty
            $c.sendReasonPhrase | Should Be 'true'
            $c.maxThreads | Should Be "50"
        }
        It "Should Have relaxed settings on non-ajp/access connectors" {
            $connectors = $transformedXml.server.service.Connector | Where-Object { @('8040','8019') -notcontains $_.port }
            foreach($c in $connectors) {
                $c.relaxedPathChars | Should Be '[]'
                $c.relaxedQueryChars | Should Be '[]'
            }
        }
    }
}