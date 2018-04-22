function Get-OpenWindows {
<#
	.SYNOPSIS
		Gibt alle offenen Fenster zurück

	.DESCRIPTION
		Gibt alle offenen Fenster zurück

	.EXAMPLE
		PS C:\> Get-OpenWindows
		Gibt alle offenen Fenster zurück

	.NOTES
		Gibt alle offenen Fenster zurück

	.LINK
		about_comment_based_help

#>


Get-Process | Where-Object { $($_.mainWindowTitle) -ne "" } | Select-Object MainWindowTitle, ProcessName, Company, Responding | Sort-Object -Property Company | Format-list -GroupBy Company -property MainWindowTitle, ProcessName, Responding 
}

function Test-InternetConnection {
ping.exe -w 100 -n 1 www.google.de
}

function MarkType {
	param(
	
	[System.String]
	$type,
	
	[Parameter(ValueFromPipeline=$true)]
		$input
		
		
		
		
	)

	BEGIN {
	$oldcolor = $Host.UI.RawUI.ForegroundColor
	}

	PROCESS {
		foreach ($element in $input)
		{
		if ($element.Extension -eq "." + $type -or $element.Extension -eq $type)
		{
		$Host.UI.RawUI.ForegroundColor = 'red'
		} else {
		$Host.UI.RawUI.ForegroundColor = $oldcolor
		}
		$element
		}
	}

	END {
	$Host.UI.RawUI.ForegroundColor = $oldcolor
	}
}

function Wait-ForKeyPress {
write-host -NoNewline "Drücken Sie eine beliebige Taste . . . "
$w = [System.Console]::ReadKey() > $null
Remove-Variable w
Write-Host ""
}
Add-Type -AssemblyName System.Drawing

function Take-Screenshot {
param(
[System.Int32]
$seconds
)
$bmpScreenCapture = New-Object -Type System.Drawing.Bitmap([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width, [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height)
$g = [System.Drawing.Graphics]::FromImage($bmpScreenCapture)
$g.CopyFromScreen([System.Windows.Forms.Screen]::PrimaryScreen.Bounds.X,
                  [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Y,
                  0, 0,
                  $bmpScreenCapture.Size,
                  [System.Drawing.CopyPixelOperation]::SourceCopy)
$bmpScreenCapture.Save("D:\Desktop\34567.jpg", [System.Drawing.Imaging.ImageFormat]::Jpeg)
}

function Download-File {
param(
[Parameter(Mandatory=$True)][string]$url,
[Parameter(Mandatory=$True)][string]$path)

Invoke-WebRequest $url -OutFile $path
}