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

#creates a new blank server with no OS. Good for testing or setting up something that you need to install linux on
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
        [Parameter(Mandatory=$true)]
        [String] $templateName,
        [String] $servername,
        [String] $organization,
        [String] $domain,
        [String] $productKey
    )
    try{
        New-OSCustomizationSpec -Name $templateName -FullName $servername -OrgName $organization -OSType Windows -ChangeSid
         -AdminPassword (Read-Host -AsSecureString) -Domain $domain -TimeZone 035 -DomainCredentials (Get-Credential) -ProductKey $productKey -AutoLogonCount 1
    } catch {
        Write-Error -Message "Data was invalid, please try again. Also see comment at the top, be sure to have those finished."
    }
}