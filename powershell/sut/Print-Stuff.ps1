function Print-Stuff {
param(
    [string]$Phrase
)
    '$Phrase'
}
function Print-Stuff2 {
param($obj)
    $obj
}
function Print-PID {
param(
    [System.Diagnostics.Process]
    $Process
)
    # Avoid string concat
    "Hi $Process.Id"
}
