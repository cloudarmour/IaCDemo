resource "azurerm_application_insights" "getresumecounter_ai" {
  name                = "getresumecounterai"
  resource_group_name      = azurerm_resource_group.myResumeRG.name
  location                 = azurerm_resource_group.myResumeRG.location
  application_type    = "web"
}