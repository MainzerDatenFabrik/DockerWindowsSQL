# Warning: The parameter "isolation" is as of docker version 19.03.8, build afacb8b not properly supported in compose files. Due to this, this script will fail with the following 
# error: The container operating system does not match the host operating system.
# The current work around for this is to add the "isolation" parameter to the exe-args of docker. This is done, by adding the followin line to the file located
# at "C:\ProgramFiles\Docker\resources\windows-daemon-options.sjon": "exec-opts": ["isolation=hyperv"]

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module SqlServer -Force -AllowClobber

Import-Module SqlServer

New-Item -Type Directory -Path C:\SqlData

Invoke-Sqlcmd -ServerInstance localhost -Query `
"USE [master] RESTORE DATABASE [WideWorldImporters] `
FROM DISK = N'C:\WideWorldImporters-Full.bak' `
WITH MOVE N'WWI_Primary' TO N'C:\SqlData\WideWorldImporters.mdf', `
MOVE N'WWI_UserData' TO N'C:\SqlData\WideWorldImporters_UserData.ndf', `
MOVE N'WWI_Log' TO N'C:\SqlData\WideWorldImporters.ldf', `
MOVE N'WWI_InMemory_Data_1' TO N'C:\SqlData\WorldWideImporters_InMemory_Data_1'"