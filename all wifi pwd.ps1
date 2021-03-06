﻿$listProfiles = netsh wlan show profiles | Select-String -Pattern "All User Profile" | %{ ($_ -split ":")[-1].Trim() };
$listProfiles | foreach {
	$profileInfo = netsh wlan show profiles name=$_ key="clear";
	$SSID = $profileInfo | Select-String -Pattern "SSID Name" | %{ ($_ -split ":")[-1].Trim() };
	$Key = $profileInfo | Select-String -Pattern "Key Content" | %{ ($_ -split ":")[-1].Trim() };

	[PSCustomObject]@{
		Wifi = $SSID;
		Password = $Key
	} | Format-Table -Wrap
}
pause