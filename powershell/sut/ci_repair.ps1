function Save-XmlFile {
param(
    [Parameter(Mandatory=$True)]
    [xml]
    $Xml,
    [PArameter(Mandatory=$True)]
    [string]
    $Path
)
    $xml.Save($Path)
}
function Transform-TomcatConf {
param(
    [Parameter(Mandatory=$True)]
    [xml]
    $Conf
)
    # Imagine you are following these instructions
    # on upgrading Artifactory PRIOR to 5.4.x
    # https://www.jfrog.com/confluence/display/RTF/Upgrading+Artifactory#UpgradingArtifactory-UpgradingtotheLatestVersion
    #
    # Note the instructions under the "ZIP" sub-section on the
    # tomcat server.xml
    # This function should apply the correct XML changes as required.
    # An example of the final XML is in the unit tests.
    $Conf
}