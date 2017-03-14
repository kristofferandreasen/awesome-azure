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
