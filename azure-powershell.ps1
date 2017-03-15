# -------------------------------------------------------------------------------------- #
# -------------------------- Azure Powershell Commands --------------------------------- #
# -------------------------------------------------------------------------------------- #

# This file is a collection of Azure Powershell Commands.
# It can be used to quickly look up certain commands.
# This enables you to faster deploy and manage resources on Azure.

# You might encounter issues trying to run the Azure Cmdlets if the necessary installations have not been made.
# Remember to run as administrator when installing all the modules.
# If you use a Windows version before Windows 10, you will need to install

# -------------------------------------------------------------------------------------- #
# ------------------------------ Getting Started --------------------------------------- #
# -------------------------------------------------------------------------------------- #

# Install the Azure Resource Manager modules from the PowerShell Gallery
Install-Module AzureRM

# Before you can execute commands, you need to add your Azure account
# You can add different parameters. This is the simple version.
Add-AzureAccount -Environment MyEnvironment

# Login to Azure Account
$cred = Get-Credential
Login-AzureRmAccount -Credential $cred

# Simple login - You will be prompted to login in a browser.
Login-AzureRmAccount

# To view all subscriptions for your account
Get-AzureRmSubscription

# To select a default subscription for your current session.
# This is useful when you have multiple subscriptions.
Get-AzureRmSubscription -SubscriptionName "your sub" | Select-AzureRmSubscription

# View your current Azure PowerShell session context
# This session state is only applicable to the current session and will not affect other sessions
Get-AzureRmContext

# To select the default storage context for your current session
Set-AzureRmCurrentStorageAccount -ResourceGroupName "your resource group" -StorageAccountName "your storage account name"

# View your current Azure PowerShell session context
# Note: the CurrentStorageAccount is now set in your session context
Get-AzureRmContext

# To list all of the blobs in all of your containers in all of your accounts
Get-AzureRmStorageAccount | Get-AzureStorageContainer | Get-AzureStorageBlob

# -------------------------------------------------------------------------------------- #
# ------------------------- Account and Subscription Details --------------------------- #
# -------------------------------------------------------------------------------------- #

# Display available accounts
Get-AzureAccount

# Display your Azure Subscriptions
Get-AzureRmSubscription

# -------------------------------------------------------------------------------------- #
# ----------------------------------- ARM Templates ------------------------------------ #
# -------------------------------------------------------------------------------------- #

# Create a new resource group and deploy an ARM template
New-AzureRmResourceGroup -Name ExampleResourceGroup -Location "West US"
New-AzureRmResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName ExampleResourceGroup -TemplateFile c:\MyTemplates\example.json -TemplateParameterFile c:\MyTemplates\example.params.json

# -------------------------------------------------------------------------------------- #
# -------------------------------------- Account --------------------------------------- #
# -------------------------------------------------------------------------------------- #

$subscr="<subscription name>"
$staccount="<storage account name>"
Select-AzureSubscription -SubscriptionName $subscr –Current
Set-AzureSubscription -SubscriptionName $subscr -CurrentStorageAccountName $staccount

# -------------------------------------------------------------------------------------- #
# ------------------------------ Automation Variables ---------------------------------- #
# -------------------------------------------------------------------------------------- #

# Create a new variable with Powershell
New-AzureRmAutomationVariable -ResourceGroupName "ResouceGroup01"
–AutomationAccountName "MyAutomationAccount" –Name 'MyStringVariable' `
–Encrypted $false –Value 'My String'
$string = (Get-AzureRmAutomationVariable -ResourceGroupName "ResouceGroup01" `
–AutomationAccountName "MyAutomationAccount" –Name 'MyStringVariable').Value

# -------------------------------------------------------------------------------------- #
# ----------------------------- Runbook with Powershell -------------------------------- #
# -------------------------------------------------------------------------------------- #

# Start a test runbook
Start-AzureRmAutomationRunbook -AutomationAccountName "MyAutomationAccount" -Name "Test-Runbook" -ResourceGroupName "ResourceGroup01"

# Starts the runbook and waits until completed. Then it will show the output.
$runbookName = "Test-Runbook"
$ResourceGroup = "ResourceGroup01"
$AutomationAcct = "MyAutomationAccount"

$job = Start-AzureRmAutomationRunbook –AutomationAccountName $AutomationAcct -Name $runbookName -ResourceGroupName $ResourceGroup

$doLoop = $true
While ($doLoop) {
   $job = Get-AzureRmAutomationJob –AutomationAccountName $AutomationAcct -Id $job.JobId -ResourceGroupName $ResourceGroup
   $status = $job.Status
   $doLoop = (($status -ne "Completed") -and ($status -ne "Failed") -and ($status -ne "Suspended") -and ($status -ne "Stopped"))
}

Get-AzureRmAutomationJobOutput –AutomationAccountName $AutomationAcct -Id $job.JobId -ResourceGroupName $ResourceGroup –Stream Output

# This sample shows the parameters you can provide to the runbook
$params = @{"FirstName"="Joe";"LastName"="Smith";"RepeatCount"=2;"Show"=$true}
Start-AzureRmAutomationRunbook –AutomationAccountName "MyAutomationAccount" –Name "Test-Runbook" -ResourceGroupName "ResourceGroup01" –Parameters $params

# Retrieve the job status of a runbook
$job = (Get-AzureRmAutomationJob –AutomationAccountName "MyAutomationAccount" `
–RunbookName "Test-Runbook" -ResourceGroupName "ResourceGroup01" | sort LastModifiedDate –desc)[0]
$job.Status
$job.JobParameters
Get-AzureRmAutomationJobOutput -ResourceGroupName "ResourceGroup01" `
–AutomationAccountName "MyAutomationAcct" -Id $job.JobId –Stream Output


# -------------------------------------------------------------------------------------- #
# --------------------------------- Machine Learning ----------------------------------- #
# -------------------------------------------------------------------------------------- #

# Export Commands
# Exports a web service definition object as JSON.
Export-AzureRmMlWebService

# Export to a string
Export-AzureRmMlWebService -WebService $SVC -ToJsonString

# Export to a file
Export-AzureRmMlWebService -WebService $SVC -OutputFile "C:\mlservice.json"


# Get access keys
# Gets the web service keys from a web service.
Get-AzureRmMlWebServiceKeys

# In a specific web service b resource group and name
Get-AzureRmMlWebServiceKeys -ResourceGroupName "RG004" -Name "Webservice004"

# Get access to a web service instance
Get-AzureRmMlWebServiceKeys -MlWebService $MlService


# Summary information
# Gets summary information about one or more web services.
Get-AzureRmMlWebService

# Information on a specific web service
Get-AzureRmMlWebService -ResourceGroupName "RG001" -Name "WebService003"

# All web services in a resource group
Get-AzureRmMlWebService -ResourceGroupName "RG005"


# Web service import
# Imports a web service definition to an object instance.
Import-AzureRmMlWebService

# Import a definition from a string
Import-AzureRmMlWebService -JsonString $JSONDefinition

# Import a definition from a file path
Import-AzureRmMlWebService -InputFile "C:\mlservice.json"


# Create new web service
# Creates a web service resource.
New-AzureRmMlWebService

# Creates a new resource from a json file
New-AzureRmMlWebService -ResourceGroupName "RG001" -Name "WebService002" -Location "South Central US" -DefinitionFile "C:\mlservice.json"

# Create one from an object instance
New-AzureRmMlWebService -ResourceGroupName "RG004" -Name "WebService005" -Location "South Central US" -NewWebServiceDefinition $ServiceDefinitionObject

# Remove a web service
# Removes an Azure Machine Learning web service resource.
Remove-AzureRmMlWebService

# Remove resource in resource group
Remove-AzureRmMlWebService -ResourceGroupName "RG001" -Name "WebService001"

# Update web service resource
# Updates properties of an existing web service resource.
Update-AzureRmMlWebService

# Update properties of specific web service
Update-AzureRmMlWebService -ResourceGroupName "RG002" -Name "WebService002" -Description "new update to description" -Keys @{Primary='changed primary key'} -Diagnostics @{Level='All'}
