
. F:\WindowsPowerShell\functions.ps1

Add-Type -AssemblyName System.Windows.Forms
$a = [System.DateTime]::Now
$WI = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$WP = New-Object System.Security.Principal.WindowsPrincipal($wi)
if 
($WP.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator))
{
$Status = " (root)"
$b = $true
}
else
{
$Status = ""
$b = $false
}

function prompt {
$location = $(Get-Location).Path
if ([System.Windows.Forms.SystemInformation]::PowerStatus.BatteryChargeStatus.ToString() -eq -not "NoSystemBattery") {
$batteryPercent = ([System.Windows.Forms.SystemInformation]::PowerStatus.BatteryLifePercent * 100).ToString() + "% Akku: "
} else {
$batteryPercent = ""
}
$Host.UI.RawUI.WindowTitle = $batteryPercent + $env:USERNAME + $Status + "@" + $env:COMPUTERNAME + ": " +
$(if ($location.StartsWith($home)) 
{ $location.Replace($home, "~") } 
else { $location })

$env:USERNAME + $Status + "@" + $env:COMPUTERNAME + ":" + 
$(if ($location.StartsWith($home)) 
{ $location.Replace($home, "~") } 
else { $location }) + $(if (!$b) {'$ '} else {'# '})
Remove-Variable location
}


$c = [System.DateTime]::Now
$d = $c.Subtract($a)
"PowerShell geladen in " + $d.Milliseconds + " Millisekunden."