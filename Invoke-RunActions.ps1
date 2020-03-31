Param (
    [Parameter(Mandatory=$true)][string] $Username,
    [Parameter(Mandatory=$true)][string] $Password
)
 
# If $Username or $Password is a variable, resolve them.
if($Username -like "$*") {
    $Username = Invoke-Expression -Command $Username
}
if($Password -like "$*") {
    $Password = Invoke-Expression -Command $Password
}
 
# Validate $Username and $Password are not defaults
if($Username -eq "_") {
    Write-Host "ERROR: A name for the new user account is required. Please supply a '--env user_name' variable with the 'docker run' command."
    Exit(1)
}
if($Password -eq "_") {
    Write-Host "ERROR: A password for the new user account is required. Please supply a '--env user_password' variable with the 'docker run' command."
    Exit(1)
}
 
# Create login for user.
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword
Add-SqlLogin -ServerInstance localhost -LoginName $Username -LoginType SqlLogin -DefaultDatabase WideWorldImporters -Enable -GrantConnectSql -LoginPSCredential $Credential | Out-Null
Write-Verbose "Created SQL login for user $Username."
 
# Create user for WideWorldImporters database

$Server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList localhost
$Database = $Server.Databases['WideWorldImporters']
 
$User = New-Object -TypeName Microsoft.SqlServer.Management.Smo.User -ArgumentList $Database, $Username
$User.Login = $Username
$User.Create()
Write-Verbose "Created user $Username."
 
# Assign user to roles with read and write privileges.
Invoke-Sqlcmd -ServerInstance localhost -Database WideWorldImporters -Query "ALTER ROLE db_datareader ADD MEMBER $Username"
Invoke-Sqlcmd -ServerInstance localhost -Database WideWorldImporters -Query "ALTER ROLE db_datawriter ADD MEMBER $Username"
Write-Verbose "Granted user $Username read and write access to Database: WideWorldImporters."
 
