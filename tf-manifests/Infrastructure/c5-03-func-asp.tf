resource "azurerm_app_service_plan" "myFuncAsp" {
  name                = "my-IaC-functions-service-plan"
  resource_group_name      = azurerm_resource_group.myResumeRG.name
  location                 = azurerm_resource_group.myResumeRG.location
  kind                     = "FunctionApp"
  ##kind                = "Linux"
  reserved = true
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}