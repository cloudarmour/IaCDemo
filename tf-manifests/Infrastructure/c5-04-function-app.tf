# Resource 1: Archive the function  code for the upload purposes.
data "archive_file" "function_app_zip_package" {
  type        = "zip"
  #source_dir  = "../function-app"
  //source_dir = "../../code/backend/api"
  source_dir = "../../code/backend/api/bin/output"
  output_path = "resume-function-app.zip"
  //output_path = "${path.cwd}/resume-function-app.zip"
}

# Resource 2: Upload the archive to the Azure Storage Blob Container
resource "azurerm_storage_blob" "func_zip_package_blob" {
  //name = "${filesha256(var.archive_file.output_path)}.zip"
  name = "${filesha256(data.archive_file.function_app_zip_package.output_path)}.zip"
  //name = "azure.zip"
  storage_account_name = azurerm_storage_account.myFuncStorage.name
  storage_container_name = azurerm_storage_container.myFuncStorage_container.name
  type = "Block"
  //source = "../../code/backend/manualdeployedpackage.zip"
  source = data.archive_file.function_app_zip_package.output_path
}

# Resource 3: Create a function app - the package in blob storage will be placed into the app_settings
resource "azurerm_function_app" "myFunc" {
  depends_on = [azurerm_cosmosdb_account.mycosmosdbaccount]
  name                       = "getresumecounterfunc${random_string.myrandom.result}"
  location                   = azurerm_resource_group.myResumeRG.location
  resource_group_name        = azurerm_resource_group.myResumeRG.name
  app_service_plan_id        = azurerm_app_service_plan.myFuncAsp.id

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "https://${azurerm_storage_account.myFuncStorage.name}.blob.core.windows.net/${azurerm_storage_container.myFuncStorage_container.name}/${azurerm_storage_blob.func_zip_package_blob.name}${data.azurerm_storage_account_blob_container_sas.myFuncStorage_blob_container_sas.sas}",
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet", //found out from the local.settings.json file in my vscode
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.getresumecounter_ai.instrumentation_key,
     //"WEBSITE_RUN_FROM_PACKAGE" = "1",
    "AzureResumeConnectionString" = azurerm_cosmosdb_account.mycosmosdbaccount.connection_strings[0],
  }



  site_config {
    cors {
      allowed_origins = ["*"]
    }
  }

  storage_account_name       = azurerm_storage_account.myFuncStorage.name
  storage_account_access_key = azurerm_storage_account.myFuncStorage.primary_access_key
  os_type="linux"
  version= "~3"

  /* provisioner "local-exec" {
    command = "az webapp deployment source config-zip --resource-group ${azurerm_resource_group.myResumeRG.name} --name ${azurerm_function_app.myFunc.name} --src ${data.archive_file.function_app_zip_package.output_path} --settings SCM_DO_BUILD_DURING_DEPLOYMENT=true"
  } */

}

