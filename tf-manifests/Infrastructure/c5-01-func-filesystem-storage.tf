# Resource 1: Storage account to host the file system of the container running our function app. This is where the code will be uploaded as well as where logs and any temporary files will be written to.

resource "azurerm_storage_account" "myFuncStorage" {
  name                     = "myIaCDemofuncstorage"
  resource_group_name      = azurerm_resource_group.myResumeRG.name
  location                 = azurerm_resource_group.myResumeRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Resource 2: Container to create the blob for function zip package upload
resource "azurerm_storage_container" "myFuncStorage_container" {
    name = "myfunc-zip-storage-container"
    storage_account_name = azurerm_storage_account.myFuncStorage.name
    container_access_type = "private"
}

# Resource 3: Blob SAS for function to access the zip package for deployment

data "azurerm_storage_account_blob_container_sas" "myFuncStorage_blob_container_sas" {
  connection_string = azurerm_storage_account.myFuncStorage.primary_connection_string
  container_name    = azurerm_storage_container.myFuncStorage_container.name
  
  start = "2022-06-28T00:00:00Z"
  expiry = "2023-01-01T00:00:00Z"

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}


