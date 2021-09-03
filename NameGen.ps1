# This PS1 script is used to generate the appropriate name for your workstations, i.e. Workstation-01 or Workstation-02. Not for use on your Domain Controller.
# Run this script from an elevated command prompt and enter your credentials when prompted.  The computer will be renamed at the DC and a file share will be
# generated on the Workstation created for you to use across the exercises. 

function renamePC {
$username = whoami
Rename-computer -NewName $ComputerName -DomainCredential $username
}

function Share {
mkdir C:\Shared; new-smbshare -Name "Shared" -Path "C:\Shared" -FullAccess "Users"
}

function enableRDPRemoting {
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
}

function executeScript {
	Param(
	[Parameter(Mandatory=$True)]
	[ValidateNotNullOrEmpty()]
	[System.String]
	$ComputerName
)
renamePC
Share
}
