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
