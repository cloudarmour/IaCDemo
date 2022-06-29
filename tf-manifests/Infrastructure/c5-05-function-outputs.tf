output "app_insights_instrumentation_key" {
  value = azurerm_application_insights.getresumecounter_ai.instrumentation_key
  sensitive = true
  
}

output "app_insights_id" {
  value = azurerm_application_insights.getresumecounter_ai.app_id
}

output "function_app_default_hostname" {

  description = "Deployed function app hostname"
  value = azurerm_function_app.myFunc.default_hostname
  
}

output "function_app_id" {

  value = azurerm_function_app.myFunc.id
  
}


output "function_app_kind" {

  value = azurerm_function_app.myFunc.kind
  
}

output "function_app_name" {
  
  description = "Deployed function app name"
  value = azurerm_function_app.myFunc.name
  
}

output "func_app_url" {
  value = "https://${azurerm_function_app.myFunc.default_hostname}/api/${local.func_app_name}?code=${data.azurerm_function_app_host_keys.myfunckeys.default_function_key}"
  sensitive = true
}
