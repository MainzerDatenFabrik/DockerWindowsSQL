# escape=`
 
FROM microsoft/mssql-server-windows-developer
 
ENV user_name testuser
ENV user_password test123


 
WORKDIR C:\
 
ADD .\WideWorldImporters-Full.bak C:\
ADD .\Invoke-BuildActions.ps1 C:\
ADD .\Invoke-RunActions.ps1 C:\
 
SHELL ["powershell", "-File"]
 
RUN .\Invoke-BuildActions.ps1
 
EXPOSE 1433
 
CMD .\Invoke-RunActions.ps1 -Username $env:user_name -Password $env:user_password -Verbose


