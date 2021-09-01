function ShowBanner {
    $banner  = @()
    $banner+= $Global:Spacing + ''
$banner+= $Global:Spacing + '     ______                     __        ____             __           '
$banner+= $Global:Spacing + '    / ____/___  ________  _____/ /_      / __ \___  ____  / /___  __  __'
$banner+= $Global:Spacing + '   / /_  / __ \/ ___/ _ \/ ___/ __/_____/ / / / _ \/ __ \/ / __ \/ / / /'
$banner+= $Global:Spacing + '  / __/ / /_/ / /  /  __(__  ) /_/_____/ /_/ /  __/ /_/ / / /_/ / /_/ / '
$banner+= $Global:Spacing + ' /_/    \____/_/   \___/____/\__/     /_____/\___/ .___/_/\____/\__, /  '
$banner+= $Global:Spacing + '                                                /_/            /____/   '
$banner+= $Global:Spacing + '                   PowerShell for Pentesters Version                    '
$banner+= $Global:Spacing + '                 Domain Deployment Script by TheMayor                   '
$banner+= $Global:Spacing + ''
	$banner | foreach-object {
        Write-Host $_ -ForegroundColor "Yellow"
	}
}

function Write-Good { param( $String ) Write-Host $Global:InfoLine $String $Global:InfoLine1 -ForegroundColor 'Green' }
function Write-Info { param( $String ) Write-Host $String -ForegroundColor 'Gray'}
$Global:Spacing = "`t"
$Global:PlusLine = "`t[+]"
$Global:InfoLine = "`t[*]"
$Global:InfoLine1 = "[*]"


function addsInstall {
Write-Good "Installing Windows AD Domain Services Toolset."
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Write-Info "`n`nToolset installed.`n`n"
}

function forestDeploy {
Write-Good "Generating the domain. Make note of the domain name for the ADGenerator Script to be ran after the controller is built."
$DomainNetBiosName = $DomainName.split('.')[0]
Install-ADDSForest -DomainName $DomainName -DomainNetBiosName $DomainNetBiosName -InstallDNS:$true
Write-Info "`n`nRestart the controller if not instructed."
}

function Invoke-ForestDeploy {
	Param(
	[Parameter(Mandatory=$True)]
	[ValidateNotNullOrEmpty()]
	[System.String]
	$DomainName
)
ShowBanner
addsInstall
forestDeploy
}
