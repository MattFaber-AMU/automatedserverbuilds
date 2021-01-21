#this builds out a sample server, more to follow
function New-VMwareConnection{
    param(
        [Parameter(Mandatory=$True)]
        [String] $VMhostname
    )
    try{
        Connect-VIServer –Server $VMhostname
    } catch {
        Write-Error -Message 'Connection Failed, please try a new host or re enter your credentials'
    }
}


function New-BlankServer{
    Param(
        [Parameter(Mandatory=$true)]
        [string] $VMhostname,
        [string] $newservername,
        [string] $datastorename, 
        [int] $disksizeingb,
        [int] $memoryingb,
        [int] $cpunum,
        [string] $NameOfNetwork
    )
    #this connects to a vmware host and creates a server
    try{

        New-VM -Name $newservername –VMHost $VMhostname -Datastore $datastorename 
        -DiskGB $disksizeingb -MemoryGB $memoryingb -NumCpu $cpunum -NetworkName $NameOfNetwork
    } catch {
        Write-Error -Message "Invalid data caused exception, please double check your variables"
    }
}

#do this after the following have been completed: o create a template, create a new virtual machine, 
#install the OS and configure any settings you would like to standardize with future virtual machines. 
#Then you either clone or convert that virtual machine for a template.
function New-Template{
    Param(
        
    )
    try{
        New-OSCustomizationSpec -Name 'WindowsServer2012' -FullName 'TestName' -OrgName 'TestOrg' -OSType Windows -ChangeSid
         -AdminPassword (Read-Host -AsSecureString) -Domain 'DOMAIN' -TimeZone 035 -DomainCredentials (Get-Credential) -ProductKey '1111-1111-1111-1111' -AutoLogonCount 1
    } catch {
        Write-Error -Message "Data was invalid, please try again. Also see comment at the top, be sure to have those finished."
    }
}