Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module SqlServer -Force -AllowClobber

Import-Module SqlServer

New-Item -Type Directory -Path C:\SqlData

Invoke-Sqlcmd -ServerInstance localhost -Query `
"USE [master] RESTORE DATABASE [WideWorldImporters]
FROM DISK = N'C:\WideWorldImporters-Full.bak' 
WITH MOVE N'WWI_Primary' TO N'C:\SqlData\WideWorldImporters.mdf', 
MOVE N'WWI_UserData' TO N'C:\SqlData\WideWorldImporters_UserData.ndf', 
MOVE N'WWI_Log' TO N'C:\SqlData\WideWorldImporters.ldf', 
MOVE N'WWI_InMemory_Data_1' TO N'C:\SqlData\WorldWideImporters_InMemory_Data_1'"
