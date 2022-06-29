# Storage Account Outputs
output "storage_account_primary_access_key" {
  value = azurerm_storage_account.resume_static_storage.primary_access_key
  sensitive = true
}
output "storage_account_name" {
   value = azurerm_storage_account.resume_static_storage.name 
}
output "storage_account_primary_web_endpoint" {
  value = azurerm_storage_account.resume_static_storage.primary_web_endpoint
}
output "storage_account_primary_web_host" {
  value = azurerm_storage_account.resume_static_storage.primary_web_host
}
