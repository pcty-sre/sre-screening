if((& git branch --show-current) -match '^$|master') {
	throw "make sure to use a feature branch to apply"
}
foreach($patchFile in (Get-ChildItem -File -Filter *.patch))
{
	write-host "*** $($patchFile.Name) ***" -f green
	write-host "verifying..." -f magenta
	& git apply --stat $patchFile.FullName
	if(!$?) {
		write-error "Cannot verify patch: $($patchFile.Name)"
		return
	}
	write-host "applying..." -f magenta
	& git apply $patchFile
	if(!$?) {
		write-error "Cannot verify patch: $($patchFile.Name)"
		return
	}
}
